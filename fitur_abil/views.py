from django.shortcuts import render
from django.http import HttpResponse


def show_main(request):
    context = {'judul':'tutor pbp','requestan':'dong kak','id': 1012}
    return render(request, 'search_user.html', context)

def daftar_kontributor(request):
    return render (request, 'kontributor.html')

def favorit(request):
    return render (request, 'favorit.html')

def unduhan(request):
    return render (request, 'unduhan.html')

def langganan(request):
    return render (request, 'langganan.html')

def logout(request):
    return render (request, 'daftar_tayang.html')