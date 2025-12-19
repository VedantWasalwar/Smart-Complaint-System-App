from pathlib import Path
import os

# -------------------------
# Base directory
# -------------------------
BASE_DIR = Path(__file__).resolve().parent.parent

# -------------------------
# Security
# -------------------------
SECRET_KEY = 'smart-complaint-secret-key'
DEBUG = True

ALLOWED_HOSTS = os.environ.get("ALLOWED_HOSTS", "*").split(",")

# -------------------------
# Applications
# -------------------------
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    'rest_framework',
    'corsheaders',

    'complaint_app',
]

# -------------------------
# Middleware
# -------------------------
MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

# -------------------------
# CORS
# -------------------------
CORS_ALLOW_ALL_ORIGINS = True

# -------------------------
# URLs & Templates
# -------------------------
ROOT_URLCONF = 'smartcomplaint.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

# -------------------------
# WSGI
# -------------------------
WSGI_APPLICATION = 'smartcomplaint.wsgi.application'

# -------------------------
# Database (PostgreSQL)
# -------------------------
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'smart_complaint_db',
        'USER': 'smart_complaint_db_user',
        'PASSWORD': 'VIXkxyaW6ax0gYjsDwtuquZPTarccWIi',
        'HOST': 'dpg-d519q7fpm1nc73brod50-a.oregon-postgres.render.com',
        'PORT': '5432',
        'CONN_MAX_AGE': 0,   # 🔴 IMPORTANT (free DB ke liye)
    }
}


# -------------------------
# Static & Media
# -------------------------
STATIC_URL = '/static/'
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

# -------------------------
# Default primary key
# -------------------------
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
