# -*- coding: utf-8 -*-
from django.views.decorators.csrf import csrf_exempt
from django.template.context import RequestContext
from django.shortcuts import render_to_response
from django.http import HttpResponse
from django.conf import settings
from django.db.models import Q
from app.models import *
import datetime
import shutil
import os

DELETED = Status.objects.get(id = 6)
NOT_AVAILABLE_NODES = {}

# Стартовая страница
def homePage(request):
    products = Product.objects.all()
    user = request.user
    return render_to_response('index.html',{'main_content':'main.html', 'user':user, 'products' : products, 'media_root':settings.MEDIA_ROOT})


# Страница дерева продукта
def productPage(request, name):
    products = Product.objects.all()
    try:
        cur_product = Product.objects.get(short_name=name)
        nodes = Node.objects.filter(product = cur_product.id).exclude(type = 'OR').exclude(cur_status = DELETED)
        user = request.user
        return render_to_response('index.html',{'main_content':'tree.html', 'nodes':nodes,'user':user, 'products' : products, 'cur_product':cur_product, 'colorItems': StatusColorUser.objects.filter(user = request.user.id)})
    except Exception:
        homePage(request)

# Страница справочников
def catalogs(request, name):
    try:
        cur_product = Product.objects.get(short_name=name)
        products = Product.objects.all()
        user = request.user
        return render_to_response('index.html',{'main_content':'catalog.html', 'user':user, 'products' : products, 'cur_product':cur_product})
    except Exception:
        homePage(request)

# Страница словаря
def dictionary(request, name):
    try:
        cur_product = Product.objects.get(short_name=name)
        products = Product.objects.all()
        user = request.user
        items = Term.objects.filter(product = cur_product)
        return render_to_response('index.html',{'main_content':'dictionary.html', 'items':items, 'user':user, 'products' : products, 'cur_product':cur_product})
    except Exception:
        homePage(request)

#Получаем словарь Статусов
@csrf_exempt
def getStatusCatalog(request):
    statuses = Status.objects.all()
    colorItems = StatusColorUser.objects.filter(user = request.user.id)
    cur_product = Product.objects.get(short_name = request.POST['product'])
    return render_to_response('statusCatalog.html',{
        'statuses':statuses,
        'cur_product':cur_product,
        'colorItems': colorItems
    })

#Сохраням цвета для статусов
@csrf_exempt
def saveStatuses(request):
    statuses = Status.objects.all()
    colors = request.POST['colors'].split('; ')
    for index, status in enumerate(statuses):
        try:
            item = StatusColorUser.objects.get(user = request.user, status = status)
        except Exception:
            item = StatusColorUser(user = request.user, status = status)
        item.color = colors[index]
        item.save()
    return getStatusCatalog(request)

#Получаем словарь Источников
@csrf_exempt
def getSourceCatalog(request):
    cur_product = Product.objects.get(short_name = request.POST['product'])
    return render_to_response('sourceCatalog.html',{
        'sources': Source.objects.all(),
        'cur_product':cur_product
    })

# Добавить источник
@csrf_exempt
def addSourceCatalog(request):
    Source(source = request.POST['name']).save()
    sources = Source.objects.all()
    cur_product = Product.objects.get(short_name = request.POST['product'])
    return render_to_response('sourceCatalog.html',{
        'sources':sources,
        'cur_product':cur_product
    })

# Удалить источник
@csrf_exempt
def deleteSourceCatalog(request):
    for node in Node.objects.filter(source =  Source.objects.get(id = request.POST['id'])):
        node.source = None
        node.save()

    Source.objects.get(id = request.POST['id']).delete()
    sources = Source.objects.all()
    cur_product = Product.objects.get(short_name = request.POST['product'])
    return render_to_response('sourceCatalog.html',{
        'sources':sources,
        'cur_product':cur_product
    })

#Получаем словарь Релизов
@csrf_exempt
def getReleaseCatalog(request):
    cur_product = Product.objects.get(short_name = request.POST['product'])
    cant_delete = []
    for item in Release.objects.filter(product = cur_product):
        nodes = Node.objects.filter(cur_release = item)
        if nodes:
            cant_delete.append(item)
    return render_to_response('releaseCatalog.html',{
        'releases': Release.objects.filter(product = cur_product),
        'cur_product':cur_product,
        'cant_delete':cant_delete
    })

