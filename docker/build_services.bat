ECHO Building services...
ECHO =====================
ECHO Building prescription service...
call mvn -f ..\server\prescription_service -B package --f pom.xml