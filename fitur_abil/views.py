import json
from django.shortcuts import render, redirect
from django.contrib import messages
from django.http import JsonResponse
from django.db import connection
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from datetime import datetime
from datetime import timedelta 

def guest(request):
    return render(request, 'guest.html')

def show_main(request):
    return render(request, 'main.html')

def pembelian_premium(request):
    return render(request, 'beli_langganan_premium.html')


def pembelian_lanjutan(request):
    return render(request, 'beli_langganan_lanjutan.html')
def pembelian_dasar(request):
    return render(request, 'beli_langganan_dasar.html')

@csrf_exempt
def pembelian_paket_premium(request):
    if request.method == "POST":
        nama_paket = "Paket Premium"
        nama_user = request.session.get('username')
        metode = request.POST["metodePembayaran"]

        skrg = datetime.now()
        date = str(skrg)[:10]
        jam = str(skrg)[11:19]
        ldr = 'transaction'
        timestamp = date+ " " + jam
        Begindate = datetime.strptime(date, "%Y-%m-%d")
        dateakhir = Begindate + timedelta(days=7)
        buatdisql = f"""
                INSERT 
                    INTO {ldr}
                VALUES 
                    ('{nama_user}', '{date}','{str(dateakhir)[0:-9]}', '{nama_paket}', '{metode}', '{timestamp}'); 
            """
        print(buatdisql)
        username = request.user.username
        nama_user = request.session.get('username')
        disql = f"""
                select username, nama_paket, metode_pembayaran,start_date_time,	end_date_time, timestamp_pembayaran
                from (
                    select username, nama_paket, metode_pembayaran, start_date_time,	end_date_time, timestamp_pembayaran,
                        row_number() over (partition by username order by timestamp_pembayaran desc) as _rn
                    from transaction 
                    )
                where _rn = 1 and username = '{nama_user}';
            """
        with connection.cursor() as cursor:
            cursor.execute("SET search_path TO PACILFLIX")
            cursor.execute(disql)
            rows = cursor.fetchall()
        # 2024-05-17 18:47:15
        timestamp = rows[0][5]
        waktudibeli = timestamp
        d1 = datetime.now()
        status_paket_sekarang_lebih_dari_1_hari = False
        if d1-waktudibeli>timedelta(1):
            try:
                with connection.cursor() as cursor:
                    cursor.execute("SET search_path TO PACILFLIX")
                    cursor.execute(buatdisql)
                    return render(request, 'success.html')
            except:
                return render(request, 'notsuccess.html')

    return render(request, 'notsuccess.html')

@csrf_exempt
def pembelian_paket_lanjutan(request):
    if request.method == "POST":
        nama_paket = "Paket Lanjutan"
        nama_user = request.session.get('username')
        metode = request.POST["metodePembayaran"]

        skrg = datetime.now()
        date = str(skrg)[:10]
        jam = str(skrg)[11:19]
        ldr = 'transaction'
        timestamp = date+ " " + jam
        Begindate = datetime.strptime(date, "%Y-%m-%d")
        dateakhir = Begindate + timedelta(days=7)
        buatdisql = f"""
                INSERT 
                    INTO {ldr}
                VALUES 
                    ('{nama_user}', '{date}','{str(dateakhir)[0:-9]}', '{nama_paket}', '{metode}', '{timestamp}'); 
            """
        print(buatdisql)
        username = request.user.username
        nama_user = request.session.get('username')
        disql = f"""
                select username, nama_paket, metode_pembayaran,start_date_time,	end_date_time, timestamp_pembayaran
                from (
                    select username, nama_paket, metode_pembayaran, start_date_time,	end_date_time, timestamp_pembayaran,
                        row_number() over (partition by username order by timestamp_pembayaran desc) as _rn
                    from transaction 
                    )
                where _rn = 1 and username = '{nama_user}';
            """
        with connection.cursor() as cursor:
            cursor.execute("SET search_path TO PACILFLIX")
            cursor.execute(disql)
            rows = cursor.fetchall()
        # 2024-05-17 18:47:15
        timestamp = rows[0][5]
        waktudibeli = timestamp
        d1 = datetime.now()
        status_paket_sekarang_lebih_dari_1_hari = False
        if d1-waktudibeli>timedelta(1):
            try:
                with connection.cursor() as cursor:
                    cursor.execute("SET search_path TO PACILFLIX")
                    cursor.execute(buatdisql)
                    return render(request, 'success.html')
            except:
                return render(request, 'notsuccess.html')

    return render(request, 'notsuccess.html')

