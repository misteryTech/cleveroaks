from django.conf import settings
from django.db import models


class Profile(models.Model):
    user = models.OneToOneField(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='profile'
    )
    contact_number = models.CharField(max_length=20)
    school = models.CharField(max_length=150)

    def __str__(self):
        return f'{self.user.get_username()} profile'