#Удалить Релиз
@csrf_exempt
def deleteReleaseCatalog(request):
    cur_product = Product.objects.get(short_name = request.POST['product'])
    Release.objects.get(id = request.POST['id']).delete()
    return getReleaseCatalog(request)

#Сохранить изменения в релизе
@csrf_exempt
def saveReleaseCatalog(request):
    try:
        release = Release.objects.get(id = request.POST['id'])
    except Exception:
        release = Release()
        pass
    release.name = request.POST['name']
    release.product = Product.objects.get(short_name = request.POST['product'])
    release.number= request.POST['number']
    if  request.POST['status'] == 'true':
        release.status= True
    else:
        release.status= False
    release.date= request.POST['date']
    release.description= request.POST['description']
    try:
        release.save()
    except Exception as e:
        return HttpResponse(e.args)
    return getReleaseCatalog(request)

# Получаем словарь пользователей
@csrf_exempt
def getUsersCatalog(request):
    users = User.objects.all()
    cur_product = Product.objects.get(short_name = request.POST['product'])
    return render_to_response('userCatalog.html',{
        'users':users,
        'cur_product':cur_product
    })

# Получаем все требования для узла
@csrf_exempt
def getRequirements(request):
    message = ''
    tie_id = request.POST['liId'].replace('tie_','')
    reqs = Node.objects.filter(parent__name_id = tie_id, type = 'OR').exclude(cur_status = DELETED)
    for req in reqs:
        colors = StatusColorUser.objects.filter(Q(user = request.user.id) | Q(status = req.cur_status.id))
        if colors:
            color = colors[0]
        else:
            color = req.cur_status.color
        message += '''<li><div><p>
                <a id="OR_%s" class="open_tab reqs" style="color:%s"><span class = "status_%s"></span> %s </a>
                </p></div></li>''' %(req.name_id, color.color , req.cur_status.id, req.title)
    return HttpResponse(message)

# Получить данные про узел
@csrf_exempt
def getNodeDescription(request):
    if request.is_ajax():
        if request.method == 'POST':
            node_id = request.POST['nodeId']
            node = Node.objects.get(name_id = node_id)
            return render_to_response("node.html", {'node':node,'colorItems': StatusColorUser.objects.filter(user = request.user.id)})
    return HttpResponse('POST: ' + str(request.POST))

# Получить id родительского узла для требования
@csrf_exempt
def getParentNode(request):
    if request.is_ajax():
        if request.method == 'POST':
            reqId = request.POST['reqId']
            node = Node.objects.get(name_id = reqId)
    return HttpResponse(node.parent.name_id)

# Удалить узел
@csrf_exempt
def deleteNode(request):
    if request.method == 'POST':
        node = Node.objects.get(name_id = request.POST['node'])
        delete_node_children(node.id)
        changeStatusInNode(node.id, DELETED, request.POST['comment'])
        if node.parent == 'None':
            return HttpResponse('/')
        return HttpResponse('/%s/#%s-%s' % (node.product.short_name, node.parent.type, node.parent.name_id.replace(node.product.short_name + '-', '')))

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
        product = Product.objects.get(id = request.POST['product'])
        try:
            last_added_node = Node.objects.filter(product = product).order_by('-creation_date')[0]
            i = int(last_added_node.name_id.replace(product.short_name + '-', ''))
        except Exception as e:
            i = 0
        node = Node()
        node.title = request.POST['name']
        node.product = product
        node.name_id = product.short_name + '-' + str(i + 1)
        if request.POST['parent'][:2] != 'PR':
            node.parent = Node.objects.get(name_id = request.POST['parent'].split('_')[1])
        node.type = request.POST['type']
        node.curator = request.user
        node.cur_status = Status.objects.get(id = 1)
        node.creation_date = datetime.datetime.now()
        node.save()
        changeStatusInNode(node.id, node.cur_status, comment='Just created')
        return HttpResponse('/%s/#%s-%s' % (node.product.short_name, node.type, node.name_id.split('-')[1]))

