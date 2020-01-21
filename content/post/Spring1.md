+++
Categories = ["Development","Spring","Java"]
Description = ""
Tags = ["Development","Spring","Java"]
date = "2020-01-17T21:18:29-07:00"
menu = "main"
title = "Spring Boot Kafka Setup"

+++

### -Spring Boot Kafka Setup-

<br>
![spring](/images/spring/springlogo.png)
<br>

 I've been told Spring Boot makes `Java` ludicrously easy -- to the point that some developers become so dependent on it that they forget how to write code without it. While I think that is probably a bit of an exaggeration, after spending a week with Spring Boot I can definitely see its merits when one wants to quickly set up a microservice.
<br>
 
Most of my work with Java microservices has utilized the Dropwizard framework. It’s lightweight and fairly easy to setup and get started. Spring Boot takes the ease of setup to a whole new level though. The power of @ is real. Using Spring annotations let me set-up how I wanted my class to behave in a very succinct and comprehendible manner.
<br>
 
As part of the Spring Boot microservice I’ve been working on I needed to implement a Kafka Producer (checkout my earlier post on Kafka for more Kafka insight: _**[Kafka](http://hanshovanitz.com/post/kafka/)).**_  
<br>

But the application’s main method is essentially just this:
<br>
 
```java
public static void main(String[] args) {
    SpringApplication.run(Main.class, args);
}
```
 
Where do I set up the different pieces that I’ll need throughout the application? Enter @Component. Using the @Component annotation the Spring framework will automatically detect my class and register it as a Spring bean. Essentially this means that only a single instance of the class is created and this instance is created during application startup. So using @Component will let me use my Kafka Producer in my other classes. Great! As a side note, a little more work is needed: you’ll need to add something like:

 ```java
@SpringBootApplication(scanBasePackages = {"com.stuff.mypackage"}
```
in the class with your main method. This tells Spring where to look for the Component annotation. 
<br>
 
Next I needed to figure out how to load a bunch of properties while creating the Kafka Producer. I decided to store the properties in a yml file. Spring offers a really easy way to grab those properties: The @Value annotation. If my application.yml looks like this:

```
-kafka-config:
  topicName: Kafka1_001_my-application-pick-up
```

My Kafka Producer class might look, in part, like this:
<br>
 
```java
private String topicName;
public MyKafkaProducer(@Value("${kafka-config.topicName}") String topicName) {
    this.topicName = topicName;
}
```

Now I’m ready to create my Producer object so that I can publish to the Kafka Topic.
In my constructor or maybe in a @PostConstruct method I would then have something like this:
<br>

```java
public Producer<String, String> myProducer;

...

Properties kafkaProperties = new Properties();

kafkaProperties.putAll(getKafkaProducerConfiguration());

kafkaProperties.putAll(getSSLConfiguration());

myProducer = new KafkaProducer<>(kafkaProperties);
```
 
Then I needed to create a publish method to actually send the message:
<br>
 
```java
public void publishToKafka(String eventKey, String eventData) throws InterruptedException, ExecutionException {

    ProducerRecord<String, String> producerRecord = new ProducerRecord<>(topicName, eventKey, eventData);

    RecordMetadata metadata = myProducer.send(producerRecord).get();
}
```

At this point I was now ready to call the publish method from elsewhere in the application (like a request controller class:
<br>

```java
myKafkaProducer.publishToKafka(REQUEST.getReqId(), mapper.writeValueAsString(MY_REQUEST));
```
 
The microservice was now ready to start publishing messages to the chosen Kafka topic. 
Finally, I thought I’d utilize one last Spring annotation: @PreDestroy. 
The PreDestroy annotation is an important component of the Spring Bean’s lifecycle. A method annotated with @PreDestroy runs only once, just before Spring removes the bean from the application context – so this is a good place to close down any open resources:
<br>

```java
@PreDestroy

public void stop() throws Exception {
    try {

        //ensure that all records accumulated for publishing are cleared before closing the connection

        myProducer.flush();

        myProducer.close();
    }catch (Exception ex) {

        LOG.error("Kafka Producer Error: " + ex);
    }
}
```

Update: @PreDestroy is actually part of Java EE, it is just commonly used in Spring applications. 
<br>
 
Note: Apparently @PreDestroy has been removed as of Java 11 but it can still be used with this dependency (Example if using Maven): 
```
<dependency>
    <groupId>javax.annotation</groupId>
    <artifactId>javax.annotation-api</artifactId>
    <version>1.3.2</version>
</dependency>
```

The ease by which I was able to setup a Kafka Producer in the Spring Boot microservice has peaked my curiosity about how long it would take me to build a Spring Boot application and deploy it as a web service. I’ve been interested in what the experience is like setting up an AWS EC2 web application server and I think Spring Boot is a great candidate that will allow me to quickly do that. Stay tuned!