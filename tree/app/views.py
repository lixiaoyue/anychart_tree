# -*- coding: utf-8 -*-
from django.shortcuts import render_to_response
from django.conf import settings
from models import Node
media = settings.MEDIA_URL

def home_page(request):
    nodes = Node.objects.all()
    return render_to_response('index.html',{'media':media})