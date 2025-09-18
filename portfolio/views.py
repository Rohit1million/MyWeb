from django.conf import settings
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect, get_object_or_404

# Django authentication
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.decorators import login_required

# Django utilities
from django.utils import timezone
from django.utils.html import strip_tags

# Django decorators
from django.views.decorators.csrf import csrf_protect, csrf_exempt
from django.views.decorators.cache import never_cache
from django.views.decorators.debug import sensitive_post_parameters
from django.views.decorators.http import require_http_methods

# Django CSRF and middleware
from django.middleware.csrf import get_token

# Django validation and exceptions
from django.core.exceptions import ValidationError
from django.core.validators import validate_email

# Django email functionality
from django.core.mail import send_mail, EmailMultiAlternatives
from django.template.loader import render_to_string

# Python standard library
import json
import logging

from .models import (
    PersonalInfo, QuickInfo, SkillCategories, Skills, 
    Education, Experience, Projects, ProjectCategories, 
    Certifications, Contacts, SiteSettings
)

# Set up logging
logger = logging.getLogger(__name__)


def home(request):
    """Single-page app home view with all content sections"""
    try:
        personal_info = PersonalInfo.objects.first()
        quick_infos = QuickInfo.objects.filter(active=1).order_by('display_order')
        
        # Experience data
        featured_experience = Experience.objects.filter(featured=1)[:3]
        all_experience = Experience.objects.filter(show_on_resume=1).order_by('-start_date')
        
        # Skills data
        featured_skills = Skills.objects.filter(featured=1, active=1)
        skill_categories = SkillCategories.objects.filter(show_on_home=1).order_by('display_order')
        
        # Projects data
        featured_projects = Projects.objects.filter(featured=1, published=1)[:6]
        all_projects = Projects.objects.filter(published=1).order_by('-featured', '-start_date')
        project_categories = ProjectCategories.objects.all().order_by('display_order')
        
        # Education and certifications
        education_list = Education.objects.filter(featured=1).order_by('-start_date')
        certifications = Certifications.objects.filter(featured=1).order_by('-issue_date')
        
        context = {
            'personal_info': personal_info,
            'quick_infos': quick_infos,
            'featured_experience': featured_experience,
            'all_experience': all_experience,
            'featured_skills': featured_skills,
            'skill_categories': skill_categories,
            'featured_projects': featured_projects,
            'all_projects': all_projects,
            'project_categories': project_categories,
            'education_list': education_list,
            'certifications': certifications,
        }
        
        return render(request, 'home/home.html', context)
        
    except Exception as e:
        logger.error(f"Error in home view: {str(e)}")
        messages.error(request, "Sorry, there was an error loading the page.")
        return render(request, 'home/home.html', {'personal_info': None})


def project_detail(request, slug):
    """Individual project detail page"""
    try:
        project = get_object_or_404(Projects, slug=slug, published=1)
        
        related_projects = Projects.objects.filter(
            category=project.category, 
            published=1
        ).exclude(id=project.id)[:3]
        
        # Increment view count safely
        Projects.objects.filter(id=project.id).update(views=project.views + 1)
        
        context = {
            'project': project,
            'related_projects': related_projects,
            'personal_info': PersonalInfo.objects.first(),
        }
        
        return render(request, 'portfolio/project_detail.html', context)
        
    except Projects.DoesNotExist:
        messages.error(request, "The requested project was not found.")
        return redirect('home')
    except Exception as e:
        logger.error(f"Error in project_detail view: {str(e)}")
        messages.error(request, "Sorry, there was an error loading the project.")
        return redirect('home')


def test_data(request):
    """Simple test view to check database connection"""
    try:
        personal_count = PersonalInfo.objects.count()
        skills_count = Skills.objects.count()
        projects_count = Projects.objects.count()
        experience_count = Experience.objects.count()
        
        personal = PersonalInfo.objects.first()
        
        data = {
            'personal_info_count': personal_count,
            'skills_count': skills_count,
            'projects_count': projects_count,
            'experience_count': experience_count,
            'personal_name': personal.name if personal else 'No data',
            'personal_title': personal.title if personal else 'No data',
        }
        
        return render(request, 'portfolio/test_data.html', {'data': data})
        
    except Exception as e:
        logger.error(f"Database connection error: {str(e)}")
        return HttpResponse(f"Database connection error: {str(e)}")