@csrf_exempt
def pembelian_paket_dasar(request):
    if request.method == "POST":
        nama_paket = "Paket Dasar"
        nama_user = request.session.get('username')
        metode = request.POST["metodePembayaran"]

        skrg = datetime.now()
        date = str(skrg)[:10]
        jam = str(skrg)[11:19]
        ldr = 'transaction'
        timestamp = date+ " " + jam
        Begindate = datetime.strptime(date, "%Y-%m-%d")
        dateakhir = Begindate + timedelta(days=7)
        buatdisql = f"""
                INSERT 
                    INTO {ldr}
                VALUES 
                    ('{nama_user}', '{date}','{str(dateakhir)[0:-9]}', '{nama_paket}', '{metode}', '{timestamp}'); 
            """
        print(buatdisql)
        username = request.user.username
        nama_user = request.session.get('username')
        disql = f"""
                select username, nama_paket, metode_pembayaran,start_date_time,	end_date_time, timestamp_pembayaran
                from (
                    select username, nama_paket, metode_pembayaran, start_date_time,	end_date_time, timestamp_pembayaran,
                        row_number() over (partition by username order by timestamp_pembayaran desc) as _rn
                    from transaction 
                    )
                where _rn = 1 and username = '{nama_user}';
            """
        with connection.cursor() as cursor:
            cursor.execute("SET search_path TO PACILFLIX")
            cursor.execute(disql)
            rows = cursor.fetchall()
        # 2024-05-17 18:47:15
        timestamp = rows[0][5]
        waktudibeli = timestamp
        d1 = datetime.now()
        status_paket_sekarang_lebih_dari_1_hari = False
        if d1-waktudibeli>timedelta(1):
            try:
                with connection.cursor() as cursor:
                    cursor.execute("SET search_path TO PACILFLIX")
                    cursor.execute(buatdisql)
                    return render(request, 'success.html')
            except:
                return render(request, 'notsuccess.html')

    return render(request, 'notsuccess.html')

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
            select username, nama_paket, metode_pembayaran,start_date_time,	end_date_time, timestamp_pembayaran
            from (
                select username, nama_paket, metode_pembayaran, start_date_time,	end_date_time, timestamp_pembayaran,
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
            paket_user.append(i[5])
    if len(paket_user) == 0:
        for i in range (7):
            paket_user.append("-")

    waktuberakhir = paket_user[7]+timedelta(days=7)
    d1 = datetime.now()
    status_paket_sekarang_aktif = True
    if d1-waktuberakhir>timedelta(0):
        status_paket_sekarang_aktif = False
    print(status_paket_sekarang_aktif)
    paket_user_dict = {}
    print(paket_user)
    if status_paket_sekarang_aktif==False or len(paket_user) == 0:
        for i in range (7):
            paket_user.append("-")
    else:
        print("keupdate")
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
        delta = i[2]-i[1]
        history_dict_now = {"start":i[1], "end":i[2], "nama":i[3],
                    "metode":i[4], "waktu":i[5], "bayar":harga*delta.days}
        print(history_dict_now)
        history_dict[idskrg] = history_dict_now.copy()
    context = {"Premium":premium,
               "Dasar":dasar,
               "Lanjutan":lanjutan,
               "nama_user":request.session.get('username'),
               "paket_sekarang":paket_user_dict,
               "history":history_dict}
    return render (request, 'langganan.html', context)

def logout(request):
    return render (request, 'daftar_tayang.html')

def trailer(request):
    # Pastikan pengguna sudah login
    if request.user.is_authenticated:
        return redirect('tayangan')
    
    trailer_list = []
    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            SELECT judul, sinopsis, url_video_trailer, release_date_trailer, COUNT(username) AS view
            FROM riwayat_nonton
            JOIN tayangan ON tayangan.id = riwayat_nonton.id_tayangan
            WHERE riwayat_nonton.start_date_time >= NOW() - INTERVAL '7 days'
            GROUP BY riwayat_nonton.id_tayangan, judul, sinopsis, url_video_trailer, release_date_trailer
            ORDER BY view DESC
            LIMIT 10;
        """)
        rows = cursor.fetchall()
        for row in rows:
            trailer_list.append({
                'judul': row[0],
                'sinopsis': row[1],
                'url_video_trailer': row[2],
                'release_date_trailer': row[3],
                'view' : row[4]
            })

        cursor.execute("""
            SELECT judul, sinopsis, url_video_trailer, release_date_trailer, COUNT(username) AS view
            FROM riwayat_nonton
            JOIN tayangan ON tayangan.id = riwayat_nonton.id_tayangan
            RIGHT JOIN film ON film.id_tayangan = tayangan.id
            GROUP BY riwayat_nonton.id_tayangan, judul, sinopsis, url_video_trailer, release_date_trailer
            ORDER BY view DESC
            LIMIT 10;
        """)
        rows = cursor.fetchall()
        film = []
        for row in rows:
            film.append({
                'judul': row[0],
                'sinopsis': row[1],
                'url_video_trailer': row[2],
                'release_date_trailer': row[3],
                'view' : row[4]
            })

        cursor.execute("""
            SELECT judul, sinopsis, url_video_trailer, release_date_trailer, COUNT(username) AS view
            FROM riwayat_nonton
            JOIN tayangan ON tayangan.id = riwayat_nonton.id_tayangan
            RIGHT JOIN series ON series.id_tayangan = tayangan.id
            GROUP BY riwayat_nonton.id_tayangan, judul, sinopsis, url_video_trailer, release_date_trailer
            ORDER BY view DESC
            LIMIT 10;
        """)
        rows = cursor.fetchall()
        series = []
        for row in rows:
            series.append({
                'judul': row[0],
                'sinopsis': row[1],
                'url_video_trailer': row[2],
                'release_date_trailer': row[3],
                'view' : row[4]
            })

        context = {
            'trailers' : trailer_list,
            'films' : film,
            'series' : series
        }
    return render(request, 'trailer.html', context)

def get_url(id_tayangan):
    with connection.cursor() as cursor:
        cursor.execute("""
            SELECT COUNT(*)
            FROM film
            WHERE id_tayangan = %s
        """, [id_tayangan])
        result = cursor.fetchone()
        if result[0] > 0:
            return f"/film/{id_tayangan}"
        
    return f"/series/{id_tayangan}"

def tayangan(request):
    # Pastikan pengguna sudah login
    # username = request.user.username
    username = request.session.get('username')

    trailer_list = []
    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            SELECT judul, sinopsis, url_video_trailer, release_date_trailer, COUNT(username) AS view, id
            FROM riwayat_nonton
            JOIN tayangan ON tayangan.id = riwayat_nonton.id_tayangan
            WHERE riwayat_nonton.start_date_time >= NOW() - INTERVAL '7 days'
            GROUP BY riwayat_nonton.id_tayangan, judul, sinopsis, url_video_trailer, release_date_trailer, id
            ORDER BY view DESC
            LIMIT 10;
        """)
        rows = cursor.fetchall()
        for row in rows:
            trailer_list.append({
                'judul': row[0],
                'sinopsis': row[1],
                'url_video_trailer': row[2],
                'release_date_trailer': row[3],
                'view' : row[4],
                'id' : row[5],
                'url': get_url(row[5])
            })

        cursor.execute("""
            SELECT judul, sinopsis, url_video_trailer, release_date_trailer, COUNT(username) AS view, id
            FROM riwayat_nonton
            JOIN tayangan ON tayangan.id = riwayat_nonton.id_tayangan
            RIGHT JOIN film ON film.id_tayangan = tayangan.id
            GROUP BY riwayat_nonton.id_tayangan, judul, sinopsis, url_video_trailer, release_date_trailer, id
            ORDER BY view DESC
            LIMIT 10;
        """)
        rows = cursor.fetchall()
        film = []
        for row in rows:
            film.append({
                'judul': row[0],
                'sinopsis': row[1],
                'url_video_trailer': row[2],
                'release_date_trailer': row[3],
                'view' : row[4],
                'id' : row[5],
                'url': get_url(row[5])
            })

        cursor.execute("""
            SELECT judul, sinopsis, url_video_trailer, release_date_trailer, COUNT(username) AS view, id
            FROM riwayat_nonton
            JOIN tayangan ON tayangan.id = riwayat_nonton.id_tayangan
            RIGHT JOIN series ON series.id_tayangan = tayangan.id
            GROUP BY riwayat_nonton.id_tayangan, judul, sinopsis, url_video_trailer, release_date_trailer, id
            ORDER BY view DESC
            LIMIT 10;
        """)
        rows = cursor.fetchall()
        series = []
        for row in rows:
            series.append({
                'judul': row[0],
                'sinopsis': row[1],
                'url_video_trailer': row[2],
                'release_date_trailer': row[3],
                'view' : row[4],
                'id' : row[5],
                'url': get_url(row[5])
            })

        context = {
            'trailers' : trailer_list,
            'films' : film,
            'series' : series
        }
    return render (request, 'daftar_tayangan.html', context)

