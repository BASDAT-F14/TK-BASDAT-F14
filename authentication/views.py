from django.shortcuts import render
from django.contrib.auth import authenticate, login as auth_login
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import logout as auth_logout
from .forms import CustomUserCreationForm

@csrf_exempt
def login(request):
    return render (request, 'login.html')
    
@csrf_exempt
def logout(request):
    return render (request, 'main.html')
    
@csrf_exempt
def register(request):
    return render (request, 'register.html')