# Authentication Views
@sensitive_post_parameters('password')
@csrf_protect
@never_cache
def custom_login_view(request):
    """Custom login view with AJAX support"""
    if request.user.is_authenticated:
        next_url = request.GET.get('next', '/')
        return redirect(next_url)
    
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            
            user = authenticate(request, username=username, password=password)
            
            if user is not None and user.is_active:
                login(request, user)
                success_message = f'Welcome back, {user.get_full_name() or user.username}!'
                
                # Handle AJAX requests
                if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                    return JsonResponse({
                        'success': True,
                        'message': success_message,
                        'redirect': request.POST.get('next') or request.GET.get('next') or '/'
                    })
                
                messages.success(request, success_message)
                next_url = request.POST.get('next') or request.GET.get('next') or '/'
                return redirect(next_url)
            else:
                error_message = 'Your account is disabled. Please contact the administrator.' if user else 'Authentication failed.'
                
                if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                    return JsonResponse({'success': False, 'error': error_message})
                
                messages.error(request, error_message)
        else:
            error_message = 'Invalid username or password.'
            
            if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
                return JsonResponse({
                    'success': False, 
                    'error': error_message,
                    'form_errors': form.errors.as_json() if form.errors else None
                })
            
            messages.error(request, error_message)
    else:
        form = AuthenticationForm()
    
    context = {
        'form': form,
        'title': 'Login - Portfolio',
        'next': request.GET.get('next', ''),
    }
    
    return render(request, 'home/login.html', context)


@never_cache
def custom_logout_view(request):
    """Custom logout view"""
    if request.user.is_authenticated:
        username = request.user.get_full_name() or request.user.username
        logout(request)
        messages.success(request, f'Goodbye {username}! You have been successfully logged out.')
    else:
        messages.info(request, 'You were not logged in.')
    
    return redirect('/')


# Contact Form Handling
@require_http_methods(["POST"])
def contact_submit(request):
    """Handle contact form submissions via AJAX"""
    try:
        # Get form data
        form_data = {
            'name': request.POST.get('full_name', '').strip(),
            'email': request.POST.get('email', '').strip(),
            'subject': request.POST.get('subject', '').strip(),
            'message': request.POST.get('message', '').strip(),
            'phone': request.POST.get('phone', '').strip(),
            'company': request.POST.get('company', '').strip(),
        }
        
        # Validate form data
        validation_errors = validate_contact_form(form_data)
        
        if validation_errors:
            return JsonResponse({
                'success': False,
                'errors': validation_errors
            })
        
        # Create contact record
        contact_record = Contacts.objects.create(
            name=form_data['name'],
            email=form_data['email'],
            subject=form_data['subject'] or f"Contact from {form_data['name']}",
            message=form_data['message'],
            phone=form_data['phone'] or None,
            company=form_data['company'] or None,
            is_read=0,
            is_replied=0,
            created_at=timezone.now()
        )
        
        # Send email notifications
        personal_info = PersonalInfo.objects.first()
        email_sent = send_contact_emails(contact_record, personal_info)
        
        # Log successful submission
        logger.info(f"Contact form submission from {form_data['email']} (ID: {contact_record.id})")
        
        # Return success response
        success_message = "Thank you for your message! We'll get back to you soon."
        if not email_sent:
            success_message = "Your message has been saved. We'll get back to you soon."
            
        return JsonResponse({
            'success': True,
            'message': success_message
        })
        
    except Exception as e:
        logger.error(f"Error in contact form submission: {str(e)}")
        return JsonResponse({
            'success': False,
            'errors': ["Sorry, there was an error sending your message. Please try again."]
        })


def validate_contact_form(form_data):
    """Validate contact form data and return list of errors"""
    errors = []
    
    # Name validation
    if not form_data['name']:
        errors.append("Full name is required.")
    elif len(form_data['name']) > 100:
        errors.append("Name must be less than 100 characters.")
    
    # Email validation
    if not form_data['email']:
        errors.append("Email is required.")
    else:
        try:
            validate_email(form_data['email'])
        except ValidationError:
            errors.append("Please enter a valid email address.")
        if len(form_data['email']) > 254:
            errors.append("Email must be less than 254 characters.")
    
    # Message validation
    if not form_data['message']:
        errors.append("Message is required.")
    
    # Optional field length validation
    if form_data['subject'] and len(form_data['subject']) > 200:
        errors.append("Subject must be less than 200 characters.")
    
    if form_data['phone'] and len(form_data['phone']) > 20:
        errors.append("Phone number must be less than 20 characters.")
    
    if form_data['company'] and len(form_data['company']) > 100:
        errors.append("Company name must be less than 100 characters.")
    
    return errors


def send_contact_emails(contact_record, personal_info):
    """Send email notifications for contact form submissions"""
    try:
        # Determine recipient email
        recipient_email = get_contact_recipient_email(personal_info)
        
        if not recipient_email:
            logger.error("No recipient email configured for contact form")
            return False
        
        # Send admin notification
        admin_email_sent = send_admin_notification(contact_record, recipient_email)
        
        # Send user confirmation
        user_email_sent = send_user_confirmation(contact_record, personal_info)
        
        if admin_email_sent or user_email_sent:
            logger.info(f"Contact emails sent for submission ID: {contact_record.id}")
            return True
        else:
            logger.warning(f"Failed to send emails for submission ID: {contact_record.id}")
            return False
            
    except Exception as e:
        logger.error(f"Error sending contact emails: {str(e)}")
        return False


