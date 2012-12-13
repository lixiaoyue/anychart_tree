# -*- coding: utf-8 -*-
from django.conf.urls import patterns, include, url
from django.conf import settings
from django.contrib import admin
from app.views import *
admin.autodiscover()

urlpatterns = patterns('',
    url('^$', homePage),
    url('^([A-Z]{1,6})/$', productPage),
    url('^([A-Z]{1,6})/catalog/$', catalogs),

    #Получение данных ajax
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
    url(r'^getParentNode/$', getParentNode),
    url(r'^getNodeLessEditable/$', getNodeLessEditable),
    url(r'^editNodeLessEditable/$', editNodeLessEditable),

    #Cправочники
    url(r'^getStatusCatalog/$', getStatusCatalog),
    url(r'^saveStatuses/$', saveStatuses),
    url(r'^getSourceCatalog/$', getSourceCatalog),
    url(r'^addSourceCatalog/$', addSourceCatalog),
    url(r'^deleteSourceCatalog/$', deleteSourceCatalog),
    url(r'^getReleaseCatalog/$', getReleaseCatalog),
    url(r'^deleteReleaseCatalog/$', deleteReleaseCatalog),
    url(r'^saveReleaseCatalog/$', saveReleaseCatalog),
    url(r'^getUsersCatalog/$', getUsersCatalog),

    url(r'^check/$', checking),

    url(r'^accounts/', include('registration.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^ckeditor/', include('ckeditor.urls')),
    url(r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT}),

)