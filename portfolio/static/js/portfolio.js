/* Simplified Portfolio JavaScript - No Glass Effects */

document.addEventListener('DOMContentLoaded', function() {
    initializeLayout();
    initializeAdminPanel();
    initializeNavigation();
    initializeLoginModal();
});

function initializeLayout() {
    setCurrentYear();
    initializeThemeToggle();
    initializeMobileMenu();
    initializeMessageHandlers();
    initializeScrollEffects();
    initializeAccessibility();
}

// Set current year in footer
function setCurrentYear() {
    const yearElement = document.getElementById('year');
    if (yearElement) {
        yearElement.textContent = new Date().getFullYear();
    }
}

// Theme toggle functionality
function initializeThemeToggle() {
    const themeToggle = document.getElementById('themeToggle');
    if (!themeToggle) return;

    loadSavedTheme();

    themeToggle.addEventListener('click', () => {
        toggleTheme();
    });

    updateThemeIcons();
}

function loadSavedTheme() {
    const savedTheme = localStorage.getItem('theme');
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
    
    if (savedTheme === 'light' || (!savedTheme && !prefersDark)) {
        document.body.setAttribute('data-theme', 'light');
    } else {
        document.body.setAttribute('data-theme', 'dark');
    }
    
    updateThemeIcons();
}

function toggleTheme() {
    const currentTheme = document.body.getAttribute('data-theme');
    
    if (currentTheme === 'light') {
        document.body.setAttribute('data-theme', 'dark');
        localStorage.setItem('theme', 'dark');
    } else {
        document.body.setAttribute('data-theme', 'light');
        localStorage.setItem('theme', 'light');
    }
    
    updateThemeIcons();
    announceThemeChange();
}

function updateThemeIcons() {
    const darkIcon = document.querySelector('.dark-icon');
    const lightIcon = document.querySelector('.light-icon');
    const currentTheme = document.body.getAttribute('data-theme');
    
    if (darkIcon && lightIcon) {
        if (currentTheme === 'light') {
            darkIcon.style.display = 'block';
            lightIcon.style.display = 'none';
        } else {
            darkIcon.style.display = 'none';
            lightIcon.style.display = 'block';
        }
    }
}

function announceThemeChange() {
    const currentTheme = document.body.getAttribute('data-theme');
    const message = currentTheme === 'light' ? 'Light theme activated' : 'Dark theme activated';
    
    const announcement = document.createElement('div');
    announcement.setAttribute('aria-live', 'polite');
    announcement.setAttribute('aria-atomic', 'true');
    announcement.className = 'sr-only';
    announcement.textContent = message;
    
    document.body.appendChild(announcement);
    
    setTimeout(() => {
        if (announcement.parentNode) {
            announcement.parentNode.removeChild(announcement);
        }
    }, 1000);
}

// Mobile menu functionality
function initializeMobileMenu() {
    const mobileMenuToggle = document.getElementById('mobileMenuToggle');
    const mainMenu = document.getElementById('mainMenu');
    
    if (!mobileMenuToggle || !mainMenu) return;

    mobileMenuToggle.addEventListener('click', (e) => {
        e.preventDefault();
        toggleMobileMenu();
    });

    mainMenu.addEventListener('click', (e) => {
        if (e.target.tagName === 'A') {
            closeMobileMenu();
        }
    });

    document.addEventListener('click', (e) => {
        if (mainMenu.classList.contains('mobile-open') && 
            !mobileMenuToggle.contains(e.target) && 
            !mainMenu.contains(e.target)) {
            closeMobileMenu();
        }
    });

    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && mainMenu.classList.contains('mobile-open')) {
            closeMobileMenu();
            mobileMenuToggle.focus();
        }
    });

    window.addEventListener('resize', () => {
        if (window.innerWidth > 768 && mainMenu.classList.contains('mobile-open')) {
            closeMobileMenu();
        }
    });
}

function toggleMobileMenu() {
    const mobileMenuToggle = document.getElementById('mobileMenuToggle');
    const mainMenu = document.getElementById('mainMenu');
    
    if (mobileMenuToggle && mainMenu) {
        const isOpen = mainMenu.classList.contains('mobile-open');
        
        if (isOpen) {
            closeMobileMenu();
        } else {
            openMobileMenu();
        }
    }
}

function openMobileMenu() {
    const mobileMenuToggle = document.getElementById('mobileMenuToggle');
    const mainMenu = document.getElementById('mainMenu');
    
    if (mobileMenuToggle && mainMenu) {
        mainMenu.classList.add('mobile-open');
        mobileMenuToggle.classList.add('active');
        mobileMenuToggle.setAttribute('aria-expanded', 'true');
        document.body.style.overflow = 'hidden';
    }
}