def get_contact_recipient_email(personal_info):
    """Get the recipient email for contact notifications"""
    # Try settings first
    recipient_email = getattr(settings, 'CONTACT_EMAIL', None)
    
    # Fall back to personal info
    if not recipient_email and personal_info and personal_info.email:
        recipient_email = personal_info.email
    
    # Final fallback to default from email
    if not recipient_email:
        recipient_email = getattr(settings, 'DEFAULT_FROM_EMAIL', None)
    
    return recipient_email


def send_admin_notification(contact_record, recipient_email):
    """Send notification email to admin"""
    try:
        subject = f"New Contact Form Submission - {contact_record.subject}"
        
        # Try to render HTML template, fallback to plain text
        try:
            context = {
                'contact': contact_record,
                'site_name': getattr(settings, 'SITE_NAME', 'Your Website'),
            }
            html_content = render_to_string('emails/contact_admin.html', context)
            text_content = strip_tags(html_content)
            
            # Send HTML email
            email = EmailMultiAlternatives(
                subject=subject,
                body=text_content,
                from_email=getattr(settings, 'DEFAULT_FROM_EMAIL', 'noreply@yoursite.com'),
                to=[recipient_email],
                reply_to=[contact_record.email]
            )
            email.attach_alternative(html_content, "text/html")
            email.send()
            
        except Exception:
            # Fallback to plain text email
            text_content = create_admin_text_email(contact_record)
            send_mail(
                subject=subject,
                message=text_content,
                from_email=getattr(settings, 'DEFAULT_FROM_EMAIL', 'noreply@yoursite.com'),
                recipient_list=[recipient_email],
                fail_silently=False,
            )
        
        return True
        
    except Exception as e:
        logger.error(f"Error sending admin notification: {str(e)}")
        return False


def send_user_confirmation(contact_record, personal_info):
    """Send confirmation email to user"""
    try:
        subject = f"Thank you for contacting us - {contact_record.subject}"
        
        # Try to render HTML template, fallback to plain text
        try:
            context = {
                'contact': contact_record,
                'site_name': getattr(settings, 'SITE_NAME', 'Our Website'),
                'personal_info': personal_info,
            }
            html_content = render_to_string('emails/contact_confirmation.html', context)
            text_content = strip_tags(html_content)
            
            # Send HTML email
            email = EmailMultiAlternatives(
                subject=subject,
                body=text_content,
                from_email=getattr(settings, 'DEFAULT_FROM_EMAIL', 'noreply@yoursite.com'),
                to=[contact_record.email]
            )
            email.attach_alternative(html_content, "text/html")
            email.send()
            
        except Exception:
            # Fallback to plain text email
            text_content = create_user_text_email(contact_record)
            send_mail(
                subject=subject,
                message=text_content,
                from_email=getattr(settings, 'DEFAULT_FROM_EMAIL', 'noreply@yoursite.com'),
                recipient_list=[contact_record.email],
                fail_silently=False,
            )
        
        return True
        
    except Exception as e:
        logger.error(f"Error sending user confirmation: {str(e)}")
        return False


def create_admin_text_email(contact_record):
    """Create plain text admin notification email"""
    return f"""
New contact form submission received:

From: {contact_record.name}
Email: {contact_record.email}
Phone: {contact_record.phone or 'Not provided'}
Company: {contact_record.company or 'Not provided'}
Subject: {contact_record.subject}

Message:
{contact_record.message}

Submitted: {contact_record.created_at}
    """.strip()


def create_user_text_email(contact_record):
    """Create plain text user confirmation email"""
    site_name = getattr(settings, 'SITE_NAME', 'Our Team')
    return f"""
Hi {contact_record.name},

Thank you for contacting us! We have received your message and will get back to you as soon as possible.

Your message:
Subject: {contact_record.subject}
Message: {contact_record.message}

We typically respond within 24 hours during business days.

Best regards,
{site_name}
    """.strip()


# Utility Views
@require_http_methods(["GET"])
def get_csrf_token(request):
    """Utility view to get CSRF token for AJAX requests"""
    return JsonResponse({
        'csrfToken': get_token(request)
    })


# Admin Views
@login_required
def admin_dashboard(request):
    """Simple admin dashboard view"""
    if not request.user.is_staff:
        messages.error(request, "You don't have permission to access the admin dashboard.")
        return redirect('/')
    
    try:
        context = {
            'total_projects': Projects.objects.count(),
            'published_projects': Projects.objects.filter(published=1).count(),
            'total_skills': Skills.objects.count(),
            'active_skills': Skills.objects.filter(active=1).count(),
            'user': request.user,
        }
        
        return render(request, 'admin/dashboard.html', context)
        
    except Exception as e:
        logger.error(f"Error in admin_dashboard view: {str(e)}")
        messages.error(request, "Error loading admin dashboard.")
        return redirect('/')


# Error handlers
def handler404(request, exception):
    """Custom 404 error handler"""
    return render(request, 'errors/404.html', status=404)


def handler500(request):
    """Custom 500 error handler"""
    return render(request, 'errors/500.html', status=500)


def handler403(request, exception):
    """Custom 403 error handler"""
    return render(request, 'errors/403.html', status=403)