from app.models import *
from django.contrib import admin
from mptt.admin import MPTTModelAdmin

class ProductAdmin(admin.ModelAdmin):
    list_display = ('title',)
admin.site.register(Product, ProductAdmin)

class ReleaseAdmin(admin.ModelAdmin):
    list_display = ('name','id',  'description')
    ordering = ('-date',)
    search_fields = ('name', 'description')
admin.site.register(Release, ReleaseAdmin)

class StatusAdmin(admin.ModelAdmin):
     list_display = ('title','id')
admin.site.register(Status ,StatusAdmin)

class StatusColorUserAdmin(admin.ModelAdmin):
     list_display = ('user','status', 'color')
admin.site.register(StatusColorUser ,StatusColorUserAdmin)

class SourceAdmin(admin.ModelAdmin):
    list_display = ('source',)
admin.site.register(Source, SourceAdmin)

class FileAdmin(admin.ModelAdmin):
    list_display = ('name', 'date')
admin.site.register(File, FileAdmin)

class NodeAdmin(MPTTModelAdmin):
    mptt_level_indent = 20
    list_display = ('title','id', 'creation_date')
    list_filter =('product', 'type', 'cur_status', 'cur_release', 'source')
    ordering = ('creation_date',)
    search_fields = ('name_id', 'title')
    list_editable = ('type', )
admin.site.register(Node, NodeAdmin)

class StatusHistoryAdmin(admin.ModelAdmin):
    list_display = ('date','description')
    list_filter =('id_node','id_status')
admin.site.register(StatusHistory, StatusHistoryAdmin)

class ReleaseHistoryAdmin(admin.ModelAdmin):
    list_display = ('date','description')
    list_filter =('id_node','id_release')
admin.site.register(ReleaseHistory, ReleaseHistoryAdmin)

class TermAdmin(admin.ModelAdmin):
    list_display = ('name','description')
    search_fields = ('name','description')
    list_filter =('product',)
admin.site.register(Term, TermAdmin)

