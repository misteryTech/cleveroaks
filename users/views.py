from django.shortcuts import render
from django.contrib.auth.models import User

def register(request):
    return render(request, 'registration.html')
# Create your views here.

def login_user(request):
    return render(request, 'login.html')
