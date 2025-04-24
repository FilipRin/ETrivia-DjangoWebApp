
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

# Autor: Mihajlo Rajić 2021/0331
def leaderboard(request):
    leave_game(request)
    
    time_frame = request.GET.get('time_frame', 'daily')
    today = now().date()

    if time_frame == 'daily':
        start_date = today
    elif time_frame == 'weekly':
        start_date = today - timedelta(days=today.weekday())
    elif time_frame == 'monthly':
        start_date = today.replace(day=1)
    else:
        start_date = today

    end_date = now()

    print(end_date, " ", start_date)

    results = Result.objects.filter(timestamp__range=[start_date, end_date])

    stats = {}
    for result in results:
        user_id = result.iduser_id
        if user_id not in stats:
            stats[user_id] = {'wins': 0, 'losses': 0}

        if result.won == 'won':
            stats[user_id]['wins'] += 1
        else:
            stats[user_id]['losses'] += 1

    leaderboard_data = []
    for user_id, stat in stats.items():
        wins = stat['wins']
        losses = stat['losses']
        total_games = wins + losses
        win_percentage = (wins / total_games) * 100 if total_games > 0 else 0
        win_percentage = round(win_percentage, 2) 

        leaderboard_data.append({
            'name': User.objects.get(id=user_id).username,
            'wins': wins,
            'losses': losses,
            'win_percentage': win_percentage,
        })

    leaderboard_data.sort(key=lambda x: (-x['wins'], -x['win_percentage']))

    print("leaderboard")
    return render(request, "leaderboard.html", {'leaderboard_data': leaderboard_data})


def training(request):
    leave_game(request)
    #ova metoda se u prinicpu nece ni menjati, treba napraviti metode koje generisu igre kad se klikne na igru u treningu
    print("training")
    return render(request,"training.html",{})

# Autor: Mihajlo Rajić 2021/0331
@login_required(login_url='login')
def profile(request):
    leave_game(request)
    user_statistics = get_user_statistics(request.user.id)

    print("profile")
    return render(request, 'profile.html', {'user_statistics': user_statistics})

from django.db.models import Avg

# Autor: Mihajlo Rajić 2021/0331
def get_user_statistics(user_id):
    wins = Result.objects.filter(iduser=user_id, won='won').count()
    
    losses = Result.objects.filter(iduser=user_id, won='lost').count()
    
    average_points1 = Result.objects.filter(iduser=user_id).aggregate(Avg('points1'))['points1__avg']
    average_points2 = Result.objects.filter(iduser=user_id).aggregate(Avg('points2'))['points2__avg']
    average_points3 = Result.objects.filter(iduser=user_id).aggregate(Avg('points3'))['points3__avg']
    average_points4 = Result.objects.filter(iduser=user_id).aggregate(Avg('points4'))['points4__avg']

    average_points1 = round(average_points1, 2) if average_points1 is not None else 0
    average_points2 = round(average_points2, 2) if average_points2 is not None else 0
    average_points3 = round(average_points3, 2) if average_points3 is not None else 0
    average_points4 = round(average_points4, 2) if average_points4 is not None else 0
    
    
    return {
        'wins': wins,
        'losses': losses,
        'average_points1': average_points1,
        'average_points2': average_points2,
        'average_points3': average_points3,
        'average_points4': average_points4,
    }




def matchmaking(request):
    # Autor: Djordje Jovanovic 0293/2021
    #ovo ubacuje usera u queue
    username = str(getattr(request,'user'))

    if username == "AnonymousUser":
        #user nije ulogovan, ne moze da pristupi
        context = {
            "message":
                "Available only to registered users!"
        }
        return render(request,"home.html",context)

    if Multiplayerqueue.objects.all().filter(username=username).count()==0  and not user_in_game(username):
        Multiplayerqueue.objects.create(username=username, timejoined=datetime.now())
        print(username + " Usao u queue")

    return render(request,"matchmaking.html",{})

def user_in_game(username):
    #provera da li je korisnik u partiji
    user = User.objects.all().filter(username=username)[0]
    if Game.objects.all().filter(iduser1 = user,timestarted=None).count() == 0 and Game.objects.all().filter(iduser2 = user,timestarted=None).count() == 0:
        return False
    return True
import random

from django.db.models import Count
def get_random_question(num,which_class):
    # Autor: Djordje Jovanovic 2021/0293
    #num je broj random brojeva
    #funkcija vraca ili random broj pianja za qow ili jedno nasumicno pitanje za LL gde mora da vazi da postoji bar 8 spojnica
    used = set()
    ret = []
    questions = Questionsqow.objects.all()
    min = 0
    max = 1
    if (which_class == "qow"):
        max = Questionsqow.objects.count()
    elif (which_class == "ll"):
        annotated_questions = Questionsll.objects.annotate(llfield_count = Count('llfield'))
        filtered_questions = annotated_questions.filter(llfield_count__gte=8).order_by("-idll")
        numm = random.randint(0, filtered_questions.count() - 1)
        #print("QUESTION: " + str(filtered_questions[numm].idll))
        return filtered_questions[numm]

    number = random.randint(min,max-1)
    for i in range(num):
        while number in used:
            number = random.randint(min, max-1)
        ret.append(questions[number])
        used.add(number)

    return ret


