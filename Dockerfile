# Use a base image with Maven and Java
FROM maven:3.8.3-openjdk-11      //#we can mention any version of maven and jdk but use latest version and it will download from internet

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven project files into the container
COPY pom.xml .       // # this will Copy the pom.xml file from project(source) to the root(.) of app folder inside the container(target)
COPY src ./src       // # this will Copy the src file from project(source) to the root(.) of app folder inside the container(target) by creating src folder

# Switch to the directory containing the pom.xml
WORKDIR /app

# Run Maven tests
CMD ["mvn", "test"]
