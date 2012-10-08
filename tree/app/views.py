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
    if request.is_ajax():
        if request.method == 'POST':
            req_id = request.POST['reqId'].replace('req_','')
            req = RequirementsEdition.objects.filter(requirement = req_id).order_by('-redaction_date')[0]
            return render_to_response("requirement.html", {'req':req})
    return HttpResponse('Error: Does\'n get ajax. request is: \n' + str(request))

@csrf_exempt
def getNodeDescription(request):
    if request.is_ajax():
        if request.method == 'POST':
            node_id = request.POST['nodeId'].replace('description_tie_','')
            node = NodeEditionHistory.objects.filter(node = node_id).order_by('-redaction_date')[0]
            return render_to_response("node.html", {'node':node})
    return HttpResponse('Error: Does\'n get ajax. request is: \n' + str(request))

@csrf_exempt
def showAddNodeForm(request):
    if request.is_ajax():
        if request.method == 'POST':
            releases = Release.objects.all()
            people = User.objects.all()
            try:
                parent = request.POST['parentId']
                print 'parent - ' + parent
            except:
                print '!!'
                node = Node.objects.create(
                    name = u'',
                )
                return render_to_response("add_node.html", {'node':node, 'people':people, 'releases': releases})
            else:
                parent_node_id = request.POST['parentId'].replace('description_tie_','')
                parent = Node.objects.get(id = parent_node_id)
                print parent
                node = Node.objects.create(
                    name = u'',
                    parent = parent,
                    curator = User.objects.get(id=1),
                    base = False
                )
                print node
                return render_to_response("add_node.html", {'parent':parent, 'node':node, 'releases': releases, 'people': people})

    return HttpResponse('Error: Does\'n get ajax. request is: \n' + str(request))

@csrf_exempt
def nodeRepeal(request):
    print request.POST.lists

@csrf_exempt
def showAddReqForm(request):
    if request.is_ajax():
        if request.method == 'POST':
            releases = Release.objects.all()
            parent_node_id = request.POST['parentId'].replace('req_tie_','')
            node = Node.objects.get(id = parent_node_id)
            req = Requirement.objects.create(
                name = u'',
                node = node,
                release = Release.objects.get(id=1)
            )
            return render_to_response("add_req.html", {'parent':node, 'req':req, 'releases': releases})
    return HttpResponse('Error: Does\'n get ajax. request is: \n' + str(request.POST.lists))

@csrf_exempt
def addNode(request):
    if request.method == 'POST':
        print request.POST.lists
        node = Node.objects.get(id = request.POST['node'])
        node.curator = User.objects.get(id = request.POST['curator'])
        node.name = request.POST['name']
        node.status = Status.objects.get(id = 1)
        node.save()
        node_editor = NodeEditionHistory.objects.create(
            node = node,
            status = Status.objects.get(id = 1),
            release = Release.objects.get(id=request.POST['releases']),
            edit_description = 'только создано',
            description = request.POST['description']
        )
        return HttpResponseRedirect(request.META["HTTP_REFERER"] + '#tab_description_tie_' + str(node_editor.id))
    return HttpResponse('Error: Does\'n get ajax. request is: \n' + str(request.POST))

def getIDSet(data):
    set = []
    for i in data:
        set.append(i.split('_')[-1])
    return set

@csrf_exempt
def deleteNode(request):
    if request.method == 'POST':
        id = request.POST['node']
        delete_node_babies(id)
        try:
            parent = Node.objects.get(id=id).parent
        except ():
            Node.objects.get(id=id).delete()
            return render_to_response("node.html", {'node': Node.objects.get(id=id+1)})
        else:
            parent_editor = NodeEditionHistory.objects.filter(node = parent.id).order_by('-redaction_date')[0]
            Node.objects.get(id=id).delete()
            return render_to_response("node.html", {'node':parent_editor})
    return HttpResponse('Error: Does\'n get ajax. request is: \n' + str(request.POST))

@csrf_exempt
def deleteRequirement(request):
    if request.is_ajax():
        if request.method == 'POST':
            req_id = request.POST['req']
            Requirement.objects.get(id = req_id).delete()
            editor = NodeEditionHistory.objects.filter(id = request.POST['node']).order_by('-redaction_date')[0]
            return HttpResponseRedirect(request.META["HTTP_REFERER"] + '#tab_description_tie_' + str(editor.id))
    return HttpResponse('Error: Does\'n get ajax. request is: \n' + str(request.POST.lists))

def delete_node_babies(node_id):
    babies = Node.objects.filter(parent=node_id)
    for i in babies:
        delete_node_babies(i.id)
        Node.objects.get(id=i.id).delete()

