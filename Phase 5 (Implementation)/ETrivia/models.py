from django.db import models
from django.contrib.auth.models import AbstractUser
from django.utils import timezone

class User(AbstractUser):
    """
    Model koji predstavlja registrovanog korisnika
    """
    idqueue = models.IntegerField(default=0)
    is_banned = models.BooleanField(default=False)
class Game(models.Model):
    """
        Model koji predstavlja multiplayer partiju, sadrzi pitanja koja se dostavljaju obojici igraca, kao i informaciju
        o stanju igre (da li se ceka pocetak, da li je u toku, da li je zavrsena)
    """
    idgame = models.AutoField(db_column='IdGame', primary_key=True)  # Field name made lowercase.
    timestarted = models.DateTimeField(db_column='TimeStarted',null = True)  # Field name made lowercase.
    iduser1 = models.ForeignKey(User, models.DO_NOTHING, db_column='IdUser1')  # Field name made lowercase.
    iduser2 = models.ForeignKey(User, models.DO_NOTHING, db_column='IdUser2', related_name='game_iduser2_set')  # Field name made lowercase.
    idqow1 = models.ForeignKey('Questionsqow', models.SET_NULL, db_column='IdQOW1', blank=True, null=True)  # Field name made lowercase.
    idqow2 = models.ForeignKey('Questionsqow', models.SET_NULL, db_column='IdQOW2', related_name='game_idqow2_set', blank=True, null=True)  # Field name made lowercase.
    idqow3 = models.ForeignKey('Questionsqow', models.SET_NULL, db_column='IdQOW3', related_name='game_idqow3_set', blank=True, null=True)  # Field name made lowercase.
    idqow4 = models.ForeignKey('Questionsqow', models.SET_NULL, db_column='IdQOW4', related_name='game_idqow4_set', blank=True, null=True)  # Field name made lowercase.
    idqow5 = models.ForeignKey('Questionsqow', models.SET_NULL, db_column='IdQOW5', related_name='game_idqow5_set', blank=True, null=True)  # Field name made lowercase.
    idll = models.ForeignKey('Questionsll', models.DO_NOTHING, db_column='IdLL', blank=True, null=True)  # Field name made lowercase.
    idnh = models.ForeignKey("numberhunt",models.DO_NOTHING, db_column='IdHunt', blank=True, null=True)
    idss = models.ForeignKey("secretsequence", models.DO_NOTHING, db_column='IdSecret', blank=True, null=True)
    joined = models.IntegerField(db_column='joined',default = 0)
    finished = models.IntegerField(db_column='finished', default=0)
    class Meta:
        managed = True
        db_table = 'game'


class Llfield(models.Model):
    """
    Model koji predstavlja par spojnica za igru LogicLink
    """
    idllfield = models.AutoField(db_column='IdLLField', primary_key=True)  # Field name made lowercase.
    left = models.CharField(db_column='Left', max_length=150, default="default")  # Field name made lowercase.
    right = models.CharField(db_column='Right', max_length=150,default="default")  # Field name made lowercase.
    idll = models.ForeignKey('Questionsll', models.DO_NOTHING, db_column='IdLL')  # Field name made lowercase.

    class Meta:
        managed = True
        db_table = 'llfield'


