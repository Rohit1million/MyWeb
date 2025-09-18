from django.urls import path
from . import views

urlpatterns = [
    # Single-page app - all content on home page
    path('', views.home, name='home'),
    
    # Contact pages
    path('contact/', views.contact_view, name='contact'),
    path('contact/submit/', views.contact_submit, name='contact_submit'),
    
    # Individual project pages
    path('projects/<slug:slug>/', views.project_detail, name='project_detail'),
    
    # Utility and auth
    path('test-data/', views.test_data, name='test_data'),
    path('login/', views.custom_login_view, name='login'),
    path('logout/', views.custom_logout_view, name='logout'),
]