# Открыть режим редактирования узла
@csrf_exempt
def editNode(request):
    if request.method == 'POST':
        node = Node.objects.get(name_id = request.POST['nodeId'].split('_')[1])
        if NOT_AVAILABLE_NODES.has_key(node.name_id) and NOT_AVAILABLE_NODES[node.name_id] != request.user.get_full_name():
            return HttpResponse('Оперция не возможна: %s еще не закончил редактирование %s.' % (NOT_AVAILABLE_NODES[node.name_id], node.title))
        else:
            NOT_AVAILABLE_NODES[node.name_id] = request.user.get_full_name()
        statuses = []
        if node.cur_status.id > 1:
            statuses.append(Status.objects.get(id = int(node.cur_status.id) - 1))
        statuses.append(Status.objects.get(id = int(node.cur_status.id)))
        if node.cur_status.id < 5:
            statuses.append(Status.objects.get(id = int(node.cur_status.id) + 1))
        return render_to_response("editNode.html", {
            'node':node,
            'colorItems': StatusColorUser.objects.filter(user = request.user.id),
            'statuses':statuses,
            'sources': Source.objects.all(),
            'releases': Release.objects.filter(product = node.product).filter(status = False),
            'developers': User.objects.filter(groups__name='developers'),
            'testers': User.objects.filter(groups__name='testers')
        }, context_instance=RequestContext(request))

# Открыть для просмотра Папку или Продукт
@csrf_exempt
def getNodeLessEditable(request):
    if request.method == 'POST':
        type = request.POST['nodeId'].split('_')[0]
        if type == 'PR':
            product = Product.objects.get(short_name = request.POST['nodeId'].split('_')[1])
            return render_to_response("folder.html", {'product':product})
        elif type == 'NE':
            node = Node.objects.get(name_id = request.POST['nodeId'].split('_')[1])
            return render_to_response("folder.html", {'node':node}, context_instance=RequestContext(request))

# Открыть режим редактирования Папки или Продукта
@csrf_exempt
def editNodeLessEditable(request):
    if request.method == 'POST':
        type = request.POST['nodeId'].split('_')[0]
        if type == 'PR':
            product = Product.objects.get(short_name = request.POST['nodeId'].split('_')[1])
            if NOT_AVAILABLE_NODES.has_key(product.short_name) and NOT_AVAILABLE_NODES[product.short_name] != request.user.get_full_name():
                return HttpResponse('Оперция не возможна: %s еще не закончил редактирование %s.' % (NOT_AVAILABLE_NODES[product.short_name], product.title))
            else:
                NOT_AVAILABLE_NODES[product.short_name] = request.user.get_full_name()
                return render_to_response("editFolder.html", {'product':product}, context_instance=RequestContext(request))
        elif type == 'NE':
            node = Node.objects.get(name_id = request.POST['nodeId'].split('_')[1])
            if NOT_AVAILABLE_NODES.has_key(node.name_id) and NOT_AVAILABLE_NODES[node.name_id] != request.user.get_full_name():
                return HttpResponse('Оперция не возможна: %s еще не закончил редактирование %s.' % (NOT_AVAILABLE_NODES[node.name_id], node.title))
            else:
                NOT_AVAILABLE_NODES[node.name_id] = request.user.get_full_name()
                return render_to_response("editFolder.html", {'node':node}, context_instance=RequestContext(request))


# Отменить режим редактирования узла
@csrf_exempt
def cancelEditNode(request):
    if request.method == 'POST':
        if request.POST['nodeId'].split('_')[0] == 'PR':
            product = Product.objects.get(short_name = request.POST['nodeId'].split('_')[1])
            if NOT_AVAILABLE_NODES.has_key(product.short_name):
                del NOT_AVAILABLE_NODES[product.short_name]
                return HttpResponse('Node id to delete ' + product.short_name)
        else:
            node = Node.objects.get(name_id = request.POST['nodeId'].split('_')[1])
            if NOT_AVAILABLE_NODES.has_key(node.name_id):
                del NOT_AVAILABLE_NODES[node.name_id]
                return HttpResponse('Node id to delete ' + node.name_id)
    return HttpResponse('The method was\'t POST for some mystic reasons')

