from django.shortcuts import render
from django.http import HttpResponse


def show_main(request):
    context = {'judul':'tutor pbp','requestan':'dong kak','id': 1012}
    return render(request, 'beli_langganan.html', context)