from .models import Game
@receiver(post_save,sender = Multiplayerqueue)
def check_for_match(sender,instance,created,**kwargs):
    #Autor: Djordje Jovanovic 0293/2021
    #Ovo je funkcija koja se poziva kad god se doda nov ulaz u multiplayerqueue
    #funkcija onda proverava da li postoje bar 2 igraca u queue i pravi game sa njima, na kraju ih izbacuje iz queue
    if created:
        queue_count = Multiplayerqueue.objects.count()
        print("usli u check")
        if queue_count >=2:

            users = Multiplayerqueue.objects.order_by("timejoined")[:2]

            #ovde treba da se izgenerisu 5 IDQoW i po 1 za ostale igre
            user_id1 = User.objects.filter(username=users[0].username)[0]
            user_id2 = User.objects.filter(username=users[1].username)[0]

            username1 = user_id1.username
            username2 = user_id2.username

            print("usli u check1")
            numberhunt_values = generate_numberhunt()
            numberhunt = NumberHunt.objects.create(
                goal_number=numberhunt_values[0],number1=numberhunt_values[1], number2=numberhunt_values[2],
                number3=numberhunt_values[3],number4=numberhunt_values[4],number5=numberhunt_values[5],
                number6=numberhunt_values[6]
            )
            #numberhunt.save()
            print("usli u check2")
            secretsequence_values = generateSecretSequence()
            secretsequence = SecretSequence.objects.create(
                symbol11=secretsequence_values[0][0],symbol12=secretsequence_values[0][1],symbol13=secretsequence_values[0][2],
                symbol21=secretsequence_values[1][0],symbol22=secretsequence_values[1][1],symbol23=secretsequence_values[1][2],symbol24=secretsequence_values[1][3],
                symbol31=secretsequence_values[2][0],symbol32=secretsequence_values[2][1],symbol33=secretsequence_values[2][2],symbol34=secretsequence_values[2][3],
                symbol35=secretsequence_values[2][4]
            )
            #secretsequence.save()

            print("usli u check3")
            ll_question = get_random_question(0,"ll")

            qow_questions = get_random_question(5,"qow")


            print("usli u check4")
            game = Game.objects.create(timestarted=None,iduser1=user_id1, iduser2=user_id2,
             idll=ll_question,idqow1_id=qow_questions[0].idqow, idqow2_id=qow_questions[1].idqow,idqow3_id=qow_questions[2].idqow,
                                       idqow4_id=qow_questions[3].idqow,idqow5_id=qow_questions[4].idqow,
                                       idnh=numberhunt,idss=secretsequence)
            #game.save()
            print("Created game " + user_id1.username + " vs " + user_id2.username)
            #Ovde se 2 puta brise users[0] jer nakon brisanja prvog u users zapravo ostaje samo 1

            for u in users:
                u.delete()





#Autor: Uroš Rajčić 2021/0540
def get_numbers(request):
    #metoda koja vraca brojeve za NH igru
    number = random.randint(1, 999)
    
    number1 = random.choice([1, 2, 3, 4, 5, 6, 7, 8, 9])
    number2 = random.choice([1, 2, 3, 4, 5, 6, 7, 8, 9])
    number3 = random.choice([1, 2, 3, 4, 5, 6, 7, 8, 9])
    number4 = random.choice([1, 2, 3, 4, 5, 6, 7, 8, 9])
    number5 = random.choice([10, 15, 20])
    number6 = random.choice([25, 50, 100])
    

    response_data = {
        "status": "success",
        "message": "Hello from server!",
        "number_to_find": number,
        "numbers_made": [number1, number2, number3, number4, number5, number6]
    }

    return JsonResponse(response_data)

#Autor: Mihajlo Rajić 2021/0331
def get_secret_sequence(request):
    sequence = generateSecretSequence()

    response_data = {
        "status": "success",
        "message": "Hello from server!",
        "secret_sequence": sequence
    }

    return JsonResponse(response_data)



def get_qow(request):
    # Autor: Djordje Jovanovic 2021/0293
    question = Questionsqow.objects.order_by("?")[0]

    response_data = {
        "status":"success",
        "message":"Hello from server!",
        "question":question.question,
        "answer":question.correct,
        "incorrect":[question.incorrect1,question.incorrect2,question.incorrect3]
    }

    return JsonResponse(response_data)


#Autor: Uroš Rajčić 2021/0540
def number_hunt_page(request):
    return render(request,"numberhunt_tr.html",{})