# Добавить новый релиз, и вернуться в режиме редактирования
@csrf_exempt
def addingReleaseInNode(request):
    product = Product.objects.get(short_name = request.POST['product'])
    description = request.POST['description']
    if description == u'Оставьте комментарий тут':
        description =''
    print 'DESCRIPTION :'+ description
    try:
        release = Release(
            name  = request.POST['name'],
            number = request.POST['number'],
            status = False,
            date = request.POST['date'],
            product = product,
            description = description
        )
        release.save()
        return HttpResponse("<option value='%s' selected='true'>%s %s </option>" % (release.id, release.name, release.date))
    except Exception as e:
        return HttpResponse('data error'+ e.message)


# Сохранить все изменения по узлу и вернуться в режим чтения.
@csrf_exempt
def saveNode(request):
    if request.method == 'POST' and request.POST['nodeId'].split('_')[0] != 'PR':
        node = Node.objects.get(name_id = request.POST['nodeId'].split('_')[1])
        if request.POST['status'] != 'None' :
            if node.cur_status != Status.objects.get(id = request.POST['status']):
                changeStatusInNode(node.id, Status.objects.get(id = request.POST['status']),request.POST['status_comment'])
        node.title = request.POST['title']
        if request.POST['release'] != 'None' :
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
        if request.POST['tester']!='None' :
            node.tester = User.objects.get(id = request.POST['tester'])
        else:
            node.tester = None
        if request.POST['source'] != 'None' :
            node.source = Source.objects.get(id = request.POST['source'])
        else:
            node.source = None
        node.source_description = request.POST['source_desc']
        node.content = replacePics(request.POST['node_desc'], node.name_id)
        node.creation_date = node.creation_date
        node.save()
        if NOT_AVAILABLE_NODES.has_key(node.name_id):
            del NOT_AVAILABLE_NODES[node.name_id]
        if node.type == 'NE':
            return render_to_response("folder.html", {'node':node})
        return render_to_response("node.html", {'node':node})
    elif request.POST['nodeId'].split('_')[0] == 'PR':
        product = Product.objects.get(short_name = request.POST['nodeId'].split('_')[1])
        product.title = request.POST['title']
        product.description = request.POST['node_desc']
        product.save()
        if NOT_AVAILABLE_NODES.has_key(product.short_name):
            del NOT_AVAILABLE_NODES[product.short_name]
        return render_to_response("folder.html", {'product':product})
    return HttpResponse('Not a POST for some reason : ' + str(request.POST['title']))

def replacePics(text, node_name):
    path = os.path.join(settings.MEDIA_ROOT, 'files', node_name)
    str = ''
    for root, dirs, files in os.walk(path):
        for fn in files:
            str += fn + '; '
            if fn.split('.')[1]=='png' or fn.split('.')[1]=='jpg' or fn.split('.')[1]=='gif' or fn.split('.')[1]=='JPEG' or fn.split('.')[1]=='jpeg':
                text = text.replace('!%s:small!' % fn, '<img src="/media/files/%s" style="width:200px; float: left; margin: 0 5px">' % os.path.join(node_name, fn))
                text = text.replace('!%s!' % fn, '<img src="/media/files/%s">' % os.path.join(node_name, fn))
                text = text.replace('!%s:a!' % fn, '<a href="/media/files/%s" target="_blank">%s</a>' %(os.path.join(node_name, fn), fn))
            else:
                text = text.replace('!%s!' % fn, '<a href="/media/files/%s" target="_blank">%s</a>' %(os.path.join(node_name, fn), fn))
    return text

# Сохраняем новые фыйлы для узла
@csrf_exempt
def addingFilesInNodes(request):
    name = request.FILES['file'].name
    temp_file = File(file=request.FILES['file'], name = name)
    if request.POST['name'] != u'Как называется твой новый файл?' and request.POST['name'].strip() != '':
        temp_file.name = request.POST['name'] + '.' + name.split('.')[1]
    temp_file.save()
    node = Node.objects.get(name_id = request.POST['node'])
    target = os.path.join(settings.MEDIA_ROOT, 'files', node.name_id)
    if not os.path.exists(target):
        os.mkdir(target)
    shutil.copy(os.path.join(settings.MEDIA_ROOT, temp_file.file.path), os.path.join(target, temp_file.name))
    name = temp_file.name
    os.remove(os.path.join(settings.MEDIA_ROOT, temp_file.file.path))
    temp_file.delete()
    return HttpResponse('<a href="/media/files/%s">%s</a>' % (os.path.join(node.name_id, name), name))


