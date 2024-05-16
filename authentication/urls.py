from authentication.views import *
from django.urls import path
from . import views
from fitur_abil.views import *
from django.contrib.auth.views import LogoutView


urlpatterns = [
    path('register/', views.register, name='register'), 
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
]
