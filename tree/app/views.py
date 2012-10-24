# -*- coding: utf-8 -*-
from django.views.decorators.csrf import csrf_exempt
from django.template.context import RequestContext
from django.shortcuts import render_to_response
#from django.shortcuts import redirect
from django.http import HttpResponse
from django.conf import settings
from app.models import *
import datetime

DELETED = Status.objects.get(id = 6)
media = settings.MEDIA_URL
NOT_AVAILABLE_NODES = {}

# Стартовая страница - строим дерево узлов
def homePage(request):
    products = Product.objects.all()
    cur_product = Product.objects.get(id=1)
    nodes = Node.objects.filter(product = 1).exclude(type = 'OR').exclude(cur_status = DELETED)
    user = request.user
    return render_to_response('index.html',{'media':media, 'nodes':nodes,'user':user, 'products' : products, 'cur_product':cur_product})

# Получаем все требования для узла
@csrf_exempt
def getRequirements(request):
    message = ''
    if request.is_ajax():
        if request.method == 'POST':
            tie_id = request.POST['liId'].replace('req_tie_','')
            reqs = Node.objects.filter(parent = tie_id, type = 'OR').exclude(cur_status = DELETED)
            for req in reqs:
                message += '''<li><div><p>
                        <a id="req_%d" class="open_tab reqs" style="color:%s"><span class = "status_%d"></span> %s </a>
                        </p></div></li>''' %(req.id, req.cur_status.color, req.cur_status.id, req.title)
    return HttpResponse(message)

# Получить данные про узел
@csrf_exempt
def getNodeDescription(request):
    if request.is_ajax():
        if request.method == 'POST':
            node_id = request.POST['nodeId'].replace('description_tie_','').replace('req_','')
            node = Node.objects.get(id = node_id)
    return render_to_response("node.html", {'node':node})

# Удалить узел
@csrf_exempt
def deleteNode(request):
    id = request.POST['node']
    node = Node.objects.get(id=id)
    delete_node_children(id)
    changeStatusInNode(id, DELETED, request.POST['comment'])
    return HttpResponse('/#tab_description_tie_%d' % node.parent.id)

# Удалить детей узла (Id узла)
def delete_node_children(node_id):
    children = Node.objects.filter(parent=node_id)
    for i in children:
        delete_node_children(i.id)
        status = Status.objects.get(id = 6)
        changeStatusInNode(i.id, status)

# Поменять статус узла и записать в историю,(Id узла, новый статус, комметратий - почему меняем статус.)
def changeStatusInNode(node_id, status, comment=''):
    node = Node.objects.get(id=node_id)
    history = StatusHistory(
        id_node = node,
        id_status = status,
        description = comment,
        date = datetime.datetime.now()
    ).save()
    node.cur_status = status
    node.save()

# Поменять release узла и записать в историю,(Id узла, новый статус, комметратий - почему меняем статус.)
def changeReleaseInNode(node_id, release, comment=''):
    node = Node.objects.get(id=node_id)
    history = ReleaseHistory(
        id_node = node,
        id_release = release,
        description = comment,
        date = datetime.datetime.now()
    ).save()
    node.cur_release = release
    node.save()

#Добавить новый узел
@csrf_exempt
def addNode(request):
    if request.method == 'POST':
        node = Node()
        node.title = request.POST['name']
        node.product = Product.objects.get(id = request.POST['product'])
        node.parent = Node.objects.get(id = request.POST['parent'])
        node.type = request.POST['type']
        node.curator = request.user
        node.cur_status = Status.objects.get(id = 1)
        node.save()
        changeStatusInNode(node.id, node.cur_status, comment='Just created')
        if node.type == 'OR':
            return HttpResponse('/#tie_%d:req_%d' % (node.parent.id, node.id))
        else:
            return HttpResponse('/#tab_description_tie_%d' % node.id)

# Открыть режим редактирования узла
@csrf_exempt
def editNode(request):
    if request.method == 'POST':
        node = Node.objects.get(id = request.POST['nodeId'])
        if NOT_AVAILABLE_NODES.has_key(node.id) and NOT_AVAILABLE_NODES[node.id] != request.user.get_full_name():
            return HttpResponse('Error: %s is editing node.' % NOT_AVAILABLE_NODES[node.id])
        else:
            NOT_AVAILABLE_NODES[node.id] = request.user.get_full_name()
        return render_to_response("editNode.html", {
            'node':node,
            'statuses':Status.objects.all(),
            'sources': Source.objects.all(),
            'releases': Release.objects.all(),
            'developers': User.objects.filter(groups__name='developers'),
            'testers': User.objects.filter(groups__name='testers')
        }, context_instance=RequestContext(request))

