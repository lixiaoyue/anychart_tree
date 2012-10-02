from app.models import *
from django.contrib import admin
from mptt.admin import MPTTModelAdmin

class NodeAdmin(MPTTModelAdmin):
    mptt_level_indent = 20

class ReleaseAdmin(admin.ModelAdmin):
    list_display = ('name',)
    ordering = ('-deadline',)
    search_fields = ('name', 'description')

class StatusAdmin(admin.ModelAdmin):
    list_display = ('title',)

class TaskAdmin(admin.ModelAdmin):
    list_display = ('title',)

class CurrentTaskAdmin(admin.ModelAdmin):
    list_display = ('title',)
    raw_id_fields = ('status',)
    list_filter =('status',)

class FileInNodesAdmin(admin.ModelAdmin):
    list_display = ('name',)

class NodeEditionHistoryAdmin(admin.ModelAdmin):
    list_display = ('node','edit_description',)
    filter_horizontal = ('files',)
    list_filter =('node',)

class TypeOfNodesRelationshipAdmin(admin.ModelAdmin):
    list_display = ('name',)

class StatusAdmin(admin.ModelAdmin):
    list_display = ('title', 'color',)

class RequirementAdmin(admin.ModelAdmin):
    list_display = ('name','release')
    raw_id_fields = ('node',)
    list_filter =('release',)

class RequirementsEditionAdmin(admin.ModelAdmin):
    list_display = ('requirement','edit_description',)
    filter_horizontal = ('files',)
    list_filter =('requirement',)

admin.site.register(Node, NodeAdmin)
admin.site.register(Release, ReleaseAdmin)
admin.site.register(Status ,StatusAdmin)
admin.site.register(FileInNodes, FileInNodesAdmin)
admin.site.register(NodeEditionHistory, NodeEditionHistoryAdmin)
admin.site.register(TypeOfNodesRelationship, TypeOfNodesRelationshipAdmin)
admin.site.register(Requirement, RequirementAdmin)
admin.site.register(RequirementsEdition, RequirementsEditionAdmin)
