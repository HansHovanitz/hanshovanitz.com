+++
Categories = ["Development"]
Description = ""
Tags = ["Development"]
date = "2018-08-16T20:08:30-07:00"
menu = "main"
title = "Break"

+++

### -When Stuff Breaks-

I'm sure most engineers groan like I do when they see a **FAIL** message while tring to build or deploy something. 
<br>

This sort of of occurrence used to instill a borderline panic in me. Will I ever be able to fix this? What did I do wrong? Do I have a backup? (This was probably due to a little bit of computer science degree anxiety where not quickly figuring out how to fix something could be grade-defining -- and the fact I wasn't particularly confident at programming yet).
<br>

The aforementioned feelings are why I decided to make this post. Not only was there no panic, but I was able to fix the problem relatively quickly in a step-by-step manner. I credit this to some real world experience as a software developer. In my current position I regularly encounter a variety of problems/errors/etc. The lesson I have learned is that being nervous and having self-doubt is like a rocking chair -- it gives you something to do but doesn't get you anywhere (I didn't think I'd ever get to use a line I heard in Van Wilder anywhere...ever). Just start trying to solve the problem, ask for help if you need to, and when step 1 is done move on to step 2. 
<br>

I have this `Hugo`-powered blogsite hosted on `AWS S3`. Deployment is simplified by `wercker`. As soon as a git commit hits the **[repo](https://github.com/HansHovanitz/hanshovanitz.com)** wercker kicks off a deployment to S3. From the commit to live on hanshovanitz.com usually takes less than a minute. So after adding my Kafka blog I checked the site ~5 minutes after committing. Nothing was there! Unusual. I checked AWS and the new work wasn't there. The work was on GitHub though. So I deduced that it must be something to do with wercker. 
<br>

Sure enough, this message greeted me when I logged into wercker:
![Pic1](/images/break/break_01.JPG)

<br>
Further analysis pointed to this section of the logs:

```
Running the Hugo command
/pipeline/hugo-build-b6ae2dc0-35b7-444b-9ca6-bf6ba782a661/hugo --source=/pipeline/source/ --buildDrafts=false --theme=hugo-uno
/pipeline/hugo-build-b6ae2dc0-35b7-444b-9ca6-bf6ba782a661/run.sh: line 40: /pipeline/hugo-build-b6ae2dc0-35b7-444b-9ca6-bf6ba782a661/hugo: No such file or directory
```

So maybe it's not an issue with wercker but with Hugo. I had just expected everything to work as usual so I committed the new blog without testing it locally first (there is a lesson here!). It's been a while since I set up Hugo and selected the `hugo-uno` theme. Maybe it isn't compatible with the newer versions of Hugo? Embarrassingly, it had been half a year since I last posted, which is plenty of time for things to become outdated. I tried to build the project locally and it failed with a similar error message to what wercker was giving. So I went and found a newer version of the hugo-uno theme. 
<br>

After hooking up the new hugo-uno theme version the project now built and worked fine locally. Great Success! But then the project again failed during the wercker step of the deployment flow. Hrm. I inspected the wercker.yml file responsible for kicking off the moving of things to AWS. After a little Googling it was revealed that I was several versions behind on the Hugo version I was instructing wercker to build with. It made sense that the project built locally because my local Hugo version is fairly new as this is a newer computer. Hugo has moved forward many versions since I first setup this project on an old computer with an older Hugo version. 

```
box: golang
build:
  steps:
    - arjen/hugo-build:
        version: "0.46"
        theme: hugo-uno
        flags: --buildDrafts=false
deploy:
    steps:
    - s3sync:
        source_dir: public/
        delete-removed: true
        bucket-url: $AWS_BUCKET_URL
        key-id: $AWS_ACCESS_KEY_ID
        key-secret: $AWS_SECRET_ACCESS_KEY
```

After updating the version I was given the greenlight on wercker:
![wercker_success](/images/break/break_02.JPG)

<br>
This may not seem like a hugely complicated problem. Indeed it wasn't. But my point is that a few years ago when I was 3/4 done with my CS degree this might have been a big anxiety-inducing problem for me. I'd glad I've been able to progress as an engineer and a problem solver. I cannot wait to see where I am in a few more years time! 

