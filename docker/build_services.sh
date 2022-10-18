#! /bin/bash
echo "Building services..."
echo "====================="
mvn -f server/availability_service -B package --f pom.xml
mvn -f server/booking_service -B package --f pom.xml
mvn -f server/communication_service -B package --f pom.xml
mvn -f server/medication_service -B package --f pom.xml
mvn -f server/message_service -B package --f pom.xml
mvn -f server/prescription_service -B package --f pom.xml
mvn -f server/profile_service -B package --f pom.xml