from django.conf.urls import patterns, include, url
from django.conf import settings
from app.views import *

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    url('^$', home_page),
    url('^home/$', home_page),
    url(r'^any/$', any),
    url(r'^getRequirements/$', getRequirements),
    url(r'^getRequirementDescription/$', getRequirementDescription),
    url(r'^getNodeDescription/$', getNodeDescription),
    url(r'^saveNodeEdition/$', saveNodeEdition),
    url(r'^accounts/', include('registration.backends.default.urls')),
    url('^accounts/profile/$', home_page),
    url(r'^admin/', include(admin.site.urls)),
)
if settings.DEBUG:
    urlpatterns += patterns('',
        (r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root':'./media/'}),
    )