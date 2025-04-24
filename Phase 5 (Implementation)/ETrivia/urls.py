from django.contrib import admin
from django.urls import path

from Etrivia.admin import add_logic_link, add_question, remove_logic_link, remove_question
from . import views


urlpatterns = [
    path('', views.index, name='index'),
    path('login/', views.login_request, name='login'),
    path('logout/', views.logout_request, name='logout'),
    path('signin/', views.signin_request, name='signin'),
    path('training/', views.training, name='training'),
    path('matchmaking/', views.matchmaking, name='matchmaking'),
    path('leaderboard/', views.leaderboard, name='leaderboard'),
    path('profile/', views.profile, name='profile'),
    path('get_qow', views.get_qow, name='get_qow'),
    path('get_qll',views.get_qll,name="get_qll"),
    path('get_ll',views.get_ll,name="get_ll"),
    path('get_numbers', views.get_numbers, name='get_numbers'),
    path('get_secret_sequence', views.get_secret_sequence, name='get_secret_sequence'),
    path('training/secretsequence/', views.secret_sequence_page, name='secret_sequence_page'),
    path('training/numberhunt/', views.number_hunt_page, name='number_hunt_page'),
    path('training/questionofwisdom/', views.question_of_wisdom_page, name='question_of_wisdom_page'),
    path('training/logiclink/',views.logiclink_page,name="logiclink_page"),
    path('get_queue', views.get_queue, name='get_queue'),
    path('get_game', views.get_game, name='get_game'),
    path('leave-queue', views.leave_queue, name='leave-queue'),
    # multiplayer match pages
    path('multiplayer-match/number-hunt', views.multiplayer_match, name='multiplayer-match'),
    path('multiplayer-match/secret-sequence', views.ss_multiplayer, name='ss-multiplayer'),
    path('multiplayer-match/logic-link', views.ll_multiplayer, name='ll-multiplayer'),
    path('multiplayer-match/question-of-wisdom', views.qow_multiplayer, name='qow-multiplayer'),
    path('multiplayer-match/result', views.result_multiplayer, name='result-multiplayer'),
    path('multiplayer-match/get_results', views.get_results, name='get_results'),
    path('multiplayer-match', views.multiplayer_match, name='multiplayer-match'),
    path('leave-game', views.leave_game, name='leave-game'),
    
    #admin
    path('admin/', admin.site.urls),
    path('admin/remove_logic_link/', admin.site.admin_view(remove_logic_link), name='remove_logic_link'),
    path('admin/remove_question/', admin.site.admin_view(remove_question), name='remove_question'),
    path('admin/add_question/', admin.site.admin_view(add_question), name='add_question'),
    path('admin/add_logic_link/', admin.site.admin_view(add_logic_link), name='add_logic_link'),

]
