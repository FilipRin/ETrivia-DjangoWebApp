# ETrivia-DjangoWebApp
Team project (4 people) for University
-----------------------------------------------------
* This web application is a quiz game, inspired by TV show "Slagalica". 
  It has multiplayer as well as singleplayer (training) modes. You can play as guest or you can create your account.
  If you have an account, you can check your stats and leaderboard.
  If you are admin, you can search players and reset their stats or ban their account. You can also add new questions or new prompts for some games.
* Quiz contains series of 4 mini-games: Number Hunt, Secret Sequence, Logic Link and Question of Wisdom.
  Multiplayer functions like this:
    - You get paired up with an opponent that was in queue
    - Both of you get the same questions/puzzles but each of you solves it individually
    - When faster player finishes the quiz, player is sent to scoring page where their scores are shown. Also there they can see on which game is opponent currently, and opponent score on finished games
    - After both players finish, all scores are shown with total score and winner is declared
    - Players return to main menu and their stats are updated in database

* My tasks were making the Logic Link game page (training and multiplayer), Login and Sign-up pages and testing Matchmaking and Question of Wisdom game.
  Login and Sign-up pages are self-explanatory, but Login Link works like this (example: "Writers and their books" were the drawn prompt from database) :
   - left column have names of writers that have to be matched with correct title of their book on right column
   - Player chooses writer and then book which he thinks that writer wrote
   - If player guessed correctly both buttons become green and he gets 3 points, if he was wrong then button from left column becomes red while his score remains unchanged
   - Game ends when player connects all left column buttons, then all right column buttons that were not guessed correctly become red
  Automated testing of matchmaking is done using Selenium WebDriver by opening 2 browsers (Edge and Chrome). On each browser different user would log in and queue up for a multiplayer game.
  Then when they get into a game, test would end in success.
  Automated testing of Question of Wisdom game is done using Selenium IDE by opening a browser, going to website and entering training mode for Question of Wisdom as guest.
  Then test will answer to a few questions and then return back to game selection. If assert passes, test is success. 

* This project was created through 7 phases.
  It was developed in Django (Python-based framework), but we also used MySQL for relational databases, Javascript (JQuery) for page functionality with Ajax for event-handling.
  Testing was done using Selenium IDE and WebDriver.
  Apart from coding, I also wrote documentaion about functionality of certain parts of project, as well as database design.