def search_guest(request):
    trailer_list = []
    with connection.cursor() as cursor:
        search = request.POST.get('query', '')
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            SELECT
                judul,
                sinopsis_trailer,
                url_video_trailer,
                release_date_trailer
            FROM
                TAYANGAN t
            WHERE
                judul ILIKE %s
            """, [f"%{search}%"])
        rows = cursor.fetchall()
        for row in rows:
            trailer_list.append({
            'judul': row[0],
            'sinopsis': row[1],
            'url_video_trailer': row[2],
            'release_date_trailer': row[3],
            })
        context = {
            'films' : trailer_list,
        }
    return render (request, 'search_guest.html', context)

def search_user(request):
    trailer_list = []
    with connection.cursor() as cursor:
        search = request.POST.get('query', '')
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            SELECT
                judul,
                sinopsis_trailer,
                url_video_trailer,
                release_date_trailer,
                id
            FROM
                TAYANGAN t
            WHERE
                judul ILIKE %s
            """, [f"%{search}%"])
        rows = cursor.fetchall()
        for row in rows:
            trailer_list.append({
            'judul': row[0],
            'sinopsis': row[1],
            'url_video_trailer': row[2],
            'release_date_trailer': row[3],
            'url': get_url(row[4])
            })
        context = {
            'films' : trailer_list,
        }
    return render (request, 'search_user.html', context)

