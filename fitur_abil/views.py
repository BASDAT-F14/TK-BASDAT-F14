import json
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
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
    return render (request, 'langganan.html')

def logout(request):
    return render (request, 'daftar_tayang.html')

def trailer(request):
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
    return render (request, 'trailer.html', context)

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
    with connection.cursor() as cursor:
        cursor.execute("SET search_path TO PACILFLIX")
        cursor.execute("""
            INSERT INTO RIWAYAT_NONTON (id_tayangan, username, start_date_time, end_date_time)
            VALUES (%s, %s, NOW(), NOW())
        """, [id, 'user1'])
    return JsonResponse({'status': 'success'})

def ulasan(request, id):
        # username = request.user.username
        username = 'user1'
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


#                           Table "pacilflix.ulasan"
#    Column    |            Type             | Collation | Nullable | Default
# -------------+-----------------------------+-----------+----------+---------
#  id_tayangan | uuid                        |           |          |
#  username    | character varying(50)       |           | not null |
#  timestamp   | timestamp without time zone |           | not null |
#  rating      | integer                     |           | not null | 0
#  deskripsi   | character varying(255)      |           |          |
# Indexes:
#     "ulasan_pkey" PRIMARY KEY, btree (username, "timestamp")
# Foreign-key constraints:
#     "ulasan_id_tayangan_fkey" FOREIGN KEY (id_tayangan) REFERENCES tayangan(id)
#     "ulasan_username_fkey" FOREIGN KEY (username) REFERENCES pengguna(username)
# Triggers:
#     before_ulasan_insert BEFORE INSERT ON ulasan FOR EACH ROW EXECUTE FUNCTION check_ulasan_exists()

#                                 Table "pacilflix.pengguna"
#    Column    |         Type          | Collation | Nullable |           Default
# -------------+-----------------------+-----------+----------+------------------------------
#  username    | character varying(50) |           | not null |
#  password    | character varying(50) |           | not null |
#  negara_asal | character varying(50) |           | not null | 'Unknown'::character varying
# Indexes:
#     "pengguna_pkey" PRIMARY KEY, btree (username)
# Referenced by:
#     TABLE "daftar_favorit" CONSTRAINT "daftar_favorit_username_fkey" FOREIGN KEY (username) REFERENCES pengguna(username)
#     TABLE "riwayat_nonton" CONSTRAINT "riwayat_nonton_username_fkey" FOREIGN KEY (username) REFERENCES pengguna(username)
#     TABLE "tayangan_terunduh" CONSTRAINT "tayangan_terunduh_username_fkey" FOREIGN KEY (username) REFERENCES pengguna(username)
#     TABLE "transaction" CONSTRAINT "transaction_username_fkey" FOREIGN KEY (username) REFERENCES pengguna(username)
#     TABLE "ulasan" CONSTRAINT "ulasan_username_fkey" FOREIGN KEY (username) REFERENCES pengguna(username)
# Triggers:
#     before_insert_pengguna_trigger BEFORE INSERT ON pengguna FOR EACH ROW EXECUTE FUNCTION check_existing_username()