@csrf_exempt
def addRequirement(request):
    if request.method == 'POST':
        print request.POST.lists
        req = Requirement.objects.get(id = request.POST['node'])
        curator = User.objects.get(id = request.POST['curator'])
        req.name = request.POST['name']
        req.save()
        curr_deadline = request.POST['req_deadline']
        curr_deadline = '-'.join(reversed(curr_deadline.split('.')))
        requirement_editor = RequirementsEdition.objects.create(
            reason = request.POST['reason'],
            requirement = req,
            edit_description = 'только создано',
            user = request.user,
            deadline = curr_deadline,
            curator = curator,
            description = request.POST['description']
        )
        return HttpResponseRedirect(request.META["HTTP_REFERER"] + '#tab_description_tie_' + str(requirement_editor.id))
    return HttpResponse('Error: Does\'n get ajax. request is: \n' + str(request.POST))

@csrf_exempt
def saveRequirementEdition(request):
    if request.method == 'POST':
        get_requirement = Requirement.objects.get(id=str(request.POST['req']))
        prev_req = RequirementsEdition.objects.filter(requirement = get_requirement).order_by('-redaction_date')[0]
        curr_description = request.POST['description']
        curr_reason = request.POST['reason']

        set_of_files= []
        for i in request.POST.getlist('req_files'):
            get_id = i.split('_')
            set_of_files.append( FileInNodes.objects.get(id = get_id[-1]))
        curator = User.objects.get(id = request.POST['curator'])
        prev_req.requirement.name = request.POST['name']
        prev_req.requirement.save()
        curr_req = prev_req.requirement
        curr_deadline = '-'.join(reversed(request.POST['req_deadline'].split('.')))

        new_requirement = RequirementsEdition.objects.create(
            description = curr_description,
            requirement = curr_req,
            edit_description = request.POST['edit_description'],
            user = request.user,
            deadline = curr_deadline,
            curator = curator,
        )
        new_requirement.files = set_of_files
        new_requirement.save()
        print new_requirement.deadline
        return HttpResponseRedirect(request.META["HTTP_REFERER"] + '#tab_req_' + request.POST['req'])

@csrf_exempt
def saveNodeEdition(request):
    if request.method == 'POST':
        get_node = Node.objects.get(id=str(request.POST['node']))
        prev_node = NodeEditionHistory.objects.filter(node = get_node).order_by('-redaction_date')[0]
        curr_description = request.POST['description']
        curr_purpose = request.POST['purpose']

        set_of_files= []
        for i in request.POST.getlist('node_files'):
            get_id = i.split('_')
            set_of_files.append( FileInNodes.objects.get(id = get_id[-1]))

        prev_node.node.name = request.POST['name']
        prev_node.node.save()
        curator = request.POST['curator']
        new_node = NodeEditionHistory.objects.create(
            description = curr_description,
            node = prev_node.node,
            edit_description = request.POST['edit_description'],
            user = request.user,
            release = Release.objects.get(name = request.POST['release']),
            curator = curator,
            base = False
        )
        new_node.files = set_of_files
        new_node.save()
        return HttpResponseRedirect(request.META["HTTP_REFERER"] + '#tab_description_tie_' + request.POST['node'])

@csrf_exempt
def addingFiles(request):
    new_file = FileInNodes.objects.create(
        file=request.FILES['added_file'],
        name = request.FILES['added_file'].name
    )
    if request.POST['file_name']!=u'введи новое имя файла':
        extension = new_file.name.split('.')[-1]
        new_file.name = new_file.name.replace(new_file.name[:new_file.name.find(extension)-1], request.POST['file_name'])
    new_file.save()
    curr_req_editor = RequirementsEdition.objects.get(id=request.POST['req_id'])
    curr_req_editor.files.add(new_file)
    files = curr_req_editor.files
    return HttpResponse(files)

@csrf_exempt
def addingFilesInNodes(request):
    new_file = FileInNodes.objects.create(
        file=request.FILES['added_file'],
        name = request.FILES['added_file'].name
    )
    if request.POST['file_name']!=u'введи новое имя файла':
        extension = new_file.name.split('.')[-1]
        new_file.name = new_file.name.replace(new_file.name[:new_file.name.find(extension)-1], request.POST['file_name'])
    new_file.save()
    curr_node_editor = NodeEditionHistory.objects.get(id=request.POST['node_id'])
    curr_node_editor.files.add(new_file)
    files = curr_node_editor.files
    return HttpResponse(files)