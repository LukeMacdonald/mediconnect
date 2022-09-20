
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

## Example Prexisting Accounts
### Patient
* Email: patient@gmail.com
* Password: patient
### Doctor
* Email: doctor@gmail.com
* Password: doctor
### SuperAdmin
* Email: admin@gmail.com
* Password: admin

## Extra Notes
The Cloud service used to access the database only allows a very minimum number of users to be running the server
at once which can cause the appliation to somees fail.
