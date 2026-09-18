from django.shortcuts import render
from django.contrib.auth.models import User

def register(request):
    return render(request, 'index.html')
# Create your views here.
