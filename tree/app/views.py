# -*- coding: utf-8 -*-
from django.shortcuts import render_to_response
from django.conf import settings
from app.models import Node
media = settings.MEDIA_URL

def home_page(request):
    nodes = Node.objects.all()
#    node1 = Node.objects.get(id=2)
#    ch = node1.get_ancestors
    return render_to_response('index.html',{'media':media, 'nodes':nodes})