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

def beli_langganan(request):
    return None

def langganan(request):
    username = request.user.username
    nama_user = request.session.get('username')
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

    paket_aktif = []

    # fetch paket sekarang
    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            select username, nama_paket, metode_pembayaran,start_date_time,	end_date_time
            from (
                select username, nama_paket, metode_pembayaran, start_date_time,	end_date_time,
                    row_number() over (partition by username order by timestamp_pembayaran desc) as _rn
                from transaction 
                )
            where _rn = 1;
        """)
        rows = cursor.fetchall()
        paket_aktif = rows
    paket_user = []
    for i in paket_aktif:
        if nama_user == i[0]:
            paket_user.append(i[1]) #nama paket
            paket_user.append(i[2])  # metode bayar
            paket_user.append(i[3]) #start
            paket_user.append(i[4])  # end
            if i[1] == "Paket Premium":
                harga = 189000
                resolusi = "4K"
                dukungan_perangkat = "Android, iOS, Windows"
            elif i[1] == "Paket Lanjutan":
                harga = 139000
                resolusi = "1080p"
                dukungan_perangkat = "Android, iOS, Windows"
            else:
                harga = 99000
                resolusi = "720p"
                dukungan_perangkat = "Android, iOS"
            paket_user.append(harga)
            paket_user.append(resolusi)
            paket_user.append(dukungan_perangkat)
    if len(paket_user) == 0:
        for i in range (7):
            paket_user.append("-")

    paket_user_dict = {}
    paket_user_dict.update({"nama":paket_user[0],
                            "metode_bayar":paket_user[1],
                            "start_date":paket_user[2],
                            "end_date":paket_user[3],
                            "harga":paket_user[4],
                            "resolusi":paket_user[5],
                            "perangkat":paket_user[6]})

    # fetching history transactions
    history = []
    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            select * from transaction;
        """)
        rows = cursor.fetchall()
        history = rows
    history_user = []
    for i in history:
        if i[0] == nama_user:
            history_user.append(i)
    idskrg = 0
    history_dict = {}
    for i in history_user:
        history_start_date = []
        history_end_date = []
        history_nama_paket = []
        history_timestamp = []
        history_metode = []
        history_start_date.append(i[1])
        history_end_date.append(i[2])
        history_nama_paket.append(i[3])
        history_metode.append(i[4])
        history_timestamp.append(i[5])
        idskrg +=1
        if i[3] == "Paket Premium":
                harga = 189000
                resolusi = "4K"
                dukungan_perangkat = "Android, iOS, Windows"
        elif i[3] == "Paket Lanjutan":
            harga = 139000
            resolusi = "1080p"
            dukungan_perangkat = "Android, iOS, Windows"
        else:
            harga = 99000
            resolusi = "720p"
            dukungan_perangkat = "Android, iOS"
        history_dict_now = {"start":i[1], "end":i[2], "nama":i[3],
                    "metode":i[4], "waktu":i[5], "bayar":harga}
        history_dict[idskrg] = history_dict_now.copy()

    print(history_dict)
    context = {"Premium":premium,
               "Dasar":dasar,
               "Lanjutan":lanjutan,
               "nama_user":request.session.get('username'),
               "paket_sekarang":paket_user_dict,
               "history":history_dict}
    return render (request, 'langganan.html', context)

def logout(request):
    return render (request, 'daftar_tayang.html')