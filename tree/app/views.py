# Create your views here.
# -*- coding: utf-8 -*-
from django.shortcuts import render_to_response
from django.template import  RequestContext, Template
from django.conf import settings

def home_page(request):
    return render_to_response('index.html')