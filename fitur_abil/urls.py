from django.urls import path, include
from . import views
from fitur_abil.views import *
from . import views

app_name = 'fitur_abil'

urlpatterns = [
    path('', views.guest, name='guest'),
    path('main/', views.show_main, name='main'),
    path('daftar_tayang/', views.daftar_tayang, name='daftar_tayang'),
    path('daftar_tayang_guest/', views.daftar_tayang_guest, name='daftar_guest'),
    path('daftar_kontributor/', views.daftar_kontributor, name='daftar_kontributor'),
    path('favorit/', views.favorit, name='favorit'),
    path('unduhan/', views.unduhan, name='unduhan'),
    path('langganan/', views.langganan, name='langganan'),
]
