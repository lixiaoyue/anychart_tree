#coding=utf-8
from django.db import models

class RoleInSystem(models.Model):
    name = models.CharField(max_length=30)
    def __unicode__(self):
        return unicode(self.name)

class RoleInAnychart(models.Model):
    name = models.CharField(max_length=30)
    def __unicode__(self):
        return unicode(self.name)

class People(models.Model):
    name = models.CharField(max_length=30)
    role_in_anychart = models.ManyToManyField(RoleInAnychart)
    def __unicode__(self):
        return unicode(self.name)

class Status(models.Model):
    title = models.CharField(max_length=30)
    def __unicode__(self):
        return unicode(self.title)

class TypesOfRequirement(models.Model):
    name = models.CharField(max_length=30)
    def __unicode__(self):
        return unicode(self.name)

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

class NodesRelationship(models.Model):
    first_node = models.OneToOneField(Node, related_name='first_node')
    second_node = models.OneToOneField(Node, related_name='second_node')
    type_of_relation = models.OneToOneField(TypeOfNodesRelationship)

class VersionOfRequirement(models.Model):
    number = models.FloatField()

class Release(models.Model):
    number = models.FloatField()
    name = models.CharField(max_length=30)
    deadline = models.DateField()

class Requirement(models.Model):
    name = models.CharField(max_length=30)
    type = models.ForeignKey(TypesOfRequirement)
    node = models.ForeignKey(Node, blank=True,null=True)
    business_requirement = models.OneToOneField('self', blank=True, null=True)
    release = models.ForeignKey(Release)
    def __unicode__(self):
        return unicode(self.name)

class RequirementsEdition(models.Model):
    version = models.ForeignKey(VersionOfRequirement)
    requirement = models.ForeignKey(Requirement)
    name_of_requirement = models.CharField(max_length=30)
    description_of_requirement = models.TextField()
    #file
    #picture
    deadline = models.DateField()
    edition_name = models.CharField(max_length=30)

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

class RoleInCircle(models.Model):
    requirement = models.ForeignKey(Requirement)
    role = models.ManyToManyField(RoleInSystem)
    man = models.ManyToManyField(People)
    def __unicode__(self):
        return unicode(self.requirement)