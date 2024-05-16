from django.shortcuts import render
from django.http import HttpResponse
from django.db import connection
from django.contrib.auth.decorators import login_required

def show_main(request):
    context = {'judul':'tutor pbp','requestan':'dong kak','id': 1012}
    
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

def guest(request):
    context = {'judul':'tutor pbp','requestan':'dong kak','id': 1012}
    
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
        'kontributor_penulis_skenario': kontributor_penulis_skenario
    }

    return render(request, 'kontributor.html', context)

def favorit(request):
    return render (request, 'favorit.html')

def unduhan(request):
    return render (request, 'unduhan.html')

def langganan(request):
    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            SELECT 
                paket.nama AS nama_paket,
                paket.harga as harga_paket,
                paket.resolusi_layar as resolusi_layar_paket
            FROM 
                paket
        """)
        rows = cursor.fetchall()
    premium = {"harga": 0, "resolusi":"-"}
    lanjutan ={"harga": 0, "resolusi":"-"}
    dasar = {"harga": 0, "resolusi":"-"}

    for i in rows:
        if i[0] == 'Paket Dasar':
            dasar['harga'] = (i[1])
            dasar['resolusi']=(i[2])
        elif i[0] == 'Paket Lanjutan':
            lanjutan['harga'] = (i[1])
            lanjutan['resolusi']=(i[2])
        else:
            premium['harga'] = (i[1])
            premium['resolusi']=(i[2])

    listperangkat = {}
    
    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            SELECT 
                dukungan_perangkat
            FROM 
                dukungan_perangkat
            where
                nama_paket = 'Paket Dasar'
        """)
        rows = cursor.fetchall()
        listperangkat.update({"Paket Dasar":rows})

    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            SELECT 
                dukungan_perangkat
            FROM 
                dukungan_perangkat
            where
                nama_paket = 'Paket Lanjutan'
        """)
        rows = cursor.fetchall()
        listperangkat.update({"Paket Lanjutan":rows})

    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            SELECT 
                dukungan_perangkat
            FROM 
                dukungan_perangkat
            where
                nama_paket = 'Paket Premium'
        """)
        rows = cursor.fetchall()
        listperangkat.update({"Paket Premium":rows})
    result = []

    for i in listperangkat:
        stringawal = ""
        for j in listperangkat[f"{i}"]:
            stringawal+=str(j)[2:-3]
            stringawal+= ", "
        stringawal = stringawal[:-2]
        if i == "Paket Dasar":
            dasar["perangkat"] = stringawal
        elif i == "Paket Lanjutan":
            lanjutan["perangkat"] = stringawal
        else:
            premium["perangkat"] = stringawal

    context = {"Premium":premium,
               "Dasar":dasar,
               "Lanjutan":lanjutan}
    return render (request, 'langganan.html', context)

def logout(request):
    return render (request, 'daftar_tayang.html')