import re
from time import timezone
from django import forms
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import authenticate
from django.core.exceptions import ValidationError

from portfolio.models import Contacts

class CustomAuthenticationForm(AuthenticationForm):
    """
    Custom authentication form with enhanced styling and validation
    """
    username = forms.CharField(
        max_length=254,
        widget=forms.TextInput(attrs={
            'class': 'form-input',
            'placeholder': 'Type your username',
            'id': 'username',
            'autocomplete': 'username',
        })
    )
    
    password = forms.CharField(
        label="Password",
        strip=False,
        widget=forms.PasswordInput(attrs={
            'class': 'form-input',
            'placeholder': 'Type your password',
            'id': 'password',
            'autocomplete': 'current-password',
        })
    )
    
    def __init__(self, request=None, *args, **kwargs):
        super().__init__(request, *args, **kwargs)
        
        # Remove help text
        for field in self.fields.values():
            field.help_text = None
    
    def clean(self):
        username = self.cleaned_data.get('username')
        password = self.cleaned_data.get('password')
        
        if username is not None and password:
            self.user_cache = authenticate(
                self.request, 
                username=username, 
                password=password
            )
            if self.user_cache is None:
                raise forms.ValidationError(
                    "Please enter a correct username and password. Note that both fields may be case-sensitive.",
                    code='invalid_login'
                )
            else:
                self.confirm_login_allowed(self.user_cache)
        
        return self.cleaned_data
    
    def confirm_login_allowed(self, user):
        """
        Controls whether the given User may log in.
        """
        if not user.is_active:
            raise forms.ValidationError(
                "Your account is pending approval. Please contact an administrator.",
                code='inactive',
            )
        
        class ContactForm(forms.ModelForm):
            """Contact form based on Contacts model"""
    
    """Contact form based on Contacts model"""
    
    # Override field definitions for better control
    name = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Enter your full name',
            'id': 'full_name'
        }),
        label='Full Name',
        help_text='Required. Maximum 100 characters.'
    )
    
    email = forms.EmailField(
        max_length=254,
        widget=forms.EmailInput(attrs={
            'class': 'form-control',
            'placeholder': 'Enter your email address',
            'id': 'email'
        }),
        label='Email Address',
        help_text='Required. We\'ll never share your email.'
    )
    
    subject = forms.CharField(
        max_length=200,
        required=False,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'What is this about?',
            'id': 'subject'
        }),
        label='Subject',
        help_text='Optional. Maximum 200 characters.'
    )
    
    message = forms.CharField(
        widget=forms.Textarea(attrs={
            'class': 'form-control',
            'rows': 5,
            'placeholder': 'Tell us about your project, question, or how we can help...',
            'id': 'message'
        }),
        label='Message',
        help_text='Required. Please provide details about your inquiry.'
    )
    
    phone = forms.CharField(
        max_length=20,
        required=False,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': '+1 (555) 123-4567',
            'id': 'phone',
            'type': 'tel'
        }),
        label='Phone Number',
        help_text='Optional. Include country code if international.'
    )
    
    company = forms.CharField(
        max_length=100,
        required=False,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Your company or organization',
            'id': 'company'
        }),
        label='Company/Organization',
        help_text='Optional. Maximum 100 characters.'
    )
    
    class Meta:
        model = Contacts
        fields = ['name', 'email', 'subject', 'message', 'phone', 'company']
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        # Add CSS classes and attributes to all fields
        for field_name, field in self.fields.items():
            field.widget.attrs.update({
                'class': field.widget.attrs.get('class', '') + ' contact-form-field'
            })
            
        # Mark required fields
        self.fields['name'].widget.attrs['required'] = True
        self.fields['email'].widget.attrs['required'] = True
        self.fields['message'].widget.attrs['required'] = True
    
    def clean_name(self):
        """Validate name field"""
        name = self.cleaned_data.get('name')
        if name:
            name = name.strip()
            if len(name) < 2:
                raise forms.ValidationError("Name must be at least 2 characters long.")
            if not re.match(r'^[a-zA-Z\s\'-\.]+$', name):
                raise ValidationError("Name can only contain letters, spaces, hyphens, apostrophes, and periods.")
        return name
    
    def clean_email(self):
        """Validate email field"""
        email = self.cleaned_data.get('email')
        if email:
            email = email.strip().lower()
            # Django's EmailField already validates format, but let's add custom checks
            if email.count('@') != 1:
                raise ValidationError("Please enter a valid email address.")
            
            # Check for common disposable email domains (optional)
            disposable_domains = [
                '10minutemail.com', 'tempmail.org', 'guerrillamail.com',
                'mailinator.com', 'yopmail.com'
            ]
            domain = email.split('@')[1].lower()
            if domain in disposable_domains:
                raise ValidationError("Please use a permanent email address.")
                
        return email
    
    def clean_phone(self):
        """Validate phone field"""
        phone = self.cleaned_data.get('phone')
        if phone:
            phone = phone.strip()
            # Remove common formatting characters
            cleaned_phone = re.sub(r'[^\d+]', '', phone)
            if len(cleaned_phone) < 7:
                raise ValidationError("Please enter a valid phone number.")
            if len(cleaned_phone) > 20:
                raise ValidationError("Phone number is too long.")
            # Basic format check
            if not re.match(r'^[\+]?[\d\s\(\)\-\.]+$', phone):
                raise ValidationError("Please enter a valid phone number format.")
        return phone
    
    def clean_message(self):
        """Validate message field"""
        message = self.cleaned_data.get('message')
        if message:
            message = message.strip()
            if len(message) < 10:
                raise ValidationError("Message must be at least 10 characters long.")
            if len(message) > 5000:
                raise ValidationError("Message is too long. Please keep it under 5000 characters.")
            
            # Check for spam patterns (basic)
            spam_patterns = [
                r'(https?://\S+\.\S+){3,}',  # Multiple URLs
                r'(URGENT|WINNER|CONGRATULATIONS|FREE MONEY)',  # Spam keywords
                r'(.)\1{10,}',  # Repeated characters
            ]
            
            for pattern in spam_patterns:
                if re.search(pattern, message, re.IGNORECASE):
                    raise ValidationError("Message appears to be spam. Please write a genuine inquiry.")
                    
        return message
    
    def clean_subject(self):
        """Validate subject field"""
        subject = self.cleaned_data.get('subject')
        if subject:
            subject = subject.strip()
            if len(subject) > 200:
                raise ValidationError("Subject is too long. Maximum 200 characters.")
        return subject
    
    def clean(self):
        """Form-wide validation"""
        cleaned_data = super().clean()
        name = cleaned_data.get('name')
        email = cleaned_data.get('email')
        message = cleaned_data.get('message')
        
        # Ensure required fields are present
        if not name:
            raise ValidationError("Full name is required.")
        if not email:
            raise ValidationError("Email address is required.")
        if not message:
            raise ValidationError("Message is required.")

        return cleaned_data
    
    def save(self, commit=True):
        """Override save to set additional fields"""
        instance = super().save(commit=False)
        
        # Set default values for tracking fields
        instance.is_read = 0
        instance.is_replied = 0
        instance.created_at = timezone.now()
        
        # If no subject provided, create one from name
        if not instance.subject:
            instance.subject = f"Contact from {instance.name}"
        
        if commit:
            instance.save()
        return instance


class QuickContactForm(forms.Form):
    """Simplified contact form for quick inquiries"""
    
    name = forms.CharField(
        max_length=100,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Your name',
        })
    )
    
    email = forms.EmailField(
        widget=forms.EmailInput(attrs={
            'class': 'form-control',
            'placeholder': 'your@email.com',
        })
    )
    
    message = forms.CharField(
        widget=forms.Textarea(attrs={
            'class': 'form-control',
            'rows': 3,
            'placeholder': 'Quick message...',
        })
    )
    
    def clean_message(self):
        message = self.cleaned_data.get('message')
        if message and len(message) < 5:
            raise ValidationError("Message must be at least 5 characters.")
        return message