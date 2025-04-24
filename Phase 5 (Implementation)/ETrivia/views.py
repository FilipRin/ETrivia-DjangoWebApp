
from datetime import datetime

from django.contrib.auth import authenticate, login, logout
from django.db.models.signals import post_save
from django.http import HttpResponse, HttpRequest, JsonResponse
from django.shortcuts import render, redirect
from django.contrib.auth.forms import AuthenticationForm,forms
from django.contrib import messages
from django.dispatch import receiver
from Etrivia.models import Questionsqow, Multiplayerqueue, User, Questionsll, NumberHunt, SecretSequence
from django.contrib.auth.decorators import login_required
from .forms import *

# Create your views here.
def index(request):
    # glavna stranica kad se ucita sajt, na svim ovim metodama se prvo poziva leave_game kako bi
    # sistem znao da je neki korisnik napustio partiju
    leave_game(request)

    return render(request,"home.html",{})


import random

def login_request(request: HttpRequest):
    # Autor : Filip Rinkovec 0463/2019;
    #metoda za login
    form = AuthenticationForm(request=request, data=request.POST or None)
    if form.is_valid():
        username = form.cleaned_data['username']
        password = form.cleaned_data['password']
        user = authenticate(request, username=username, password=password)
        if user:
            if user.is_banned:  # Assuming 'is_banned' is a field in your User model
                form.add_error(None, 'User is banned')
            else:
                login(request, user)
                messages.info(request, 'Successful login')
                if user.is_superuser:
                    return redirect('/admin/')
                else:
                    return redirect('/etrivia/')
    context = {
        'form': form
    }
    return render(request, "login.html", context)

def logout_request(request:HttpRequest):
    # Autor : Filip Rinkovec 0463/2019
    logout(request)
    return redirect('login')

def signin_request(request):
    # Autor : Filip Rinkovec 0463/2019
    if request.method == 'POST':
        form = SignupForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('login')
    else:
        form = SignupForm()
    return render(request, 'signin.html', {'form': form})

from django.utils.timezone import now
from datetime import timedelta


def training(request):
    leave_game(request)
    #ova metoda se u prinicpu nece ni menjati, treba napraviti metode koje generisu igre kad se klikne na igru u treningu
    print("training")
    return render(request,"training.html",{})

# Autor: Mihajlo Rajić 2021/0331 & Filip Rinkovec 2019/0463
@login_required(login_url='login')
def profile(request):
    leave_game(request)
    user_statistics = get_user_statistics(request.user.id)

    print("profile")
    return render(request, 'profile.html', {'user_statistics': user_statistics})

from django.db.models import Avg


def user_in_game(username):
    #provera da li je korisnik u partiji
    user = User.objects.all().filter(username=username)[0]
    if Game.objects.all().filter(iduser1 = user,timestarted=None).count() == 0 and Game.objects.all().filter(iduser2 = user,timestarted=None).count() == 0:
        return False
    return True
import random


def logiclink_page(request):
    return render(request,"logiclink_tr.html",{})

def get_game(request):
    # Autor: Filip Rinkovec 2019/0463 & Djordje Jovanovic 0293/2021 
    #metoda koja dohvata pitanja za multiplayer game nasim igracima
    username = getattr(request, "user")
    print(username)
    user = User.objects.filter(username=username)[0]
    opponent = "greska :("
    print(str(username) + " trazi gejm")
    if Game.objects.all().filter(iduser1=user,timestarted=None).count() == 1 or Game.objects.all().filter(iduser2=user,timestarted=None).count() == 1:
        #Izvlacimo iz game
        if Game.objects.all().filter(iduser1=user,timestarted=None).count() == 1:
            game = Game.objects.all().filter(iduser1=user,timestarted=None)[0]
            opponent = game.iduser2.username
            print("GAME JOINED" +str(game.joined))
            if game.joined == 0:
                game.joined = 1
                game.save()
            else:
                game.joined = 2
                game.timestarted = datetime.now()
                game.save()

        elif Game.objects.all().filter(iduser2=user,timestarted=None).count() == 1:
            game = Game.objects.all().filter(iduser2=user,timestarted=None)[0]
            print(game.timestarted)
            opponent = game.iduser1.username
            if game.joined == 0:
                game.joined = 1
                game.save()
            else:
                game.joined = 2
                game.timestarted = datetime.now()
                game.save()

        numberhunt_numbers = get_numberhunt_mm(game.idnh)
        secret_sequence_values = get_secretsequence_mm(game.idss)
        links, prompt = get_qll_mm(game.idll)
        #ovoj za QoW mora game da se prosledi jer game sadrzi
        # vise od jednog qow
        qow_questions = get_qow_mm(game)


        response_data = {
            "status":"success",
            "message":"Hello from server!",
            "idgame":game.idgame,
            "numberhunt":numberhunt_numbers,
            "secretsequence":secret_sequence_values,
            "promptll":prompt,
            "logiclink":links,
            "qow":qow_questions,
            "opponent":opponent
        }
        return JsonResponse(response_data)
    response_data = {
        "status": "success",
        "message": "Hello from server!",
        "idgame": -1
    }
    return JsonResponse(response_data)

#pomocne metode koje malo ulepsavaju kod

from .models import Llfield
def get_ll(id_ll):
    #metoda koja na osnovu id_LL vraca parove za spojnice
    # Autor: Filip Rinkovec 2019/0463
    ret_val = []
    links = Llfield.objects.all().filter(idll=id_ll)

    nums = random.sample(range(Llfield.objects.all().filter(idll=id_ll).count()), 8)
    print("Generating links....")

    for n in nums:
        ret_val.append([links[n].left, links[n].right])

    return ret_val

