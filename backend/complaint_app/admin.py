from django.contrib import admin
from .models import Complaint

class ComplaintAdmin(admin.ModelAdmin):
    list_display = ('title', 'status', 'assigned_to', 'created_at')
    list_editable = ('status', 'assigned_to')  # ye line allow karti hai inline edit in list view

admin.site.register(Complaint, ComplaintAdmin)