def film(request, id):
    username = request.session.get('username')

    list_genre = []
    list_pemain = []
    list_penulis = []
    list_ulasan = []
    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            SELECT t.judul, t.sinopsis_trailer, f.durasi_film, t.release_date_trailer, t.url_video_trailer, t.asal_negara, c.nama
            FROM film f
            JOIN tayangan t ON f.id_tayangan = t.id
            LEFT JOIN ulasan u ON f.id_tayangan = u.id_tayangan
            JOIN sutradara s ON t.id_sutradara = s.id
            JOIN contributors c ON s.id = c.id
            WHERE f.id_tayangan = %s
            GROUP BY t.judul, t.sinopsis_trailer, f.durasi_film, t.release_date_trailer, t.url_video_trailer, t.asal_negara, c.nama
        """, [id])
        result = cursor.fetchone()
        judul = result[0]
        sinopsis = result[1]
        durasi = result[2]
        release_date = result[3]
        url = result[4]
        asal_negara = result[5]
        sutradara = result[6]

        cursor.execute("""
            SELECT COUNT(username)
            FROM riwayat_nonton
            WHERE id_tayangan = %s
        """, [id])
        result = cursor.fetchone()
        total_view = result[0]

        cursor.execute("""
            SELECT AVG(rating)
            FROM ulasan
            WHERE id_tayangan = %s
        """, [id])
        result = cursor.fetchone()
        avg_rating = result[0]

        cursor.execute("""
            SELECT genre
            FROM genre_tayangan
            WHERE id_tayangan = %s
        """, [id])
        result = cursor.fetchall()
        for row in result:
            list_genre.append(row[0])

        cursor.execute("""
            SELECT c.nama
            FROM memainkan_tayangan m
            JOIN contributors c ON m.id_pemain = c.id
            WHERE m.id_tayangan = %s
        """, [id])
        result = cursor.fetchall()
        for row in result:
            list_pemain.append(row[0])

        cursor.execute("""
            SELECT c.nama
            FROM menulis_skenario_tayangan m
            JOIN contributors c ON m.id_penulis_skenario = c.id
            WHERE m.id_tayangan = %s
        """, [id])
        result = cursor.fetchall()
        for row in result:
            list_penulis.append(row[0])

        cursor.execute("""
            SELECT username, rating, deskripsi, timestamp
            FROM ulasan
            WHERE id_tayangan = %s
            ORDER BY timestamp DESC
        """, [id])
        result = cursor.fetchall()
        for row in result:
            list_ulasan.append({
                'username': row[0],
                'rating': row[1],
                'deskripsi': row[2],
                'timestamp': row[3],
            })

    if avg_rating:
        avg_rating = round(avg_rating, 1)
    else:
        avg_rating = 0

    context = {
        'id': id,
        'judul': judul,
        'view': total_view,
        'rating': avg_rating,
        'sinopsis': sinopsis,
        'durasi': durasi,
        'release_date': release_date,
        'url': url,
        'list_genre': list_genre,
        'asal_negara': asal_negara,
        'list_pemain': list_pemain,
        'list_penulis_skenario': list_penulis,
        'sutradara': sutradara,
        'list_ulasan': list_ulasan
    }

    return render (request, 'halaman_film.html', context)

def series(request, id):
    episodes = []
    list_genre = []
    pemains = []
    penulis_skenarios = []
    list_ulasan = []

    username = request.session.get('username')

    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            SELECT t.judul, t.sinopsis_trailer, t.asal_negara, c.nama
            FROM series s
            JOIN tayangan t ON s.id_tayangan = t.id
            LEFT JOIN ulasan u ON s.id_tayangan = u.id_tayangan
            JOIN sutradara sdr ON t.id_sutradara = sdr.id
            JOIN contributors c ON sdr.id = c.id
            WHERE s.id_tayangan = %s
            GROUP BY t.judul, t.sinopsis_trailer, t.asal_negara, c.nama
        """, [id])
        result = cursor.fetchone()
        judul_series = result[0]
        sinopsis = result[1]
        asal_negara = result[2]
        sutradara = result[3]

        cursor.execute("""
            SELECT COUNT(*)
            FROM riwayat_nonton
            WHERE id_tayangan = %s
        """, [id])
        result = cursor.fetchone()
        total_view = result[0]

        cursor.execute("""
            SELECT AVG(rating)
            FROM ulasan
            WHERE id_tayangan = %s
        """, [id])
        result = cursor.fetchone()
        avg_rating = "%.1f" % result[0]

        cursor.execute("""
            SELECT genre
            FROM genre_tayangan
            WHERE id_tayangan = %s
        """, [id])
        result = cursor.fetchall()
        for row in result:
            list_genre.append(row[0])

        cursor.execute("""
            SELECT c.nama
            FROM memainkan_tayangan m
            JOIN contributors c ON m.id_pemain = c.id
            WHERE m.id_tayangan = %s
        """, [id])
        result = cursor.fetchall()
        for row in result:
            pemains.append(row[0])

        cursor.execute("""
            SELECT c.nama
            FROM menulis_skenario_tayangan m
            JOIN contributors c ON m.id_penulis_skenario = c.id
            WHERE m.id_tayangan = %s
        """, [id])
        result = cursor.fetchall()
        for row in result:
            penulis_skenarios.append(row[0])

        cursor.execute("""
            SELECT sub_judul, sinopsis, durasi, url_video, release_date
            FROM episode
            WHERE id_series = %s
        """, [id])
        result = cursor.fetchall()
        for row in result:
            episodes.append({
                'id': f"{row[0]}---{id}",
                'sub_judul': row[0],
            })

        cursor.execute("""
            SELECT username, rating, deskripsi, timestamp
            FROM ulasan
            WHERE id_tayangan = %s
            ORDER BY timestamp DESC
        """, [id])
        result = cursor.fetchall()
        for row in result:
            list_ulasan.append({
                'username': row[0],
                'rating': row[1],
                'deskripsi': row[2],
                'timestamp': row[3],
            })

    context = {
        'id': id,
        'judul': judul_series,
        'view': total_view,
        'list_episode': episodes,
        'rating': avg_rating,
        'sinopsis': sinopsis,
        'list_genre': list_genre,
        'asal_negara': asal_negara,
        'list_pemain': pemains,
        'list_penulis_skenario': penulis_skenarios,
        'sutradara': sutradara,
        'list_ulasan': list_ulasan
    }

    return render (request, 'halaman_series.html', context)