def logiclink_page(request):
    return render(request,"logiclink_tr.html",{})

def question_of_wisdom_page(request):
    return render(request,"questionofwisdom_tr.html",{})


#Autor: Mihajlo Rajić 2021/0331
def secret_sequence_page(request):
    return render(request,"secretsequence_tr.html",{})




def get_queue(request):
    # Autor: Djordje Jovanovic 2021/0293
    #metoda koja dohvata broj ljudi u queue koji prikazujemo na home stranici
    response_data = {
        "status":"success",
        "message":"Hello from server!",
        "count":Multiplayerqueue.objects.count()
    }

    return JsonResponse(response_data)


def get_game(request):
    # Autor: Djordje Jovanovic 0293/2021
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
def get_numberhunt_mm(numberhunt):
    # Autor: Djordje Jovanovic 0293/2021
    numberhunt_numbers = []

    numberhunt_numbers.append(numberhunt.goal_number)
    numberhunt_numbers.append(numberhunt.number1)
    numberhunt_numbers.append(numberhunt.number2)
    numberhunt_numbers.append(numberhunt.number3)
    numberhunt_numbers.append(numberhunt.number4)
    numberhunt_numbers.append(numberhunt.number5)
    numberhunt_numbers.append(numberhunt.number6)

    return numberhunt_numbers
def get_secretsequence_mm(secret_sequence):


    secret_sequence_values = []

    secret_sequence_values.append(secret_sequence.symbol11)
    secret_sequence_values.append(secret_sequence.symbol12)
    secret_sequence_values.append(secret_sequence.symbol13)
    secret_sequence_values.append(secret_sequence.symbol21)
    secret_sequence_values.append(secret_sequence.symbol22)
    secret_sequence_values.append(secret_sequence.symbol23)
    secret_sequence_values.append(secret_sequence.symbol24)
    secret_sequence_values.append(secret_sequence.symbol31)
    secret_sequence_values.append(secret_sequence.symbol32)
    secret_sequence_values.append(secret_sequence.symbol33)
    secret_sequence_values.append(secret_sequence.symbol34)
    secret_sequence_values.append(secret_sequence.symbol35)

    return secret_sequence_values
def generate_numberhunt():
    ret_val = []
    number = random.randint(1, 999)

    number1 = random.choice([1, 2, 3, 4, 5, 6, 7, 8, 9])
    number2 = random.choice([1, 2, 3, 4, 5, 6, 7, 8, 9])
    number3 = random.choice([1, 2, 3, 4, 5, 6, 7, 8, 9])
    number4 = random.choice([1, 2, 3, 4, 5, 6, 7, 8, 9])
    number5 = random.choice([10, 15, 20])
    number6 = random.choice([25, 50, 100])

    ret_val.append(number)
    ret_val.append(number1)
    ret_val.append(number2)
    ret_val.append(number3)
    ret_val.append(number4)
    ret_val.append(number5)
    ret_val.append(number6)
    return ret_val

from .models import Llfield
def get_ll(id_ll):
    #metoda koja na osnovu id_LL vraca parove za spojnice
    # Autor: Djordje Jovanovic 0293/2021
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


# Autor: Mihajlo Rajic 0331/21
# Metoda vraca 3 niza od po 3,4,5 random simbola
def generateSecretSequence():
    ret_val = []
    seq1 = []
    seq2 = []
    seq3 = []
    for i in range(3):
        seq1.append(random.randint(1, 6))
    ret_val.append(seq1)

    for i in range(4):
        seq2.append(random.randint(1, 6))
    ret_val.append(seq2)

    for i in range(5):
        seq3.append(random.randint(1, 6))
    ret_val.append(seq3)

    return ret_val

def get_qow_mm(game):
    #Autor: Djordje Jovanovic 0293/2021
    ret_val = []
    indexes = []

    indexes.append(game.idqow1)
    indexes.append(game.idqow2)
    indexes.append(game.idqow3)
    indexes.append(game.idqow4)
    indexes.append(game.idqow5)

    for index in indexes:
        ret_val.append([index.question,
                        index.correct,
                        index.incorrect1,
                        index.incorrect2,
                        index.incorrect3])
    return ret_val

#dohvatanje stranica za multiplayer partiju:
def multiplayer_match(request):
    return render(request,"numberhunt_mm.html",{})

def ss_multiplayer(request):
    return render(request, "secretsequence_mm.html", {})

def ll_multiplayer(request):
    return render(request, "logiclink_mm.html", {})

def qow_multiplayer(request):
    return render(request, "questionofwisdom_mm.html", {})
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

#autor Djordje Jovanovic 0293/2021
def leave_queue(request):
    username = getattr(request, "user")
    if Multiplayerqueue.objects.all().filter(username=username).count() == 1:
        Multiplayerqueue.objects.all().filter(username=username).delete()
    print(str(username) + "napustio queue")

    return JsonResponse({"status": "success"})

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