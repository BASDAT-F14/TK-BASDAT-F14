from django.urls import path, include
from . import views
from fitur_abil.views import *

from . import views

urlpatterns = [
    path('', show_main, name='show_main'),
]