from django.conf.urls import patterns, include, url
from django.conf import settings
from app.views import *
from django.views.generic.simple import direct_to_template
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    url('^$', homePage),
    url('^home/$', homePage),
    url(r'^getRequirements/$', getRequirements),
    url(r'^getNode/$', getNodeDescription),
    url(r'^deleteNode/$', deleteNode),
    url(r'^addNode/$', addNode),
    url(r'^editNode/$', editNode),
    url(r'^saveNode/$', saveNode),
    url(r'^cancelEditNode/$', cancelEditNode),
    url(r'^addReleaseToNode/$', addingReleaseInNode),
    url(r'^addFileToNode/$', addingFilesInNodes),
    url(r'^getFiles/$', getFiles),
    url(r'^deleteFile/$', deleteFile),
    url(r'^getNodeHistory/$', nodeHistory),
    url(r'^openTrash/$', openTrash),
    url(r'^restoreTrash/$', restoreTrash),

    (r'^ckeditor/', include('ckeditor.urls')),

    url(r'^accounts/', include('registration.urls')),
    url(r'^accounts/profile/$', homePage),
    url(r'^admin/', include(admin.site.urls)),
)
if settings.DEBUG:
    urlpatterns += patterns('',
        (r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root':'./media/'}),
    )