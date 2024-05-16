def add_username(request):
    return {
        'username': request.session.get('username', 'Guest')
    }