from django.urls import path
from .views import get_complaints, add_complaint

urlpatterns = [
    path('complaints/', get_complaints),
    path('add/', add_complaint),
]
