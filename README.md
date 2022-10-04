# cinema_app

Grazac Project
Project Brief You’ve been hired to work as a freelancer and build a mobile app for OOPL Cinema Admin Team.

To be specific, we want the following features

1. Admin can log in (Email and Password) 
2. New Admin registration (Email, First Name, Last Name and Password) 
3. Admin should be able to post new movies (Title and description should be in Movie object) 
4. To edit information about existing movies  
5. Admin should be able to view all movies 
6. Admin should be able to remove movies

NOTE: Use Firebase for Auth and Data persistence 
and remember you have to design the user interface with your discretion  

This project creates an app for OOPL Cinemas admin users to store the name of movies, along with their
description and images.
Firebase is used to do the authentication of the users who want to register and sign in.
The sign in method is via email and password on firebase.

The admin can add movies by sending the name of the movie and the movie description to firestore 
and store the image on the storage of firestore while simulataneouly storing the url download link
on firestore too.
You can edit the description of the movie and also delete movies from the current list.
The project also uses Provider to manage the state of the app.
 