class Multiplayerqueue(models.Model):
    """
        Model koji predstavlja red za cekanje na multiplayer partiju
        kada sistem napravi partiju, on izbacuje korisnike iz queue
    """
    idqueue = models.AutoField(db_column='IdQueue', primary_key=True)  # Field name made lowercase.
    username = models.CharField(db_column='Username', max_length=18, blank=True, null=True)  # Field name made lowercase.
    timejoined = models.DateTimeField(db_column='TimeJoined', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = True
        db_table = 'multiplayerqueue'


class Questionsll(models.Model):
    """
        Model koji predstavlja pitanja za partiju LogicLink, ova tabela sadrzi samo prompt
    """
    idll = models.AutoField(db_column='IdLL', primary_key=True)  # Field name made lowercase.
    prompt = models.CharField(db_column='Prompt', max_length=200, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = True
        db_table = 'questionsll'


class Questionsqow(models.Model):
    """
        Model koji predstavlja pitanja za igru question of wisdom
    """
    idqow = models.AutoField(db_column='IdQOW', primary_key=True)  # Field name made lowercase.
    question = models.CharField(db_column='Question', max_length=200)  # Field name made lowercase.
    correct = models.CharField(db_column='Correct', max_length=100)  # Field name made lowercase.
    incorrect1 = models.CharField(db_column='Incorrect1', max_length=100)  # Field name made lowercase.
    incorrect2 = models.CharField(db_column='Incorrect2', max_length=100)  # Field name made lowercase.
    incorrect3 = models.CharField(db_column='Incorrect3', max_length=100)  # Field name made lowercase.

    class Meta:
        managed = True
        db_table = 'questionsqow'


class Result(models.Model):
    """
        Model koji predstavlja rezultate multiplayer partije, koji se koriste za statistiku pojedinih korisnika,
        kao i za rang liste
    """
    idresult = models.AutoField(db_column='IdResult', primary_key=True)  # Field name made lowercase.
    points1 = models.IntegerField(db_column='Points1')  # Field name made lowercase.
    points2 = models.IntegerField(db_column='Points2')  # Field name made lowercase.
    points3 = models.IntegerField(db_column='Points3')  # Field name made lowercase.
    points4 = models.IntegerField(db_column='Points4')  # Field name made lowercase.
    won = models.TextField(db_column='Won')  # Field name made lowercase. This field type is a guess.
    idgame = models.ForeignKey(Game, models.DO_NOTHING, db_column='IdGame')  # Field name made lowercase.
    iduser = models.ForeignKey(User, models.DO_NOTHING, db_column='IdUser')  # Field name made lowercase.
    timestamp = models.DateTimeField(default=timezone.now)

    class Meta:
        managed = True
        db_table = 'result'

class SecretSequence(models.Model):
    """
        Model koji se koristi kako bismo mogli jednostavnije da dostavljamo iste kombinacije
        za igru secret sequence obojici igraca multiplayer partije
    """
    idsecret = models.AutoField(db_column='IdSecret', primary_key=True)
    symbol11 = models.IntegerField(db_column='Symbol11')
    symbol12 = models.IntegerField(db_column='Symbol12')
    symbol13 = models.IntegerField(db_column='Symbol13')
    symbol21 = models.IntegerField(db_column='Symbol21')
    symbol22 = models.IntegerField(db_column='Symbol22')
    symbol23 = models.IntegerField(db_column='Symbol23')
    symbol24 = models.IntegerField(db_column='Symbol24')
    symbol31 = models.IntegerField(db_column='Symbol31')
    symbol32 = models.IntegerField(db_column='Symbol32')
    symbol33 = models.IntegerField(db_column='Symbol33')
    symbol34 = models.IntegerField(db_column='Symbol34')
    symbol35 = models.IntegerField(db_column='Symbol35')

    class Meta:
        managed = True
        db_table = 'secretsequence'

class NumberHunt(models.Model):
    """
        Model koji postoji iz istog razloga kao i predhodni, ali za igru number hunt
    """
    idhunt = models.AutoField(db_column='IdHunt', primary_key=True)
    goal_number = models.IntegerField(db_column='GoalNumber')
    number1 = models.IntegerField(db_column='Number1')
    number2 = models.IntegerField(db_column='Number2')
    number3 = models.IntegerField(db_column='Number3')
    number4 = models.IntegerField(db_column='Number4')
    number5 = models.IntegerField(db_column='Number5')
    number6 = models.IntegerField(db_column='Number6')

    class Meta:
        managed = True
        db_table = 'numberhunt'