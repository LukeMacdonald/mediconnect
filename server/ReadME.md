# Backend (Server)
## Microservice Structure
### Profile Service
What this microservice controls:
- CRUD operations on user profiles
- Registration/Login operations
- Setting up authentication/authority of users

Port: 8080

### Availability Service
What this microservice controls:
- CRUD operations on doctor availabilities

Port: 8081
### Communication Service
What this microservice controls:
- The applications emailing system
- The user chat function

Port: 8082
### Booking Service
What this microservice controls:
- CRUD operations on booking an appointment

Port: 8083

## Database
The ND Telemedicine Application uses a H2 embedded, open-source, and in-memory database.
- Database stored in the "storage" directory

### User Table
- id
- email
- password
- role (superuser,patient,doctor)
- first name
- last name
- dob
- phone number

### Verification Table
- email
- code

### Avaiability Table
- doctor id
- start time
- end time
- day of week (integer)

### Appointment Table
- appointment id
- doctor id
- patient id
- date
- time