def episode(request, judul, id):
    username = request.session.get('username')

    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            SELECT sub_judul, e.sinopsis, durasi, url_video, release_date, judul, id_series
            FROM episode e
            JOIN tayangan t ON id = id_series
            WHERE sub_judul ILIKE %s AND id_series = %s;
        """, [judul, id])
        rows = cursor.fetchall()
        episode_list = []
        for row in rows:
            episode_list.append({
                'sub_judul': row[0],
                'sinopsis': row[1],
                'durasi': row[2],
                'url': row[3],
                'release_date' : row[4],
                'judul' : row[5],
                'id' : row[6]
            })
    
        cursor.execute("""
            SELECT sub_judul
            FROM episode e
            JOIN tayangan t ON id = id_series
            WHERE id_series = %s;
        """, [id])
        rows = cursor.fetchall()
        episode_lain = []
        episode_lainnya = []
        for row in rows:
            episode_lain.append({
                'sub_judul': row[0],
            })
        for episode in episode_lain:
            if episode['sub_judul'] != judul:
                episode_lainnya.append(episode)

    context = {
            'list_episode' : episode_list,
            'episode_lainnya' : episode_lainnya,
            'id' : id
        }
    return render (request, 'halaman_episode.html', context)

def tonton(request, id):
    username = request.session.get('username')

    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            INSERT INTO RIWAYAT_NONTON (id_tayangan, username, start_date_time, end_date_time)
            VALUES (%s, %s, NOW(), NOW())
        """, [id, username])
    return JsonResponse({'status': 'success'})

def ulasan(request, id):
        username = request.session.get('username')
        data = json.loads(request.body)
        deskripsi = data.get('deskripsi')
        rating = data.get('rating')
        
        with connection.cursor() as cursor:
            cursor.execute("SET search_path TO PACILFLIX")
            cursor.execute("""
                INSERT INTO ULASAN (id_tayangan, username, timestamp, rating, deskripsi)
                VALUES (%s, %s, NOW(), %s, %s)
            """, [id, username, rating, deskripsi])
            
        return JsonResponse({'status': 'success'})