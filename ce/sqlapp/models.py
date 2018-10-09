from django.db import models

# Create your models here.
class ce(models.Model):
     username=models.CharField(primary_key=True, max_length=15)
     password=models.CharField(max_length=15)
class stumanage(models.Manager):
    def number(self):
        numbers = []
        for num in self.all():
            numbers.append(num.stunumber)
        return numbers
class stu(models.Model):
        manage=stumanage()
        objects=models.Manager()
        stuname = models.CharField(primary_key=True,max_length=15)
        stuage = models.IntegerField()
        stusex = models.CharField(max_length=3)
        stuhome = models.CharField(max_length=30)
        stuschool = models.CharField(max_length=30)
        stunumber =models.CharField(max_length=12)
        stuyz = models.IntegerField()
        stuaddress = models.CharField(max_length=30)
        stugrjs = models.CharField(max_length=500)
        bnum=models.CharField(max_length=300)
class bossmanage(models.Manager):
    def numbera(self):
        numbers = []
        for num in self.all():
            numbers.append(num.number)
        return numbers
class Message(models.Model):
    manage = bossmanage()
    objects = models.Manager()
    title=models.CharField(max_length=20)
    salarytreatment = models.IntegerField()
    demand = models.CharField(max_length=300)
    conpanyname=models.CharField(max_length=30)
    number = models.CharField(primary_key=True,max_length=12)
    snum=models.CharField(max_length=300)