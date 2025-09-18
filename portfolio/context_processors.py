# portfolio/context_processors.py
from .models import PersonalInfo, Experience, Projects, SiteSettings

def portfolio_context(request):
    """
    Context processor to provide main menu data and site-wide information
    Available in all templates without explicitly passing in views
    Updated for smooth scrolling navigation
    """
    try:
        # Get personal information for navigation and footer
        personal_info = PersonalInfo.objects.first()
        
        # Get current/featured experience for menu
        current_experience = Experience.objects.filter(currently_working=1).first()
        latest_experience = Experience.objects.filter(show_on_resume=1).order_by('-start_date').first()
        
        # Get featured projects count for menu badge
        featured_projects_count = Projects.objects.filter(featured=1, published=1).count()
        total_projects_count = Projects.objects.filter(published=1).count()
        
        # Get site settings
        site_settings = SiteSettings.objects.first()
        
        # Main menu structure with anchor links for smooth scrolling
        main_menu = {
            'personal': {
                'title': 'About',
                'url': '#about',  # Changed to anchor link
                'description': 'Personal information and bio',
                'has_data': bool(personal_info),
            },
            'experience': {
                'title': 'Experience',
                'url': '#experience',  # Changed to anchor link
                'description': 'Work history and roles',
                'has_data': bool(latest_experience),
                'current_role': current_experience.job_title if current_experience else None,
                'current_company': current_experience.company if current_experience else None,
            },
            'projects': {
                'title': 'Projects',
                'url': '#projects',  # Changed to anchor link
                'description': 'Portfolio and work samples',
                'has_data': total_projects_count > 0,
                'featured_count': featured_projects_count,
                'total_count': total_projects_count,
            },
            'contact': {
                'title': 'Contact',
                'url': '#contact',  # Changed to anchor link
                'description': 'Get in touch',
                'has_data': bool(personal_info and personal_info.email),
                'email': personal_info.email if personal_info else None,
                'phone': personal_info.phone if personal_info else None,
            }
        }
        
        return {
            'main_menu': main_menu,
            'personal_info': personal_info,
            'site_settings': site_settings,
            'current_experience': current_experience,
            'projects_count': total_projects_count,
            'featured_projects_count': featured_projects_count,
        }
        
    except Exception as e:
        # Return empty context with anchor links if database issues
        return {
            'main_menu': {
                'personal': {'title': 'About', 'url': '#about', 'has_data': False},
                'experience': {'title': 'Experience', 'url': '#experience', 'has_data': False},
                'projects': {'title': 'Projects', 'url': '#projects', 'has_data': False},
                'contact': {'title': 'Contact', 'url': '#contact', 'has_data': False},
            },
            'personal_info': None,
            'site_settings': None,
            'current_experience': None,
            'projects_count': 0,
            'featured_projects_count': 0,
            'context_processor_error': str(e),
        }