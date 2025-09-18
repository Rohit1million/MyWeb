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

# Django decorators
from django.views.decorators.csrf import csrf_protect
from django.views.decorators.cache import never_cache
from django.views.decorators.debug import sensitive_post_parameters
from django.views.decorators.http import require_http_methods

# Django CSRF and middleware
from django.middleware.csrf import get_token

# Django validation and exceptions
from django.core.exceptions import ValidationError
from django.core.validators import validate_email

# Django email functionality
from django.core.mail import send_mail

# Python standard library
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
        
        # Projects data with images
        featured_projects = Projects.objects.filter(featured=1, published=1).prefetch_related('projectimages_set')[:6]
        all_projects = Projects.objects.filter(published=1).order_by('-featured', '-start_date').prefetch_related('projectimages_set')
        project_categories = ProjectCategories.objects.all().order_by('display_order')
        
        # Add primary image for each project
        for project in featured_projects:
            project.primary_image = project.projectimages_set.order_by('display_order').first()
        
        for project in all_projects:
            project.primary_image = project.projectimages_set.order_by('display_order').first()
        
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
        
    except Exception as e:
        logger.error(f"Error in home view: {str(e)}")
        messages.error(request, "Sorry, there was an error loading the page.")
        return render(request, 'home/home.html', {'personal_info': None})


def contact_view(request):
    """Display the contact page"""
    try:
        personal_info = PersonalInfo.objects.first()
        context = {
            'personal_info': personal_info,
        }
        return render(request, 'contact.html', context)  # Remove 'templates/'
        
    except Exception as e:
        logger.error(f"Error in contact view: {str(e)}")
        return render(request, 'contact.html', {'personal_info': None})  # Remove 'templates/' here too

@require_http_methods(["POST"])
def contact_submit(request):
    """Handle contact form submissions"""
    try:
        # Get form data
        full_name = request.POST.get('full_name', '').strip()
        email = request.POST.get('email', '').strip()
        message = request.POST.get('message', '').strip()
        
        # Validate required fields
        if not full_name:
            messages.error(request, "Full name is required.")
            return redirect('/')
            
        if not email:
            messages.error(request, "Email is required.")
            return redirect('/')
            
        if not message:
            messages.error(request, "Message is required.")
            return redirect('/')
        
        # Validate email format
        try:
            validate_email(email)
        except ValidationError:
            messages.error(request, "Please enter a valid email address.")
            return redirect('/')
        
        # Save to database
        contact_record = Contacts.objects.create(
            name=full_name,
            email=email,
            subject=f"Contact from {full_name}",
            message=message,
            phone=None,
            company=None,
            is_read=0,
            is_replied=0,
            created_at=timezone.now()
        )
        
        # Send email notification
        email_sent = send_contact_email(contact_record)
        
        # Log submission
        logger.info(f"Contact form submission from {email} (ID: {contact_record.id})")
        
        # Success message
        if email_sent:
            messages.success(request, "Your message has been sent! I'll get back to you soon.")
        else:
            messages.success(request, "Your message has been sent! I'll get back to you soon.")
            
        return redirect('/')  # Redirect to home page
        
    except Exception as e:
        logger.error(f"Error in contact form submission: {str(e)}")
        messages.error(request, "Sorry, there was an error sending your message. Please try again.")
        return redirect('/')  # Redirect to home page


def send_contact_email(contact_record):
    """Send email notification for contact form submission"""
    try:
        # Get recipient email
        personal_info = PersonalInfo.objects.first()
        recipient_email = None
        
        if personal_info and personal_info.email:
            recipient_email = personal_info.email
        else:
            recipient_email = getattr(settings, 'CONTACT_EMAIL', None)
            
        if not recipient_email:
            recipient_email = getattr(settings, 'DEFAULT_FROM_EMAIL', None)
        
        if not recipient_email:
            logger.error("No recipient email configured")
            return False
        
        # Email content
        subject = f"New Contact Form Message from {contact_record.name}"
        message = f"""
New contact form submission:

From: {contact_record.name}
Email: {contact_record.email}
Submitted: {contact_record.created_at.strftime('%Y-%m-%d %H:%M:%S')}

Message:
{contact_record.message}

---
Reply directly to this email to respond to {contact_record.name}.
        """.strip()
        
        # Send email - Fixed reply_to parameter
        send_mail(
            subject=subject,
            message=message,
            from_email=getattr(settings, 'DEFAULT_FROM_EMAIL', 'noreply@yoursite.com'),
            recipient_list=[recipient_email],
            fail_silently=False,
        )
        
        # Send confirmation to user
        try:
            confirmation_subject = "Thank you for contacting me"
            confirmation_message = f"""
Hi {contact_record.name},

Thank you for reaching out! I've received your message and will get back to you as soon as possible.

Your message:
"{contact_record.message}"

Best regards,
{personal_info.name if personal_info else 'Portfolio Team'}
            """.strip()
            
            send_mail(
                subject=confirmation_subject,
                message=confirmation_message,
                from_email=getattr(settings, 'DEFAULT_FROM_EMAIL', 'noreply@yoursite.com'),
                recipient_list=[contact_record.email],
                fail_silently=True,
            )
        except:
            pass  # Don't fail if confirmation email fails
        
        return True
        
    except Exception as e:
        logger.error(f"Error sending contact email: {str(e)}")
        return False

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