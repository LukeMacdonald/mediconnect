ECHO Building services...
ECHO =====================
call mvn -f ..\server\availability_service -B package --f pom.xml
call mvn -f ..\server\booking_service -B package --f pom.xml
call mvn -f ..\server\communication_service -B package --f pom.xml
call mvn -f ..\server\medication_service -B package --f pom.xml
call mvn -f ..\server\message_service -B package --f pom.xml
call mvn -f ..\server\prescription_service -B package --f pom.xml
call mvn -f ..\server\profile_service -B package --f pom.xml
