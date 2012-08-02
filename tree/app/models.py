#coding=utf-8
from django.db import models
from django.utils.translation import ugettext as _

class RoleInSystem(models.Model):
    name = models.CharField(max_length=30)
    def __unicode__(self):
        return unicode(self.name)
    class Meta:
        verbose_name = _('role in system')
        verbose_name_plural = _('roles in system')

class RoleInAnychart(models.Model):
    name = models.CharField(max_length=30)
    def __unicode__(self):
        return unicode(self.name)
    class Meta:
        verbose_name = _('role in anyChart')
        verbose_name_plural = _('roles in anyChart')

class People(models.Model):
    name = models.CharField(max_length=30)
    role_in_anychart = models.ManyToManyField(RoleInAnychart)
    def __unicode__(self):
        return unicode(self.name)
    class Meta:
        verbose_name = _('man')
        verbose_name_plural = _('peoples')

class Status(models.Model):
    title = models.CharField(max_length=30)
    def __unicode__(self):
        return unicode(self.title)
    class Meta:
        verbose_name = _('status')
        verbose_name_plural = _('statuses')

class TypesOfRequirement(models.Model):
    name = models.CharField(max_length=30)
    def __unicode__(self):
        return unicode(self.name)
    class Meta:
        verbose_name = _('type of requirement')
        verbose_name_plural = _('types of requirement')

class Node(models.Model):
    name = models.CharField(max_length=30)
    description = models.TextField()
    parent = models.ForeignKey('self', blank=True, null=True)
    def __unicode__(self):
        return unicode(self.name)

class TypeOfNodesRelationship(models.Model):
    name = models.CharField(max_length=30)
    description = models.TextField()
    def __unicode__(self):
        return unicode(self.name)
    class Meta:
        verbose_name = _('type of nodes relationship')
        verbose_name_plural = _('types of nodes relationship')

class NodesRelationship(models.Model):
    first_node = models.OneToOneField(Node, related_name='first_node')
    second_node = models.OneToOneField(Node, related_name='second_node')
    type_of_relation = models.OneToOneField(TypeOfNodesRelationship)

class VersionOfRequirement(models.Model):
    number = models.FloatField()
    def __unicode__(self):
        return unicode(self.number)
    class Meta:
        verbose_name = _('version of requirement')
        verbose_name_plural = _('versions of requirement')

class Release(models.Model):
    number = models.FloatField()
    name = models.CharField(max_length=30)
    deadline = models.DateField()
    def __unicode__(self):
        return unicode(self.name)

class Requirement(models.Model):
    name = models.CharField(max_length=30)
    type = models.ForeignKey(TypesOfRequirement)
    node = models.ForeignKey(Node, blank=True,null=True)
    business_requirement = models.OneToOneField('self', blank=True, null=True)
    release = models.ForeignKey(Release)
    def __unicode__(self):
        return unicode(self.name)

class ToDoImmediately(models.Model):
    author = models.OneToOneField(People, related_name='author')
    implementer = models.OneToOneField(People, related_name='implementer')
    title = models.CharField(max_length=30)
    description = models.TextField()
    time_data_set = models.DateTimeField()
    file = models.FileField(upload_to="files", blank=True, null=True)
    time_data_done = models.DateTimeField()
    status = models.BooleanField()
    node = models.ForeignKey(Node)
    def __unicode__(self):
        return u'%s %s' % (self.author, self.title)


class RequirementsEdition(models.Model):
    version = models.ForeignKey(VersionOfRequirement)
    requirement = models.ForeignKey(Requirement)
    name_of_requirement = models.CharField(max_length=30)
    description_of_requirement = models.TextField()
    file = models.FileField(upload_to="files", blank=True, null=True)
    picture = models.ImageField(upload_to="images", blank=True, null=True)
    deadline = models.DateField()
    edition_name = models.CharField(max_length=30)
    def __unicode__(self):
        return unicode(self.version)

class Task(models.Model):
    title = models.CharField(max_length=30)
    requirement = models.OneToOneField(Requirement)
    status = models.ForeignKey(Status)
    def __unicode__(self):
        return unicode(self.title)

class History(models.Model):
    requirement = models.ForeignKey(Requirement)
    version = models.ForeignKey(VersionOfRequirement)
    task = models.OneToOneField(Task)
    status = models.OneToOneField(Status)
    time = models.DateTimeField()
    man = models.OneToOneField(People)
    comment = models.TextField()
    def __unicode__(self):
        return unicode(self.comment)

class RoleInCircle(models.Model):
    requirement = models.ForeignKey(Requirement)
    role = models.ManyToManyField(RoleInSystem)
    man = models.ManyToManyField(People)
    def __unicode__(self):
        return unicode(self.requirement)