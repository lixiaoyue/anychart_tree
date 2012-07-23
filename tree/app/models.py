#coding=utf-8
from django.db import models

# Create your models here.
class Cathedra(models.Model):
    name = models.CharField('название кафедры', max_length=20)

class Hobb(models.Model):
    name = models.CharField('название хобби', max_length=10)

class Student(models.Model):
    name = models.CharField('имя студента', max_length=30)
    myHobby = models.ManyToManyField(Hobb)

class Prepod(models.Model):
    first_name = models.CharField('имя препода', max_length=30)
    last_name = models.CharField('фамилия его же', max_length=30)
    character = models.CharField('характер', max_length=20)
    cathedra = models.ForeignKey(Cathedra)
    blue_eyed_boy = models.OneToOneField(Student)