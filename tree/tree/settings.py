import os
#def rel(*x):
#    return os.path.join(os.path.abspath(os.path.dirname(__file__)),'../', *x)

def rel(*x):
    return os.path.join(os.path.dirname(os.path.abspath(__file__)),'../', *x)


DEBUG = True
TEMPLATE_DEBUG = DEBUG
ADMINS = ( #('olga', 'olga@irnok.net'),
    )
MANAGERS = ADMINS

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'anychart_tree_db',
        'USER': 'tester',
        'PASSWORD': 'rukikruki',
        'HOST': '',
        'PORT': '',
        }
}
ACCOUNT_ACTIVATION_DAYS = 2
AUTH_USER_EMAIL_UNIQUE = True
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_PORT = 587
EMAIL_HOST_USER = 'olga.vorobyeva@anychart.com'
EMAIL_HOST_PASSWORD = 'terrawyw9y24sbella'
EMAIL_USE_TLS = True

LOGIN_REDIRECT_URL = '/'

TIME_ZONE = 'Asia/Irkutsk'
LANGUAGE_CODE = 'ru-ru'
SITE_ID = 1
USE_I18N = True
USE_L10N = True
USE_TZ = True

MEDIA_ROOT = rel('media')
MEDIA_URL = '/media/'
FEINCMS_ADMIN_MEDIA = '/static/feincms/'
FEINCMS_ADMIN_MEDIA_LOCATION = os.path.join(MEDIA_ROOT, 'static', 'feincms')
STATIC_ROOT = ''
STATIC_URL = '/static/'
STATICFILES_DIRS = (
# Put strings here, like "/home/html/static" or "C:/www/django/static".
)
TEMPLATE_DIRS = (rel('templates'), os.path.join(rel('feincms'), 'templates'), os.path.join(rel('templates'),'catalogs'))
STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
    #    'django.contrib.staticfiles.finders.DefaultStorageFinder',
    )

SECRET_KEY = 'oc878%&amp;3lz0q$qb6o!p-4*dx)57emr92&amp;$6vpukci@6f1#p1$q'

TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.Loader',
    'django.template.loaders.app_directories.Loader',
    #     'django.template.loaders.eggs.Loader',
    )

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
    )

ROOT_URLCONF = 'tree.urls'

# Python dotted path to the WSGI application used by Django's runserver.
WSGI_APPLICATION = 'tree.wsgi.application'

INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'registration',
    'app',
    'mptt',
    'ckeditor',
    )

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'handlers': {
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        }
    },
    'loggers': {
        'django.request': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': True,
            },
        }
}
CKEDITOR_UPLOAD_PATH = os.path.join(rel('media'), 'files')

CKEDITOR_CONFIGS = {
    'default': {
        'toolbar': [
            [      'Undo', 'Redo',
                   '-', 'Bold', 'Italic', 'Underline',
                   '-', 'Link', 'Unlink', 'Anchor',
                   '-', 'Format',
                   '-', 'SpellChecker', 'Scayt',
                   '-', 'Maximize',
                   '-', 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak',
                   ],
            [      'HorizontalRule',
                   '-', 'Table',
                   '-', 'BulletedList', 'NumberedList',
                   '-', 'Cut','Copy','Paste','PasteText','PasteFromWord',
                   '-', 'SpecialChar',
                   '-', 'Source',
                   '-', 'About',
                   ]
        ],
        'width': 840,
        'height': 300,
        'toolbarCanCollapse': False,
        }
}