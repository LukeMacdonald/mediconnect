
# ND-Telemedicine-App

# RMIT SEPT 2022 Major Project

# Group 1

## Members
* s3906344 (Anton Angelo)
* s3902121 (Jeffrey Siaw)
* s3897951 (Stefan Stevanovski)
* s3888490 (Luke Macdonald)
* s3905838 (Henry Huynh)

## Records

* Github repository : https://github.com/LukeMacdonald/ND-Telemedicine-App
* jira Board : https://lukemacdonald2.atlassian.net/jira/software/projects/SG1/boards/1
* Google Docs : https://drive.google.com/drive/folders/185IAOrQImEoBMZPBEjyWyC5Q_VbY7f01?usp=sharing

	
## Code documentation - Release 0.1.0 - date
* User signup/login
* User profile creation
* Doctor set availabilities
* User book appointment with doctor
  

To run the application locally : 
1) mvn -f server/ND-Telemedecine -B package --f pom.xml
2) press the start icon on the NdTelemedecineApplication.java file inside server
3) cd into client and run "flutter pub get"
4) press the start icon on the main.dart file inside client/lib

## Application Feature Details
### Adding a Doctor:
1) Doctors can only be added to the application by the super admin
2) When the super admin clicks the add doctor button after adding the email there is a little bit of a delay before a confirmation of email sent is displayed.
### Chat Function:
1) A patient can only start a chat with a doctor with who they have aldready booked an appointment with before.
2) A patient can start a chat by clicking the add button on the message menu
3) If a patient hasnt started a chat with a doctor then  doctor can start a chat by clicking on the message patient button on the patient menu
## Deployment
### Front End:
* For the deployment for the frontend part of our application we would use the CodeMagic website as it allows for CI/CD for flutter applications
* Codemagic is connected to our GitHub repository so whenever a new push is made to the repo Codemagic automatically updates the deployed build.
* Deploying with this website requires a payment to both Apple Store and Google Play Store in order to get the key signing the app requires to be deployed on these services which is why we havent officially deployed it.