function closeMobileMenu() {
    const mobileMenuToggle = document.getElementById('mobileMenuToggle');
    const mainMenu = document.getElementById('mainMenu');
    
    if (mobileMenuToggle && mainMenu) {
        mainMenu.classList.remove('mobile-open');
        mobileMenuToggle.classList.remove('active');
        mobileMenuToggle.setAttribute('aria-expanded', 'false');
        document.body.style.overflow = '';
    }
}

// Message handling
function initializeMessageHandlers() {
    document.addEventListener('click', (e) => {
        if (e.target.classList.contains('message-close')) {
            closeMessage(e.target.closest('.message'));
        }
    });

    const messages = document.querySelectorAll('.message');
    messages.forEach((message, index) => {
        setTimeout(() => {
            closeMessage(message);
        }, 5000 + (index * 500));
    });
}

function closeMessage(messageElement) {
    if (!messageElement) return;

    messageElement.style.animation = 'slideOut 0.3s ease forwards';
    
    setTimeout(() => {
        if (messageElement.parentNode) {
            messageElement.parentNode.removeChild(messageElement);
        }
    }, 300);
}

// Scroll effects
function initializeScrollEffects() {
    let ticking = false;

    function updateScrollEffects() {
        const scrolled = window.pageYOffset;
        const header = document.querySelector('header');
        
        if (scrolled > 50) {
            header?.classList.add('scrolled');
        } else {
            header?.classList.remove('scrolled');
        }

        ticking = false;
    }

    window.addEventListener('scroll', () => {
        if (!ticking) {
            requestAnimationFrame(updateScrollEffects);
            ticking = true;
        }
    });
}

// Accessibility improvements
function initializeAccessibility() {
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Tab') {
            document.body.classList.add('keyboard-navigation');
        }
    });

    document.addEventListener('mousedown', () => {
        document.body.classList.remove('keyboard-navigation');
    });

    handleReducedMotion();
    initializeSmoothScrolling();
}

function handleReducedMotion() {
    const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)');
    
    if (prefersReducedMotion.matches) {
        document.body.classList.add('reduced-motion');
    }
    
    prefersReducedMotion.addEventListener('change', () => {
        if (prefersReducedMotion.matches) {
            document.body.classList.add('reduced-motion');
        } else {
            document.body.classList.remove('reduced-motion');
        }
    });
}

function initializeSmoothScrolling() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
                
                // Update active nav link
                document.querySelectorAll('.nav-link').forEach(link => {
                    link.classList.remove('active');
                });
                this.classList.add('active');
            }
        });
    });
}

// Navigation functionality
function initializeNavigation() {
    const navLinks = document.querySelectorAll('.nav-link');
    const sections = document.querySelectorAll('section[id]');
    
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const targetId = this.getAttribute('href').substring(1);
            const targetSection = document.getElementById(targetId);
            
            if (targetSection) {
                targetSection.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
                
                updateActiveNavLink(this);
            }
        });
    });
    
    function updateActiveNavLink(activeLink = null) {
        if (activeLink) {
            navLinks.forEach(link => link.classList.remove('active'));
            activeLink.classList.add('active');
        } else {
            let current = '';
            const scrollPos = window.scrollY + 100;
            
            sections.forEach(section => {
                const sectionTop = section.offsetTop;
                const sectionHeight = section.offsetHeight;
                
                if (scrollPos >= sectionTop && scrollPos < sectionTop + sectionHeight) {
                    current = section.getAttribute('id');
                }
            });
            
            navLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('href') === '#' + current) {
                    link.classList.add('active');
                }
            });
        }
    }
    
    window.addEventListener('scroll', () => updateActiveNavLink());
}

// Admin Panel functionality
function initializeAdminPanel() {
    const cornerSlider = document.getElementById('cornerSlider');
    const sliderTrigger = document.getElementById('sliderTrigger');
    const sliderPanel = document.getElementById('sliderPanel');
    const panelClose = document.getElementById('panelClose');
    
    if (!cornerSlider) return;
    
    setTimeout(() => {
        cornerSlider.classList.add('show');
    }, 1000);
    
    let isOpen = false;
    
    function togglePanel() {
        isOpen = !isOpen;
        sliderPanel.classList.toggle('active', isOpen);
        
        if (isOpen) {
            setTimeout(() => {
                document.addEventListener('click', closeOnOutsideClick);
            }, 100);
        } else {
            document.removeEventListener('click', closeOnOutsideClick);
        }
    }
    
    function closeOnOutsideClick(event) {
        if (!cornerSlider.contains(event.target)) {
            isOpen = false;
            sliderPanel.classList.remove('active');
            document.removeEventListener('click', closeOnOutsideClick);
        }
    }
    
    if (sliderTrigger) {
        sliderTrigger.addEventListener('click', function(e) {
            e.stopPropagation();
            togglePanel();
        });
    }
    
    if (panelClose) {
        panelClose.addEventListener('click', function(e) {
            e.stopPropagation();
            isOpen = false;
            sliderPanel.classList.remove('active');
            document.removeEventListener('click', closeOnOutsideClick);
        });
    }
    
    if (sliderPanel) {
        sliderPanel.addEventListener('click', function(e) {
            e.stopPropagation();
        });
    }
    
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape' && isOpen) {
            isOpen = false;
            sliderPanel.classList.remove('active');
            document.removeEventListener('click', closeOnOutsideClick);
        }
    });
}

