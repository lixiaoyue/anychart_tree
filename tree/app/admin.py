from app.models import *
from django.contrib import admin
from mptt.admin import MPTTModelAdmin

class ProductAdmin(admin.ModelAdmin):
    list_display = ('title',)
admin.site.register(Product, ProductAdmin)

class ReleaseAdmin(admin.ModelAdmin):
    list_display = ('name',)
    ordering = ('-date',)
    search_fields = ('name', 'description')
admin.site.register(Release, ReleaseAdmin)

class StatusAdmin(admin.ModelAdmin):
     list_display = ('title','id')
admin.site.register(Status ,StatusAdmin)

class FileAdmin(admin.ModelAdmin):
    list_display = ('name',)
admin.site.register(File, FileAdmin)

class SourceAdmin(admin.ModelAdmin):
    list_display = ('source',)
admin.site.register(Source, SourceAdmin)

class NodeAdmin(MPTTModelAdmin):
    mptt_level_indent = 20
    list_display = ('title','id')
    list_filter =('curator','developer', 'tester', 'cur_status', 'cur_release', 'source')
    ordering = ('-last_modified_date',)
    filter_horizontal = ('files',)
admin.site.register(Node, NodeAdmin)

class StatusHistoryAdmin(admin.ModelAdmin):
    list_display = ('date','description')
    list_filter =('id_node','id_status')
admin.site.register(StatusHistory, StatusHistoryAdmin)

class ReleaseHistoryAdmin(admin.ModelAdmin):
    list_display = ('date','description')
    list_filter =('id_node','id_release')
admin.site.register(ReleaseHistory, ReleaseHistoryAdmin)