def get_qll_mm(IdLL):
    #Autor: Filip Rinkovec 2019/0463
    idLogicLink = IdLL.idll
    fields = get_ll(idLogicLink)
    prompt = IdLL.prompt
    return fields, prompt

def get_qll(request):
    #Autor: Filip Rinkovec 2019/0463

    llquestion= get_random_question(0,"ll")

    fields = get_ll(llquestion.idll)
    response_data = {
        "status":"success",
        "message":"Hello from server!",
        "prompt":llquestion.prompt,
        "id":llquestion.idll,
        "fields":fields
    }
    return JsonResponse(response_data)


def ll_multiplayer(request):
    return render(request, "logiclink_mm.html", {})

def result_multiplayer(request):
    username = getattr(request, "user")
    return render(request, "result.html", {"username": username})

from .models import Result
def get_results(request):
    #vracamo u JSON rezultate protivnika ako je zavrsio

    #user koji salje zahtev
    username = getattr(request, "user")
    opponent_name = request.headers["Opponent"]
    #request.headers["Opponent"], request.headers["Score1..4"], request.headers["Idgame"]

    #proveravamo da li postoji results za ovaj gejm + ovog usera
    opponent = User.objects.filter(username=opponent_name)[0]
    user = User.objects.filter(username=username)[0]
    game = Game.objects.filter(idgame=int(request.headers["Idgame"]))[0]
    #pravimo entry za user-a u Result, nakon cega proveravamo da li je protivnik zavrsio



    if Result.objects.filter(idgame=game, iduser = user).count() == 0:
        #ne postoji, pravimo ulaz u results za usera koji je ovo pozvao
        my_result = Result.objects.create(
            points1=request.headers["Score1"],
            points2=request.headers["Score2"],
            points3=request.headers["Score3"],
            points4=request.headers["Score4"],
            won="undefined",
            idgame=game,
            iduser=user
        )
    else:
        #postoji nas result, proveravamo da li je protivnik zavrsio
        my_result = Result.objects.filter(idgame=game, iduser=user)[0]
        if my_result.won != "undefined":
            if game.joined!=2:
                #protivnik otisao
                response_data = {
                    "status": "success",
                    "message": "Hello from server!",
                    "opponent": "Opponent quit",
                    "won": my_result.won
                }
            else:
                opponent_result = Result.objects.filter(idgame=game, iduser=opponent)[0]
                #protivnik je svojim pozivom vec ovo sredio, samo vracamo
                response_data = {
                    "status": "success",
                    "message": "Hello from server!",
                    "opponent": get_total(opponent_result),
                    "won": my_result.won
                }
            return JsonResponse(response_data)



    #myresult.won je undefined, gledamo da li je u medjuvremenu zavrsio protivnik kako bismo uporedili rezultate
    if Result.objects.filter(idgame=game, iduser = opponent).count() == 0:
        #nije zavrsio, proveravamo da li je mozda izasao
        if game.joined != 2:
            # neko je napustio
            game.finished = 1
            game.save()
            my_result.won="won"
            my_result.save()
            response_data = {
                "status": "success",
                "message": "Hello from server!",
                "opponent": "Opponent Quit",
                "won": "won"
            }
        else:
            response_data = {
                "status": "success",
                "message": "Hello from server!",
                "won": "undefined"
            }
        return JsonResponse(response_data)
    else:
        #protivnik zavrsio, uporedjujemo rezultate i dodeljujemo pobedu/poraz
        opponent_result = Result.objects.filter(idgame=game, iduser = opponent)[0]
        opponent_score = get_total(opponent_result)
        my_score = get_total(my_result)
        if my_score > opponent_score:
            opponent_result.won = "lost"
            opponent_result.save()
            my_result.won = "won"
            my_result.save()
        elif my_score == opponent_score:
            opponent_result.won = "draw"
            opponent_result.save()
            my_result.won = "draw"
            my_result.save()
        elif my_score < opponent_score:
            opponent_result.won = "won"
            opponent_result.save()
            my_result.won = "lost"
            my_result.save()
        game.finished = 1
        game.save()
        response_data = {
            "status": "success",
            "message": "Hello from server!",
            "opponent":get_total(opponent_result),
            "won": my_result.won
        }
        return JsonResponse(response_data)

def get_total(result):
    ret = 0
    ret += int(result.points1)
    ret += int(result.points2)
    ret += int(result.points3)
    ret += int(result.points4)
    return ret

def leave_game(request):

    username = getattr(request, "user")
    if User.objects.filter(username=str(username)).count()!=1:
        return JsonResponse({"status": "success"})

    user = User.objects.filter(username=username)[0]
    """
    Ako postoji game kojeg sam ja deo a da nije finished, joined --
    """
    if Game.objects.all().filter(iduser1=user,finished=0).count()!=0:
        #postoji
        for game in Game.objects.all().filter(iduser1=user,finished=0):
            if game.timestarted is not None:
                game.joined = game.joined-1
                if game.joined == 0: #svi su izasli
                    game.finished = 1
                game.save()
    if Game.objects.all().filter(iduser2=user,finished=0).count()!=0:
        #postoji
        for game in Game.objects.all().filter(iduser2=user,finished=0):
            if game.timestarted is not None:
                game.joined = game.joined-1
                if game.joined == 0: #svi su izasli
                    game.finished = 1
                game.save()
    print(str(username) + "left game")

    return JsonResponse({"status": "success"})

def redirect_to_admin_home(request):
    return redirect('admin_home')
