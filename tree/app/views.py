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
#    node1 = Node.objects.get(id=2)
#    ch = node1.get_ancestors
    return render_to_response('index.html',{'media':media, 'nodes':nodes})


def any(request):
    return render_to_response("any.html", {'media':media})



@csrf_exempt
def getRequirements(request):
    message = ''
    if request.is_ajax():
        if request.method == 'POST':
            tie_id = request.POST['liId'].replace('req_tie_','')
            print tie_id
            reqs = Requirement.objects.filter(type__name == 'business')#node__id == tie_id)
            for req in reqs:
                message += '''<li><div><p>
                        <a href="#" id="business_%d_req_tie_%s" class="open_tab business"> %s </a>
                        </p></div></li>''' %(req.id, tie_id, req.name)
            # Здесь мы можем обратиться к POST данным
    return HttpResponse(message)

