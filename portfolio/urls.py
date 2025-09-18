from django.urls import path
from . import views

urlpatterns = [
    # Single-page app - all content on home page
    path('', views.home, name='home'),
    
    # Form submission endpoint
    path('contact/submit/', views.contact_submit, name='contact_submit'),
    
    # Individual project pages (keep these for detail views)
    path('projects/<slug:slug>/', views.project_detail, name='project_detail'),
    
    # Utility and auth (keep as-is)
    path('test-data/', views.test_data, name='test_data'),
    path('login/', views.custom_login_view, name='login'),
    path('logout/', views.custom_logout_view, name='logout'),
]