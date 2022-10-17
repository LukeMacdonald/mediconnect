#! /bin/bash
echo "Building services..."
echo "====================="
mvn -f ..\server\prescription_service -B package --f pom.xml