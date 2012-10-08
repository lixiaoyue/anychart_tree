#coding=utf-8
from django.utils.translation import ugettext as _
from mptt.models import MPTTModel, TreeForeignKey
from django.contrib.auth.models import User
from django.db import models

class Node(MPTTModel):
    name = models.CharField(max_length=200, verbose_name=u'Название узла')
    parent = TreeForeignKey('self', null=True, blank=True, related_name='children', verbose_name=u'Родительский узел')
    base = models.BooleanField(default=False)
    curator = models.ForeignKey(User)
    def __unicode__(self):
        return unicode(self.name)
    class MPTTMeta:
        order_insertion_by = ['name']
    class Meta:
        verbose_name = _(u'Бизнес-требование')
        verbose_name_plural = _(u'Бизнес-требования')

class Release(models.Model):
    name = models.CharField(max_length=200, verbose_name=u'Название релиза')
    deadline = models.DateTimeField(auto_now=False, verbose_name=u'Срок реализации')
    description = models.TextField(blank=True, verbose_name=u'Описание релиза')
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = _(u'Релиз')
        verbose_name_plural = _(u'Релиз')

class Status(models.Model):
    title = models.CharField(max_length=200, verbose_name=u'Статус')
    color = models.CharField(max_length=15, verbose_name=u'Цвет статуса')
    def __unicode__(self):
        return self.title
    class Meta:
        verbose_name = _(u'Статус')
        verbose_name_plural = _(u'Статусы требований')

class FileInNodes(models.Model):
    name = models.CharField(max_length=200, verbose_name=u'Название файла')
    file = models.FileField(upload_to='files/')
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = _(u'Файл')
        verbose_name_plural = _(u'Файлы')

class NodeEditionHistory(models.Model):
    description = models.TextField(blank=True, verbose_name=u'Описание узла')
    redaction_date = models.DateTimeField(auto_now=True)
    node = models.ForeignKey('Node', verbose_name=u'Редактируемый узел')
    release = models.ForeignKey('Release', verbose_name=u'Релиз')
    edit_description = models.TextField(verbose_name=u'Обоснование редакции')
    files = models.ManyToManyField('FileInNodes',blank=True, null=True, verbose_name=u'Файлы')
    def __unicode__(self):
        return '%s: %s' % (self.edit_description, self.redaction_date)
    class Meta:
        verbose_name = _(u'История редактирования БТ')
        verbose_name_plural = _(u'История редактирования БТ')

class TypeOfNodesRelationship(models.Model):
    name = models.CharField(max_length=30)
    description = models.TextField()
    def __unicode__(self):
        return unicode(self.name)
    class Meta:
        verbose_name = _(u'Тип отношений между узлами')
        verbose_name_plural = _(u'Тип отношений между узлами')

class NodesRelationship(models.Model):
    first_node = models.ForeignKey(Node, related_name='first_node')
    second_node = models.ForeignKey(Node, related_name='second_node')
    type_of_relation = models.ForeignKey(TypeOfNodesRelationship)
    class Meta:
        verbose_name = _(u'Отношения между узлами')
        verbose_name_plural = _(u'Отношения между узлами')

class Requirement(models.Model):
    name = models.CharField(max_length=200)
    node = models.ForeignKey(Node, blank=True,null=True)
    release = models.ForeignKey(Release)
    curator = models.ForeignKey(User)
    def __unicode__(self):
        return unicode(self.name)
    class Meta:
        verbose_name = _(u'Требование')
        verbose_name_plural = _(u'Требования')

class RequirementsEdition(models.Model):
    requirement = models.ForeignKey(Requirement)
    description = models.TextField(blank=True, verbose_name=u'Описание требования')
    deadline = models.DateField()
    files = models.ManyToManyField(FileInNodes, blank=True, null=True)
    redaction_date = models.DateTimeField(auto_now=True)
    edit_description = models.TextField(verbose_name=u'Обоснование редакции')
    def __unicode__(self):
        return unicode(self.requirement)
    class Meta:
        verbose_name = _(u'История редактирования требований')
        verbose_name_plural = _(u'История редактирования требований')


