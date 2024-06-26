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
    path('langganan/pembelian_premium/', views.pembelian_premium, name='pembelian_premium'),
    path('langganan/pembelian_lanjutan/', views.pembelian_lanjutan, name='pembelian_lanjutan'),
    path('langganan/pembelian_dasar/', views.pembelian_dasar, name='pembelian_dasar'),
    path('langganan/beli_premium/', views.pembelian_paket_premium, name='pembelian_paket_premium'),
    path('langganan/beli_lanjutan/', views.pembelian_paket_lanjutan, name='pembelian_paket_lanjutan'),
    path('langganan/beli_dasar/', views.pembelian_paket_dasar, name='pembelian_paket_dasar'),
]
