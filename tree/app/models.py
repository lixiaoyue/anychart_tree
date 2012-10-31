#coding=utf-8
from django.utils.translation import ugettext as _
from mptt.models import MPTTModel, TreeForeignKey
from django.contrib.auth.models import User
from django.db import models
from ckeditor.fields import RichTextField
from tree.settings import CKEDITOR_UPLOAD_PATH

class Product(models.Model):
    title = models.CharField(max_length=300, verbose_name=u'Продукт')
    description = models.TextField(blank=True, verbose_name=u'Описание')
    def __unicode__(self):
        return self.title
    class Meta:
        verbose_name = _(u'продукт')
        verbose_name_plural = _(u'Продукты')

class Release(models.Model):
    name = models.CharField(max_length=300, verbose_name=u'Название')
    number = models.CharField(max_length=50, verbose_name=u'Номер')
    status = models.BooleanField(verbose_name=u'Статус', help_text=u'True - если выпущен, false - если релиз еще не выпущен')
    description = models.TextField(blank=True, verbose_name=u'Описание релиза')
    date = models.DateTimeField(auto_now=False,blank=True, null=True, verbose_name=u'Дата выпуска релиза')
    product = models.ForeignKey(Product, verbose_name=u'Продукт')
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = _(u'релиз')
        verbose_name_plural = _(u'Релиз')

class Status(models.Model):
    title = models.CharField(max_length=200, verbose_name=u'Статус')
    color = models.CharField(max_length=7, verbose_name=u'Цвет')
    def __unicode__(self):
        return self.title
    class Meta:
        verbose_name = _(u'статус')
        verbose_name_plural = _(u'Статусы')

class Source(models.Model):
    source = models.CharField(max_length=300, verbose_name=u'Источник')
    def __unicode__(self):
        return self.source
    class Meta:
        verbose_name = _(u'источник')
        verbose_name_plural = _(u'Источник требований')

class File(models.Model):
    name = models.CharField(max_length=200, blank=True, null=True, verbose_name=u'Название файла')
    file = models.FileField(upload_to='files/')
    date = models.DateTimeField(auto_now=True)
    def __unicode__(self):
        return self.name
    class Meta:
        verbose_name = _(u'файл')
        verbose_name_plural = _(u'Файлы')

NODES_TYPES = (('NE', 'non_editable'), ('BR','business_requirement'), ('OR','other_requirement'))
class Node(MPTTModel):
    title = models.CharField(max_length=300, verbose_name=u'Название узла')
    product = models.ForeignKey(Product, verbose_name=u'Продукт')
    parent = TreeForeignKey('self', null=True, blank=True, related_name='children', verbose_name=u'Родительский узел')
    type = models.CharField(max_length=2, choices=NODES_TYPES, verbose_name=u'Тип узла', db_index=True)
    curator = models.ForeignKey(User, null=True, blank=True, verbose_name = u'Куратор', related_name = 'node_curator')
    developer = models.ForeignKey(User, null=True, blank=True, verbose_name = u'Разработчик', related_name = 'node_developer')
    tester = models.ForeignKey(User, null=True, blank=True, verbose_name = u'Тестирощик', related_name = 'node_tester')
    cur_status = models.ForeignKey(Status, null=True, blank=True, verbose_name = u'Текущий статус')
    cur_release = models.ForeignKey(Release, null=True, blank=True, verbose_name = u'Текущий релиз')
    source = models.ForeignKey(Source, null=True, blank=True, verbose_name = u'Источник')
    source_description = models.CharField(max_length=300,null=True, blank=True, verbose_name=u'Описание источника')
    creation_date = models.DateTimeField(auto_now=True, verbose_name=u'Время создания')
    last_modified_date = models.DateTimeField(auto_now=True, verbose_name=u'Время последнего изменения')
    content = RichTextField(blank=True, null=True, verbose_name=u'Текст')
    files = models.ManyToManyField(File,  null=True, blank=True, verbose_name=u'Файлы')
    def __unicode__(self):
        return self.title
    class MPTTMeta:
        order_insertion_by = ['-title']
    class Meta:
        verbose_name = _(u'узел дерева')
        verbose_name_plural = _(u'Узлы дерева')
        ordering = ['creation_date']


class StatusHistory(models.Model):
    id_node = models.ForeignKey(Node, verbose_name=u'Узел')
    id_status = models.ForeignKey(Status, verbose_name=u'Статус', db_index=False)
    description = models.TextField(blank=True, verbose_name=u'Описание')
    date = models.DateTimeField(auto_now=True)
    def __unicode__(self):
        return '%s: %s' % (self.id_node.title, self.id_status.title)
    class Meta:
        verbose_name = _(u'историю смены статусов')
        verbose_name_plural = _(u'История смены статусов')

class ReleaseHistory(models.Model):
    id_node = models.ForeignKey(Node, verbose_name=u'Узел')
    id_release = models.ForeignKey(Release, verbose_name=u'Релиз', db_index=False)
    description = models.TextField(blank=True, verbose_name=u'Описание')
    date = models.DateTimeField(auto_now=True)
    def __unicode__(self):
        return '%s: %s' % (self.id_node.title, self.id_release.name)
    class Meta:
        verbose_name = _(u'историю смены релиза')
        verbose_name_plural = _(u'История смены релиза')