# Отменить режим редактирования узла
@csrf_exempt
def cancelEditNode(request):
    if request.method == 'POST':
        node = Node.objects.get(id = request.POST['nodeId'])
        try:
            del NOT_AVAILABLE_NODES[node.id]
            return HttpResponse('ok')
        except Exception as e:
            return HttpResponse(e.message)
    return HttpResponse('The method was\'t POST for some mystic reasons')

# Добавить новый релиз, и вернуться в режиме редактирования
@csrf_exempt
def addingReleaseInNode(request):
    if request.method == 'POST':
        product = Product.objects.get(id = request.POST['product'])
        release = Release(
            name  = request.POST['name'],
            number = request.POST['number'],
            status = False,
            date =  request.POST['date'],
            product = product,
            description = request.POST['description']
        )
        release.save()
        return HttpResponse("<option value='%s' selected='true'>%s </option>" % (release.id, release.name))
    else:
        return HttpResponse("Not a POST! " + str(request.method))

# Сохранить все изменения по узлу и вернуться в режим чтения.
@csrf_exempt
def saveNode(request):
    if request.method == 'POST':
        node = Node.objects.get(id = request.POST['nodeId'])
        if node.cur_status != Status.objects.get(id = request.POST['status']):
            changeStatusInNode(node.id, Status.objects.get(id = request.POST['status']),request.POST['status_comment'])
        node.title = request.POST['title']
        if request.POST['release'] != 'None':
            if node.cur_release != Release.objects.get(id = request.POST['release']):
                changeReleaseInNode(node.id, Release.objects.get(id = request.POST['release']), request.POST['release_comment'])
                node.cur_release = Release.objects.get(id = request.POST['release'])
        else:
            node.cur_release = None
        if request.POST['status'] !='None':
            node.cur_status = Status.objects.get(id = request.POST['status'])
        else:
            node.cur_status = None
        if request.POST['developer'] !='None':
            node.developer = User.objects.get(id = request.POST['developer'])
        else:
            node.developer = None
        if request.POST['tester']!='None':
            node.tester = User.objects.get(id = request.POST['tester'])
        else:
            node.tester = None
        if request.POST['source'] != 'None':
            node.source = Source.objects.get(id = request.POST['source'])
        else:
            node.source = None
        node.source_description = request.POST['source_desc']
        node.content = request.POST['node_desc']
#        TODO сохранить измениея files (request.POST['files[]'])

        node.save()
        if NOT_AVAILABLE_NODES.has_key(node.id):
            del NOT_AVAILABLE_NODES[node.id]
        return render_to_response("node.html", {'node':node})
    return HttpResponse('Not a POST for some reason : ' + str(request.method))


@csrf_exempt
def addingFilesInNodes(request):
    try:
        new_file = File.objects.create(
            file=request.FILES['file'],
            name = request.FILES['file'].name
        )
        if request.POST['name']!=u'Как называется твой новый файл?':
            extension = new_file.name.split('.')[-1]
            new_file.name = new_file.name.replace(new_file.name[:new_file.name.find(extension)-1], request.POST['name'])
        new_file.save()
        node = Node.objects.get(id = request.POST['node'])
        node.files.add(new_file)
        return HttpResponse('<a id="file_%s" href="/media%s">%s</a>' %(new_file.id, new_file.file, new_file.name))
    except Exception as e:
        return HttpResponse('Message from adding file is : \n' + e.message)

@csrf_exempt
def getFiles(request):
    if request.method == 'POST':
        try:
            node = Node.objects.get(id = request.POST['node'])
            message= ''
            for file in node.files.all():
                message += '<span class="file"><a id="f_%s" href="/media/%s" target="_blank">%s</a><span class="delete" id ="file_%s"></span>;</span> ' %(file.id, file.file, file.name, file.id)
            return HttpResponse(message)
        except Exception as e:
            return HttpResponse('Message from get Files is : \n' + str(e.args))
    return HttpResponse('Not POST type of ajax : \n' + str(request.method))

@csrf_exempt
def deleteFile(request):
    if request.method == 'POST':
        try:
            file = File.objects.get(id = request.POST['file_id'])
            file.delete()
            return HttpResponse('File deleted')
        except Exception as e:
            return HttpResponse('Message from get Files is : \n' + str(e.args))
    return HttpResponse('Not POST type of ajax : \n' + str(request.method))






#def checking(request):
#    return HttpResponse(str(NOT_AVAILABLE_NODES))






