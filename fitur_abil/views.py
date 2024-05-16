from django.shortcuts import render, redirect
from django.contrib import messages
from django.db import connection
from django.contrib.auth.decorators import login_required

def guest(request):
    return render(request, 'guest.html')


def show_main(request):
    return render(request, 'main.html')


def daftar_tayang(request):
    # Pastikan pengguna sudah login
    username = request.user.username
    username = request.session.get('username')


    context = {'judul': 'tutor pbp', 'requestan': 'dong kak', 'id': 1012, 'username': username}
    
    # Retrieve film data from the database
    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("SELECT * FROM FILM ")
        rows = cursor.fetchall()
        
    film_list = []
    for row in rows:
        film_dict = {
            'uuid': row[0],
            'url': row[1],
            'release_date': row[2],
            'duration': row[3]
        }
        film_list.append(film_dict)
    
    # Add the film list to the context
    context['films'] = film_list

    return render(request, 'search_user.html', context)

def daftar_tayang_guest(request):
    

    # Pastikan pengguna sudah login
    if request.user.is_authenticated:
        return redirect('daftar_tayang')

    context = {'judul': 'tutor pbp', 'requestan': 'dong kak', 'id': 1012}

    # Retrieve film data from the database
    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("SELECT * FROM FILM ")
        rows = cursor.fetchall()
        
    film_list = []
    for row in rows:
        film_dict = {
            'uuid': row[0],
            'url': row[1],
            'release_date': row[2],
            'duration': row[3]
        }
        film_list.append(film_dict)
    
    # Add the film list to the context
    context['films'] = film_list
    
    return render(request,'search_guest.html', context)


def daftar_kontributor(request):
    # Pastikan pengguna sudah login
    username = request.user.username
    username = request.session.get('username')
    

    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            SELECT 
                contributors.nama AS nama,
                CASE
                    WHEN sutradara.id IS NOT NULL THEN 'Sutradara'
                    WHEN pemain.id IS NOT NULL THEN 'Pemain'
                    WHEN penulis_skenario.id IS NOT NULL THEN 'Penulis Skenario'
                END AS tipe,
                contributors.jenis_kelamin AS jenis_kelamin,
                contributors.kewarganegaraan AS kewarganegaraan
            FROM 
                contributors
            LEFT JOIN
                sutradara ON contributors.id = sutradara.id
            LEFT JOIN
                pemain ON contributors.id = pemain.id
            LEFT JOIN
                penulis_skenario ON contributors.id = penulis_skenario.id
        """)
        rows = cursor.fetchall()

    kontributor_sutradara = []
    kontributor_pemain = []
    kontributor_penulis_skenario = []
    for row in rows:
        kontributor_dict = {
            'nama': row[0],
            'tipe': row[1],
            'jenis_kelamin': row[2],
            'kewarganegaraan': row[3]
        }
        if row[1] == 'Sutradara':
            kontributor_sutradara.append(kontributor_dict)
        elif row[1] == 'Pemain':
            kontributor_pemain.append(kontributor_dict)
        elif row[1] == 'Penulis Skenario':
            kontributor_penulis_skenario.append(kontributor_dict)
    context = {
        'kontributor_sutradara': kontributor_sutradara,
        'kontributor_pemain': kontributor_pemain,
        'kontributor_penulis_skenario': kontributor_penulis_skenario,
        'username': username  # Sertakan username dalam konteks
    }

    return render(request, 'kontributor.html', context)
    
 
def favorit(request):
    return render(request, 'favorit.html')


def unduhan(request):
    return render(request, 'unduhan.html')


def langganan(request):
    return render(request, 'langganan.html')