// Login Modal functionality
function initializeLoginModal() {
    const loginModalBtn = document.getElementById('loginModalBtn');
    const loginForm = document.getElementById('loginForm');
    
    if (loginModalBtn) {
        loginModalBtn.addEventListener('click', openLoginModal);
    }
    
    if (loginForm) {
        loginForm.addEventListener('submit', handleLoginSubmit);
    }
    
    // Close modal with Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape' && document.getElementById('loginModal')?.classList.contains('active')) {
            closeLoginModal();
        }
    });
}

function openLoginModal() {
    const loginModal = document.getElementById('loginModal');
    const errorMsg = document.getElementById('login-error-message');
    
    if (loginModal) {
        loginModal.classList.add('active');
        document.body.style.overflow = 'hidden';
        
        // Clear any previous error messages
        if (errorMsg) {
            errorMsg.style.display = 'none';
            errorMsg.textContent = '';
        }
        
        // Focus on username field
        const usernameField = document.getElementById('modal-username');
        if (usernameField) {
            setTimeout(() => usernameField.focus(), 100);
        }
    }
}

function closeLoginModal() {
    const loginModal = document.getElementById('loginModal');
    const loginForm = document.getElementById('loginForm');
    const errorMsg = document.getElementById('login-error-message');
    
    if (loginModal) {
        loginModal.classList.remove('active');
        document.body.style.overflow = '';
        
        // Reset form
        if (loginForm) {
            loginForm.reset();
        }
        
        // Hide error message
        if (errorMsg) {
            errorMsg.style.display = 'none';
            errorMsg.textContent = '';
        }
    }
}

// Get CSRF token
function getCSRFToken() {
    const cookies = document.cookie.split(';');
    for (let cookie of cookies) {
        const [name, value] = cookie.trim().split('=');
        if (name === 'csrftoken') {
            return value;
        }
    }
    // Fallback to hidden input
    const csrfMeta = document.querySelector('[name=csrfmiddlewaretoken]');
    return csrfMeta ? csrfMeta.value : '';
}

// Handle login form submission
function handleLoginSubmit(e) {
    e.preventDefault();
    
    const form = e.target;
    const submitBtn = form.querySelector('.login-submit-button');
    const errorMsg = document.getElementById('login-error-message');
    const username = document.getElementById('modal-username').value.trim();
    const password = document.getElementById('modal-password').value;
    
    // Basic validation
    if (!username || !password) {
        if (errorMsg) {
            errorMsg.textContent = 'Please enter both username and password.';
            errorMsg.style.display = 'block';
        }
        return;
    }
    
    // Show loading state
    const originalHTML = submitBtn.innerHTML;
    submitBtn.innerHTML = '<span>Logging in...</span> <i class="fas fa-spinner fa-spin"></i>';
    submitBtn.disabled = true;
    
    if (errorMsg) {
        errorMsg.style.display = 'none';
    }
    
    // Prepare form data
    const formData = new FormData();
    formData.append('username', username);
    formData.append('password', password);
    formData.append('csrfmiddlewaretoken', getCSRFToken());
    
    // Get login URL from form action
    const loginUrl = form.getAttribute('action') || '/login/';
    
    // Send AJAX request
    fetch(loginUrl, {
        method: 'POST',
        body: formData,
        credentials: 'same-origin',
        headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRFToken': getCSRFToken()
        }
    })
    .then(response => {
        if (response.ok && response.redirected) {
            // Login successful, redirect
            window.location.href = response.url || '/';
        } else {
            return response.text();
        }
    })
    .then(html => {
        if (html && errorMsg) {
            // Check for common error indicators in the response
            if (html.includes('invalid') || html.includes('error') || html.includes('incorrect')) {
                errorMsg.textContent = 'Invalid username or password. Please try again.';
                errorMsg.style.display = 'block';
            } else {
                // If login was successful but no redirect, reload page
                window.location.reload();
            }
        }
    })
    .catch(error => {
        console.error('Login error:', error);
        if (errorMsg) {
            errorMsg.textContent = 'Network error. Please check your connection and try again.';
            errorMsg.style.display = 'block';
        }
    })
    .finally(() => {
        // Reset button state
        submitBtn.innerHTML = originalHTML;
        submitBtn.disabled = false;
    });
}

// Global API
window.Portfolio = {
    toggleTheme,
    toggleMobileMenu,
    openMobileMenu,
    closeMobileMenu,
    closeMessage,
    openLoginModal,
    closeLoginModal
};

// Make functions available globally for onclick handlers
window.openLoginModal = openLoginModal;
window.closeLoginModal = closeLoginModal;

console.log('Portfolio JavaScript loaded successfully');