from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import logout as auth_logout
from .forms import CustomUserCreationForm
from django.shortcuts import render, redirect
from django.contrib import messages
from django.db import connection
from django.contrib.sessions.models import Session

@csrf_exempt
def login(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']

        # Retrieve user from the database
        with connection.cursor() as cursor:
            cursor.execute('SET search_path TO PACILFLIX')
            cursor.execute("SELECT username, password FROM pengguna WHERE username = %s", [username])
            row = cursor.fetchone()

        # Check if user exists and password matches
        if row is not None and row[1] == password:
            # Reset search path to default for session management
            with connection.cursor() as cursor:
                cursor.execute('SET search_path TO DEFAULT')

            # Set session
            request.session['username'] = username
            # Redirect to main page
            return redirect('fitur_abil:main')
        else:
            # Authentication failed, show error message
            messages.error(request, "Invalid username or password.")

    return render(request, 'login.html')


    
@csrf_exempt
def logout(request):
    return redirect('fitur_abil:guest')  # Redirect to main page after logout
    
@csrf_exempt
def register(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        confirm_password = request.POST['confirm_password']
        negara_asal = request.POST['negara_asal']

        # Check if username already exists
        with connection.cursor() as cursor:
            cursor.execute('SET search_path TO PACILFLIX')
            cursor.execute("SELECT username FROM pengguna WHERE username = %s", [username])
            existing_user = cursor.fetchone()

        if existing_user:
            messages.error(request, "Username already exists. Please choose a different username.")
        elif password != confirm_password:
            messages.error(request, "Password and confirm password do not match.")
        else:
            # Insert new user into the database
            with connection.cursor() as cursor:
                cursor.execute("""
                    INSERT INTO pengguna (username, password, negara_asal)
                    VALUES (%s, %s, %s)
                """, [username, password, negara_asal])
                messages.success(request, "Registration successful.")
            return redirect('login')

    return render(request, 'register.html')
