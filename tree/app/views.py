# -*- coding: utf-8 -*-
from django.shortcuts import render_to_response
from django.conf import settings
from django.template.context import RequestContext
from app.models import *
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render_to_response

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
                        <a id="req_%d" class="open_tab reqs"><span></span> %s </a><span class="edit req"></span><span class="delete req"></span>
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
def showAddNodeForm(request):
    if request.is_ajax():
        if request.method == 'POST':
            parent_node_id = request.POST['parentId'].replace('description_tie_','')
            parent = Node.objects.get(id = parent_node_id)
            node = Node.objects.create(
                name = u'',
                parent = parent
            )
            people = User.objects.all()
            return render_to_response("add_node.html", {'parent':parent, 'node':node, 'people':people,})
    return HttpResponse('Error: Does\'n get ajax. request is: \n' + str(request))

@csrf_exempt
def addNode(request):
    if request.method == 'POST':
        print request.POST.lists
        node = Node.objects.get(id = request.POST['node'])
        node.name = request.POST['name']
        node.save()
        node_editor = NodeEditionHistory.objects.create(
            reason = request.POST['reason'],
            node = node,
            release = Release.objects.get(id=2),
            edit_description = 'только создано',
            user = request.user,
            cur_task = CurrentTask.objects.get(id=1),
            description = request.POST['description']
        )
        return HttpResponseRedirect(request.META["HTTP_REFERER"] + '#tab_description_tie_' + str(node_editor.id))
    return HttpResponse('Error: Does\'n get ajax. request is: \n' + str(request.POST))

@csrf_exempt
def saveRequirementEdition(request):
    if request.method == 'POST':
        print request.POST.lists
        for i in request.POST:
            print i + '  ' + request.POST[i]

        get_requirement = Requirement.objects.get(id=str(request.POST['req']))
        prev_req = RequirementsEdition.objects.filter(requirement = get_requirement).order_by('-redaction_date')[0]
        curr_description = request.POST['description']
        curr_reason = request.POST['reason']

        set_of_files= []
        for i in request.POST.getlist('req_files'):
            get_id = i.split('_')
            set_of_files.append( FileInNodes.objects.get(id = get_id[-1]))

        prev_req.requirement.name = request.POST['name']
        prev_req.requirement.save()
        curr_req = prev_req.requirement
        curr_deadline = request.POST['req_deadline']
        task_id = request.POST['cur_task'].split('_')[-1]
        curr_task = CurrentTask.objects.get(id = task_id)

        new_requirement = RequirementsEdition.objects.create(
            description = curr_description,
            reason = curr_reason,
            requirement = curr_req,
            edit_description = request.POST['edit_description'],
            user = request.user,
            deadline = curr_deadline,
            cur_task = curr_task,
        )
        new_requirement.files = set_of_files
        new_requirement.save()
        return HttpResponseRedirect(request.META["HTTP_REFERER"] + '#tab_req_' + request.POST['req'])

    #дописать сохранение требования


@csrf_exempt
def saveNodeEdition(request):
    if request.method == 'POST':
        get_node = Node.objects.get(id=str(request.POST['node']))
        prev_node = NodeEditionHistory.objects.filter(node = get_node).order_by('-redaction_date')[0]
        curr_description = request.POST['description']
        curr_reason = request.POST['reason']

        #файлы
        set_of_files= []
        for i in request.POST.getlist('node_files'):
            get_id = i.split('_')
            set_of_files.append( FileInNodes.objects.get(id = get_id[-1]))

        #редактируемое БТ + релиз
        prev_node.node.name = request.POST['name']
        prev_node.node.save()
        curr_bus_req = prev_node.node

        curr_release = Release.objects.get(name = request.POST['release'])

        #задание
        task_id = request.POST['cur_task'].split('_')[-1]
        curr_task = CurrentTask.objects.get(id = task_id)

        new_node = NodeEditionHistory.objects.create(
            description = curr_description,
            reason = curr_reason,
            node = curr_bus_req,
            edit_description = request.POST['edit_description'],
            user = request.user,
            cur_task = curr_task,
            release = curr_release,
        )
        new_node.files = set_of_files
        new_node.save()

        #        files.append(FileInNodes.objects.get(id = request.POST.getlist('node_files')[i].))
        return HttpResponseRedirect(request.META["HTTP_REFERER"] + '#tab_description_tie_' + request.POST['node'])


@csrf_exempt
def addingFiles(request):
    new_file = FileInNodes.objects.create(
        file=request.FILES['added_file'],
        name = request.FILES['added_file'].name
    )
    new_file.save()
    print request
    curr_req_editor = RequirementsEdition.objects.get(id=request.POST['req_id'])
    curr_req_editor.files.add(new_file)
    files = curr_req_editor.files
    return HttpResponse(files)

@csrf_exempt
def getFiles(request):
    if request.method == 'POST':
        get_id = request.POST['id']
        return HttpResponse('trg')