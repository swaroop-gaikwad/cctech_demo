#java runtime
FROM maven:3.8-openjdk-17 AS java-builder
WORKDIR /app
COPY java-app/pom.xml ./
COPY java-app/src ./src/
RUN mvn clean package

#node runtime
FROM node:18 AS node-builder
WORKDIR /app
COPY node-app/package.json ./
RUN npm install
COPY node-app/ ./

#buildtime
FROM openjdk:17
WORKDIR /app

COPY --from=java-builder /app/target/CCTechapp.jar ./CCTechapp.jar

COPY --from=node-builder /app ./node-app

RUN cd node-app && npm install

EXPOSE 8080  # Java App
EXPOSE 3000  # Node.js App

CMD java -jar CCTechapp.jar & cd node-app && node server.js


