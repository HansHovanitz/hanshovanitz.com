+++
Categories = ["Development","GoLang"]
Description = ""
Tags = ["Development","golang"]
date = "2018-08-14T19:19:56-07:00"
menu = "main"
title = "Kafka"

+++

### -Kafka - Not the Franz You are Expecting-

I had the chance to implement a Kafka producer and consumer in an application at work. I was blown away by how powerful Kafka is and how it was actually pretty easy to set up. 
For anyone who isn't sure what Kafka is, I won't go into depth here but in a nutshell it is a publish/subscribe messaging pattern where a sender (publisher) creates a message (some piece of data) that is not specifically directed to a receiver. Instead, a receiver (subscriber) will subscribe to a publisher to receive a certain class of messages.
<br> 

When would I use a pub/sub configuration? Let’s say you have an application that needs to send some sort of monitoring data somewhere. One approach would be to directly call some other application that displays that data on something like a dashboard.
<br>

(Picture 1 here)
![Pic1](/images/.../.jpg)

This might work fine and well of you want to stop here. But what if you want to analyze metrics for a longer duration of time than the dashboard can handle? Then maybe you’d create a different application to do more intensive longitudinal analyzation. Then you have some sort of issue with your application in a production environment and realize you need some sort of active polling of the application to raise alerts. That’s another service you’d need to create. Three different services are now connected to your original application. Then, along comes a new application and you want to use those same services for dashboarding, crunchy metrics, and alerting. Now you begin to have wires crisscrossing all over the place. 
<br>

(Picture 2 here)

The tangled web that you've woven can quickly become unmanageable. Technical debit begins to pile up and you might wonder why you ever started on this pub/sub journey. But then, you have an idea! What if you set up a single application that receives metrics from all the applications that you have out there in your ecosystem, and then provide a server to query those metrics for any other application/system that needs them. By taking this sort of approach you'd end up with something akin to the below diagram: 
<br>

(Picture 3 here)

Kafka makes this whole process easy. It uses the concept of Kafka clients, which can be either producers and consumers. These can be thought of similarly the publishers and subscribers in the aforementioned description. A producer creates some data, which is called a message, and pushes that data to a “distributed commit log”. The commit log provides a record of all the messages. The messages in Kafka are categorized into what are called topics. Topics are a way to group particular messages together by a desired category. Then, Kafka consumers can subscribe to a topic and do something with the messages there. Part of the power of Kafka is that many consumers can be subscribed to the same topic and that topic can be supplied messages by many producers. This setup can be distributed within the Kafka system provides both failure protection and scalability.
<br>

This is a rather brief overview for a somewhat complicated topic but, and there are many more advantages to using Kafka and intricacies to enable it to operate on a scalable, highly-effective level. 
<br>

I cannot share code from where I've implemented Kafka at work, but to give a little insight here are some snippets of how one might use a producer and a consumer in their `Java` application:

```java
//#Producer

//set the properties for Kafka (I prefer to load configuration files using yml)
Properties prop = new Properties();

//load the properties from somewhere
props.load("some input");

//or progamatically set them
//props.put("key", "value");

//create the kafka producer
Producer<String, String> producer = new KafkaProducer<String, String>(props);

//send some messages
for (int i = 0, i < 5, i++) {
    producer.send(new ProducerRecord<String, String>(topicName, Integer.toString(i), Integer.toString(i)));
    System.out.println("Message was sent successfully");
    producer.close();
}
```

```java
//#Consumer

//set the properties for Kafka
Properties prop = new Properties();

//load or set the kafka properties and make sure the kafka topic name is correct

//create the kafka consumer
KafkaConsumer<String, String> consumer = new KafkaConsumer<String, String>(props);

//subscribe to a list of topics (these are topics that producers send messages to)
consumer.subscribe(Arrays.asList(topicName));

//look for some messages
while (true) {
    ConsumerRecords<String, String> recs = consumer.poll(100);
    //print out the messages
    for (ConsumerRecord<String, String> record : recs) {
        System.out.println("key: " + record.key() + " value: " + record.value());
    }
}
```

The hardest part is figuring out the proper configuration/properties settings (mostly just making sure you have all the right fields). A full list can be found **[here](https://kafka.apache.org/documentation/#producerconfigs)**.
Actually using this powerful tool in your code is easy. Clearly, the actual implementation in a real-world application is more complicated, but after a little exploration, tinkering, and practice – not by that much. 