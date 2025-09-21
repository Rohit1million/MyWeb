# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class BlogPosts(models.Model):
    title = models.CharField(max_length=200)
    slug = models.CharField(unique=True, max_length=200)
    excerpt = models.CharField(max_length=300, blank=True, null=True)
    content = models.TextField(blank=True, null=True)
    featured_image = models.CharField(max_length=255, blank=True, null=True)
    status = models.CharField(max_length=9, blank=True, null=True)
    tags = models.CharField(max_length=300, blank=True, null=True)
    meta_description = models.CharField(max_length=160, blank=True, null=True)
    views = models.IntegerField(blank=True, null=True)
    featured = models.IntegerField(blank=True, null=True)
    published_at = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
      
        db_table = 'blog_posts'


class Certifications(models.Model):
    name = models.CharField(max_length=200)
    slug = models.CharField(unique=True, max_length=200)
    type = models.CharField(max_length=13, blank=True, null=True)
    issuing_organization = models.CharField(max_length=200)
    issue_date = models.DateField()
    expiry_date = models.DateField(blank=True, null=True)
    credential_id = models.CharField(max_length=100, blank=True, null=True)
    credential_url = models.CharField(max_length=200, blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    skills_gained = models.CharField(max_length=300, blank=True, null=True)
    certificate_image = models.CharField(max_length=255, blank=True, null=True)
    featured = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
       
        db_table = 'certifications'


class Contacts(models.Model):
    name = models.CharField(max_length=100)
    email = models.CharField(max_length=254)
    subject = models.CharField(max_length=200)
    message = models.TextField()
    phone = models.CharField(max_length=20, blank=True, null=True)
    company = models.CharField(max_length=100, blank=True, null=True)
    is_read = models.IntegerField(blank=True, null=True)
    is_replied = models.IntegerField(blank=True, null=True)
    reply_message = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    replied_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        
        db_table = 'contacts'


class Education(models.Model):
    degree_type = models.CharField(max_length=12)
    degree_name = models.CharField(max_length=200)
    institution = models.CharField(max_length=200)
    location = models.CharField(max_length=100)
    start_date = models.DateField()
    end_date = models.DateField(blank=True, null=True)
    currently_studying = models.IntegerField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    relevant_coursework = models.TextField(blank=True, null=True)
    grade = models.CharField(max_length=50, blank=True, null=True)
    achievements = models.TextField(blank=True, null=True)
    institution_logo = models.CharField(max_length=255, blank=True, null=True)
    display_order = models.IntegerField(blank=True, null=True)
    featured = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        
        db_table = 'education'


class Experience(models.Model):
    job_title = models.CharField(max_length=200)
    company = models.CharField(max_length=200)
    company_url = models.CharField(max_length=200, blank=True, null=True)
    location = models.CharField(max_length=100, blank=True, null=True)
    job_type = models.CharField(max_length=10, blank=True, null=True)
    start_date = models.DateField()
    end_date = models.DateField(blank=True, null=True)
    currently_working = models.IntegerField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    key_achievements = models.TextField(blank=True, null=True)
    responsibilities = models.TextField(blank=True, null=True)
    technologies_used = models.CharField(max_length=400, blank=True, null=True)
    company_logo = models.CharField(max_length=255, blank=True, null=True)
    display_order = models.IntegerField(blank=True, null=True)
    featured = models.IntegerField(blank=True, null=True)
    show_on_resume = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
      
        db_table = 'experience'


class PersonalInfo(models.Model):
    name = models.CharField(max_length=100)
    title = models.CharField(max_length=200)
    tagline = models.CharField(max_length=300, blank=True, null=True)
    profile_image = models.CharField(max_length=255, blank=True, null=True)
    hero_background = models.CharField(max_length=255, blank=True, null=True)
    introduction = models.TextField(blank=True, null=True)
    about_me = models.TextField(blank=True, null=True)
    mission_statement = models.TextField(blank=True, null=True)
    email = models.CharField(max_length=254)
    phone = models.CharField(max_length=20, blank=True, null=True)
    address = models.CharField(max_length=200, blank=True, null=True)
    linkedin = models.CharField(max_length=200, blank=True, null=True)
    github = models.CharField(max_length=200, blank=True, null=True)
    twitter = models.CharField(max_length=200, blank=True, null=True)
    instagram = models.CharField(max_length=200, blank=True, null=True)
    resume_file = models.CharField(max_length=255, blank=True, null=True)
    meta_title = models.CharField(max_length=60, blank=True, null=True)
    meta_description = models.CharField(max_length=160, blank=True, null=True)
    meta_keywords = models.CharField(max_length=200, blank=True, null=True)
    site_maintenance = models.IntegerField(blank=True, null=True)
    allow_contact_form = models.IntegerField(blank=True, null=True)
    show_resume_download = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
       
        db_table = 'personal_info'


class ProjectCategories(models.Model):
    name = models.CharField(unique=True, max_length=100)
    slug = models.CharField(unique=True, max_length=100)
    description = models.TextField(blank=True, null=True)
    color = models.CharField(max_length=7, blank=True, null=True)
    icon = models.CharField(max_length=50, blank=True, null=True)
    display_order = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
    
        db_table = 'project_categories'


class ProjectImages(models.Model):
    project = models.ForeignKey('Projects', models.DO_NOTHING)
    image = models.CharField(max_length=255)
    caption = models.CharField(max_length=200, blank=True, null=True)
    display_order = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
      
        db_table = 'project_images'


class Projects(models.Model):
    title = models.CharField(max_length=200)
    slug = models.CharField(unique=True, max_length=200)
    category = models.ForeignKey(ProjectCategories, models.DO_NOTHING)
    project_type = models.CharField(max_length=13)
    status = models.CharField(max_length=11, blank=True, null=True)
    short_description = models.CharField(max_length=300)
    detailed_description = models.TextField(blank=True, null=True)
    problem_statement = models.TextField(blank=True, null=True)
    solution_approach = models.TextField(blank=True, null=True)
    challenges_faced = models.TextField(blank=True, null=True)
    outcome_results = models.TextField(blank=True, null=True)
    lessons_learned = models.TextField(blank=True, null=True)
    featured_image = models.CharField(max_length=255, blank=True, null=True)
    technologies = models.CharField(max_length=300, blank=True, null=True)
    tools_used = models.CharField(max_length=300, blank=True, null=True)
    github_url = models.CharField(max_length=200, blank=True, null=True)
    live_demo_url = models.CharField(max_length=200, blank=True, null=True)
    case_study_url = models.CharField(max_length=200, blank=True, null=True)
    documentation_url = models.CharField(max_length=200, blank=True, null=True)
    start_date = models.DateField()
    end_date = models.DateField(blank=True, null=True)
    duration_weeks = models.IntegerField(blank=True, null=True)
    team_size = models.IntegerField(blank=True, null=True)
    role_in_project = models.CharField(max_length=200, blank=True, null=True)
    collaborators = models.TextField(blank=True, null=True)
    featured = models.IntegerField(blank=True, null=True)
    published = models.IntegerField(blank=True, null=True)
    display_order = models.IntegerField(blank=True, null=True)
    views = models.IntegerField(blank=True, null=True)
    github_stars = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
       
        db_table = 'projects'


class QuickInfo(models.Model):
    title = models.CharField(max_length=100)
    value = models.CharField(max_length=50)
    description = models.CharField(max_length=200)
    icon = models.CharField(max_length=50, blank=True, null=True)
    display_order = models.IntegerField(blank=True, null=True)
    active = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
       
        db_table = 'quick_info'


class SiteSettings(models.Model):
    site_name = models.CharField(max_length=100, blank=True, null=True)
    site_tagline = models.CharField(max_length=200, blank=True, null=True)
    primary_color = models.CharField(max_length=7, blank=True, null=True)
    secondary_color = models.CharField(max_length=7, blank=True, null=True)
    accent_color = models.CharField(max_length=7, blank=True, null=True)
    google_analytics_id = models.CharField(max_length=50, blank=True, null=True)
    contact_email = models.CharField(max_length=254, blank=True, null=True)
    admin_email = models.CharField(max_length=254, blank=True, null=True)
    show_social_links = models.IntegerField(blank=True, null=True)
    enable_blog = models.IntegerField(blank=True, null=True)
    enable_testimonials = models.IntegerField(blank=True, null=True)
    updated_at = models.DateTimeField(blank=True, null=True)

    class Meta:
       
        db_table = 'site_settings'


class SkillCategories(models.Model):
    name = models.CharField(unique=True, max_length=100)
    slug = models.CharField(unique=True, max_length=100)
    description = models.TextField(blank=True, null=True)
    icon = models.CharField(max_length=50, blank=True, null=True)
    color = models.CharField(max_length=7, blank=True, null=True)
    display_order = models.IntegerField(blank=True, null=True)
    show_on_home = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        
        db_table = 'skill_categories'


class Skills(models.Model):
    name = models.CharField(max_length=100)
    category = models.ForeignKey(SkillCategories, models.DO_NOTHING)
    proficiency = models.IntegerField(blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    years_of_experience = models.DecimalField(max_digits=3, decimal_places=1, blank=True, null=True)
    certification_name = models.CharField(max_length=200, blank=True, null=True)
    certification_url = models.CharField(max_length=200, blank=True, null=True)
    display_order = models.IntegerField(blank=True, null=True)
    featured = models.IntegerField(blank=True, null=True)
    active = models.IntegerField(blank=True, null=True)
    created_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        
        db_table = 'skills'
        unique_together = (('name', 'category'),)
