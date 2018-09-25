+++
Categories = ["Development","Java"]
Description = ""
Tags = ["Development","Java", "Jedis"]
date = "2018-09-25T16:06:23-07:00"
menu = "main"
title = "Jedis"

+++

### --Jedis and the RELK Stack--

Perhaps the most important question is: is it Jed-is or Jedi-s? I lean towards the former because it sounds like Redis but it can't be an accident that it looks like this is a library that Jedi's use. 
<br>

Anyway, so what is Jedis? Jedis is a client library written in `Java` for **[Redis](https://redis.io/)**. 
While there are other `Java` clients available to interface with Redis, Jedis is the fastest of the notable options. The application that this solution was needed for handles a very large volume of requests, so speed was esential. 
<br>

The use case for my problem was that, perhaps due to the application being legacy in many senses or perhaps due to the heavy load the application is typically under, not all of our logs were reaching our *other* logging service. 
We aready had a `RELK` stack setup for other uses, so I thought of trying to leverage it to see if it would solve our logging problem. 
As a quick side note, a `RELK` stack consists of a Redis server which receives data, which then gets picked up by Logstash, which transforms the data to have a meaningful structure and inserts it into ElasticSearch. Kibana then reads from Elasticsearch and allows users to traverse/explore the data, create dashboards, alerts, etc. 
<br>

![RelkStack](/images/jedis/relk1.jpg)

<br>

Below is a stripped-down dummy example of the JedisClient that I implemented: 

```java
public class JedisLogClient {
    //in this example we will be sending messages as a list of strings.
    //this is due to how the redis server I was working with was configured.
    //it might be easier to consider using key-value string pairs in which case
    //you would use jedis.set("key", "value").
    String queueName = "myQueue";
	String host = "myhost";
	int port = 8080;	
	static JedisPoolConfig poolConfig;
	static JedisPool jedisPool;
	
    //i want this to run when the application starts up
	static {	
		poolConfig = null;
		jedisPool = null;
		
		if (host != null && port != 0) {
			try {
				System.out.println("configuring the Jedis Pool");
				poolConfig = buildPoolConfig();
				jedisPool = new JedisPool(poolConfig, host, port);	
			}
			catch (Exception e) {
				System.out.log("Error setting up Jedis Pool");
			}	
		}
		else {
			System.out.println("Error: host or port is null ");
		}		
	}
	
    //the value here can be any string -- in the case of my application it is a 
    //concatonated string of various logs
	public static void jedisLog(String value) {
		Jedis jedis = null;
		
		try {
			jedis = jedisPool.getResource();
			jedis.lpush(queueName, value);
			System.out.println("Pushing the message string " + logString);
		}
		catch (Exception e) {
			System.out.println("Error: Unable to get resource from Jedis Pool");
		}
		finally {
			if (jedis != null) {
				jedis.close();
			}
		}
	}
	//jedisPool.destroy() when closing the application
	
    //the jedis pool configuration
    private static JedisPoolConfig buildPoolConfig() {
        final JedisPoolConfig poolConfig = new JedisPoolConfig();
        poolConfig.setMaxTotal(128);
        poolConfig.setMaxIdle(128);
        poolConfig.setMinIdle(16);
        poolConfig.setTestOnBorrow(true);
        poolConfig.setTestOnReturn(true);
        poolConfig.setTestWhileIdle(true);
        poolConfig.setMinEvictableIdleTimeMillis(60000);
        poolConfig.setTimeBetweenEvictionRunsMillis(30000);
        poolConfig.setNumTestsPerEvictionRun(3);
        poolConfig.setBlockWhenExhausted(true);
        return poolConfig;
    }
}
```

There are plenty more ways in which Jedis can be used. For example, you can use a JedisCluster instead of a Jedis object, which is something I am currently exploring. This will provide scalability and high availability. Note that some of your implementation will also depend on how your Redis server is set-up and what you want to do with the data you send it. 
<br>

Currently, I've got my Jedis client running in our QA environment and the pipeline works like a charm propagating messages all the way to Kibana. I'm looking forward to exploring more with Jedis! 



