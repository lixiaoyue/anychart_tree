# -*- coding: utf-8 -*-
from django.shortcuts import render_to_response
from django.conf import settings
from django.template.context import RequestContext
from app.models import *
from django.http import HttpResponse

from django.views.decorators.csrf import csrf_exempt
media = settings.MEDIA_URL

def home_page(request):
    nodes = Node.objects.all()
    user = request.user
    return render_to_response('index.html',{'media':media, 'nodes':nodes,'user':user})

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
                        <a href="#" id="req_%d" class="open_tab reqs"><span></span> %s </a><span class="edit"></span><span class="delete"></span>
                        </p></div></li>''' %(req.id, req.name)
    return HttpResponse(message)

@csrf_exempt
def getRequirementDescription(request):
    tasks = CurrentTask.objects.all()
    if request.is_ajax():
        if request.method == 'POST':
            req_id = request.POST['reqId'].replace('req_','')
            req = RequirementsEdition.objects.filter(requirement = req_id).order_by('-redaction_date')[0]
    return render_to_response("requirement.html", {'req':req, 'task': tasks})
