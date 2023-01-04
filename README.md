# Habit Tracker using Flutter

This Project  was made using Flutter.

## Features
- uses [Hive](https://docs.hivedb.dev/#/) for local storage on devices.
- uses [Firebase](https://firebase.google.com/docs/flutter/setup) to Login users**.
- Users can analyze their habits using a heatmap integrated into the app
  just like a github streak heatmap.
- Users can Add/Edit any habit and it will be stored in a local database

## Login Page:
![image](https://user-images.githubusercontent.com/97280556/199313772-aa512335-3166-4118-a368-d290663b0b55.png)

## Home Page:
![image](https://user-images.githubusercontent.com/97280556/199313639-595b4b7e-f36a-472d-b5ab-999b79a8c16c.png)

## Slidable buttons:
![image](https://user-images.githubusercontent.com/97280556/199655112-8a542ac1-ba13-468a-bc71-138970efdc5c.png)

## Add/Edit habits:
![image](https://user-images.githubusercontent.com/97280556/199655181-1d35c60b-acff-4333-8a26-431a4a60e332.png)

## Planned Features
- Users will be able to get timers for individual habit.
- In built [Pomodoro](https://en.wikipedia.org/wiki/Pomodoro_Technique) timer for users.
- Option for users to switch to Dark Mode.

## Known issues
- Firebase login isn't working currently due to some conflict.

## References
- [Mitch_Koko](https://www.youtube.com/c/MitchKoko) 
- [Johannes_Milke](https://www.youtube.com/c/JohannesMilke)  
- [flutter.dev](flutter.dev)

Operating Systems used - Windows 11

!!IMP:
To check the Login page u can change the line 23 in main.dart
from(home:HomePage())  to (home:LoginPage)
