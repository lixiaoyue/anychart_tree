from app.models import Cathedra
from app.models import Hobb
from app.models import Student
from app.models import Prepod
from django.contrib import admin

class PrepodAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name', 'character')

admin.site.register(Prepod, PrepodAdmin)
admin.site.register(Hobb)
admin.site.register(Student)
admin.site.register(Cathedra)