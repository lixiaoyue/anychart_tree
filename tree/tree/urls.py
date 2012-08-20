from django.conf.urls import patterns, include, url
from django.conf import settings
from app.views import *


# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'tree.views.home', name='home'),
    # url(r'^tree/', include('tree.foo.urls')),
    url('^$', home_page),
    url(r'^any/$', any),
    url(r'^getRequirements/$', getRequirements),
    # Uncomment the admin/doc line below to enable admin documentation:
    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
)

if settings.DEBUG:
    urlpatterns += patterns('',
        (r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root':'./media/'}),
    )