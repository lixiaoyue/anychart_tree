from app.models import RoleInSystem
from app.models import RoleInAnychart
from app.models import People
from app.models import Status
from app.models import TypesOfRequirement
from app.models import Node
from app.models import TypeOfNodesRelationship
from app.models import NodesRelationship
from app.models import Requirement
from app.models import Task
from app.models import History
from app.models import RoleInCircle
from app.models import RequirementsEdition
from app.models import VersionOfRequirement
from app.models import Release
from app.models import ToDoImmediately
from django.contrib import admin

class RoleInSystemAdmin(admin.ModelAdmin):
    list_display = ('name',)

class RoleInAnychartAdmin(admin.ModelAdmin):
    list_display = ('name',)

class PeopleAdmin(admin.ModelAdmin):
    filter_horizontal = ('role_in_anychart',)
    list_display = ('name',)

class StatusAdmin(admin.ModelAdmin):
    list_display = ('title',)

class TypesOfRequirementAdmin(admin.ModelAdmin):
    list_display = ('name',)

class NodeAdmin(admin.ModelAdmin):
    list_display = ('name', 'parent')

class RequirementAdmin(admin.ModelAdmin):
    list_display = ('name', 'type')

class TaskAdmin(admin.ModelAdmin):
    list_display = ('title',)

class HistoryAdmin(admin.ModelAdmin):
    list_display = ('requirement', 'task', 'status', 'man')

class RoleInCircleAdmin(admin.ModelAdmin):
    filter_horizontal = ('man', 'role')

class VersionOfRequirementAdmin(admin.ModelAdmin):
    list_display = ('number',)

admin.site.register(RoleInSystem, RoleInSystemAdmin)
admin.site.register(RoleInAnychart, RoleInAnychartAdmin)
admin.site.register(People, PeopleAdmin)
admin.site.register(Status, StatusAdmin)
admin.site.register(TypesOfRequirement, TypesOfRequirementAdmin)
admin.site.register(Node, NodeAdmin)
admin.site.register(TypeOfNodesRelationship)
admin.site.register(NodesRelationship)
admin.site.register(Requirement, RequirementAdmin)
admin.site.register(Task, TaskAdmin)
admin.site.register(History, HistoryAdmin)
admin.site.register(RoleInCircle, RoleInCircleAdmin)
admin.site.register(RequirementsEdition)
admin.site.register(VersionOfRequirement)
admin.site.register(Release)
admin.site.register(ToDoImmediately)