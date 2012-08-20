# -*- coding: utf-8 -*-
from django.shortcuts import render_to_response
from django.conf import settings
from django.template.context import RequestContext
from app.models import Node, Requirement
from django.http import HttpResponse

from django.views.decorators.csrf import csrf_exempt
media = settings.MEDIA_URL

def home_page(request):
    nodes = Node.objects.all()
    return render_to_response('index.html',{'media':media, 'nodes':nodes})

def any(request):
    return render_to_response("any.html", {'media':media})

@csrf_exempt
def getRequirements(request):
    message = ''
    if request.is_ajax():
        if request.method == 'POST':
            tie_id = request.POST['liId'].replace('req_tie_','')
            reqs = Requirement.objects.filter(node = tie_id)
            for req in reqs:
                message += '''<li><div><p>
                        <a href="#" id="req_%d" class="open_tab reqs"> %s </a>
                        </p></div></li>''' %(req.id, req.name)
    return HttpResponse(message)

@csrf_exempt
def getRequirementDescription(request):
    if request.is_ajax():
        if request.method == 'POST':
            req_id = request.POST['reqId'].replace('req_','')
            req = Requirement.objects.get(id = req_id)
    return render_to_response("requirement.html", {'req':req})