# Получаем список фалов для узла
@csrf_exempt
def getFiles(request):
    path = os.path.join(settings.MEDIA_ROOT, 'files', request.POST['node'])
    message= ''
    for root, dirs, files in os.walk(path):
        for fn in files:
            message += '<span class="file"><a href="/media/files/%s" target="_blank">%s</a><span class="delete" onclick=\'DeleteFile("%s")\'></span>;</span>' % (os.path.join(request.POST['node'],fn), fn, os.path.join(request.POST['node'],fn))
    return HttpResponse(message)

# Удаляем файл узла
@csrf_exempt
def deleteFile(request):
    os.remove(os.path.join(settings.MEDIA_ROOT, 'files', request.POST['file_path']))
    return HttpResponse( 'Deleted ' + os.path.join(settings.MEDIA_ROOT, 'files', request.POST['file_path']))

# Просмотр истории изменений с узлом
@csrf_exempt
def nodeHistory(request):
    if request.is_ajax():
        if request.method == 'POST':
            node = Node.objects.get(name_id = request.POST['nodeId'].split('_')[1])
            statusHistory = StatusHistory.objects.filter(id_node = node.id).order_by('-date')
            releaseHistory = ReleaseHistory.objects.filter(id_node = node.id).order_by('-date')
    return render_to_response("history.html", {'node':node, 'statusHistory':statusHistory,'releaseHistory':releaseHistory, 'colorItems': StatusColorUser.objects.filter(user = request.user.id)})

# Открываем корзину
@csrf_exempt
def openTrash(request):
    deletedNodes = Node.objects.filter(cur_status = 6, product = Product.objects.get(short_name = request.POST['product']))
    nodes = StatusHistory.objects.filter(id_node__in = deletedNodes).filter(id_status = 6).filter(id_node__type = 'BR').order_by('-date')
    requirements = StatusHistory.objects.filter(id_node__in = deletedNodes).filter(id_status = 6).filter(id_node__type = 'OR').order_by('-date')
    return render_to_response("trash.html", {'nodes':checkForRepeatable(nodes), 'requirements':checkForRepeatable(requirements)})

# Убираем повторения истории узла
def checkForRepeatable(nodesHistory):
    existing_nodes = []
    for i, node in enumerate(nodesHistory):
        if node.id_node.id not in existing_nodes:
            existing_nodes.append(node.id_node.id)
        else:
            nodesHistory = nodesHistory.exclude(id = node.id)
    return nodesHistory.order_by('-date')

# Восстанавливем файлы из корзины
@csrf_exempt
def restoreTrash(request):
    nodes = request.POST['nodes']
    nodes = nodes.split('; ')
    for i in nodes:
        if i != '':
            status = StatusHistory.objects.filter(id_node = i).order_by('-date')[1]
            changeStatusInNode(i, status.id_status, 'Восстановлено из корзины')
    return HttpResponse('ok')


# Сохранить новый термин
@csrf_exempt
def saveTerm(request):
    newTerm = Term(product = Product.objects.get(short_name = request.POST['product']), name = request.POST['term_name'], description=request.POST['term_decs'])
    newTerm.save()
    return HttpResponse(newTerm.id)

# Получить описание термина по id
@csrf_exempt
def getTermById(request):
    term = Term.objects.get(id = request.POST['term_id'])
    return HttpResponse('%s#!%s' %(term.name, term.description))


# Получить список терминов для продукта
@csrf_exempt
def getTerms(request):
    list = u''
    product = Product.objects.get(short_name = request.POST['product'])
    for term in Term.objects.filter(product = product):
        list += u'%s&#%s!#' % (term.name, term.id)
    return HttpResponse(list)

def checking(request):
#    NOT_AVAILABLE_NODES = {}
    return HttpResponse(str(NOT_AVAILABLE_NODES))






