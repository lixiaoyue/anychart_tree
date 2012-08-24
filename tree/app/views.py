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
                        <a id="req_%d" class="open_tab reqs"><span></span> %s </a><span class="edit"></span><span class="delete"></span>
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

@csrf_exempt
def getNodeDescription(request):
    if request.is_ajax():
        if request.method == 'POST':
            node_id = request.POST['nodeId'].replace('description_tie_','')
            node = NodeEditionHistory.objects.filter(node = node_id).order_by('-redaction_date')[0]
            return render_to_response("node.html", {'node':node, 'tasks': CurrentTask.objects.all()[0:2]})
    return HttpResponse('Error: Does\'n get ajax. request is: \n' + str(request))

@csrf_exempt
def saveNodeEdition(request):
    if request.method == 'POST':
        print request.POST.lists
        for i in request.POST:
            print i + '  ' + request.POST[i]
        get_node = Node.objects.get(id=str(request.POST['node']))
        prev_node = NodeEditionHistory.objects.filter(node = get_node).order_by('-redaction_date')[0]
        curr_description = request.POST['edit_description']
        curr_reason = request.POST['reason']

        #файлы
        set_of_files= []
        print type(request.POST.getlist('node_files'))
        for i in request.POST.getlist('node_files'):
            print 'in'
            get_id = i.split('_')
            set_of_files.append( FileInNodes.objects.get(id = get_id[-1]))

        #редактируемое БТ + релиз
        curr_bus_req = prev_node.node
        curr_release_name = request.POST['release']
        curr_release = Release.objects.get(name = curr_release_name)

        #задание
        task_id = request.POST['cur_task'].split('_')[-1]
        curr_task = CurrentTask.objects.get(id = task_id)
        node = NodeEditionHistory.objects.create(description = curr_description,
            reason = curr_reason,
            node = curr_bus_req,
            edit_description = curr_description,
            user = request.user,
            cur_task = curr_task,
            release = curr_release)
        node.files = set_of_files

        #        files.append(FileInNodes.objects.get(id = request.POST.getlist('node_files')[i].))
        return HttpResponse(str(request.POST.getlist('node_files')))




