+++
Categories = ["Development","C#"]
Description = ""
Tags = ["Development","C#"]
date = "2020-01-20T10:38:57-07:00"
menu = "main"
title = "C#: How fast can I get going?"

+++

### -C#: How fast can I get going?-

<br>
![spring](/images/cSharp/csharp-featured.png)
<br>

A friend of mine is working on learning some coding. He's learning with `C#` and using Microsoft Visual Studio for an IDE. 
This seems like a reasonable place to start. He had a bunch of coding 101-type questions and I figured this would be a good
chance to recement a few of the basics. Many engineers probably take knowledge like "what is an object" or "what is a class variable" for granted. I'm of the belief that one can demonstrate their understanding of a programming concepts 
by successfully teaching it to someone else. 
<br>
So, I thought I'd create a very simple C# program to show my friend a few of the 
basics regarding classes. I could see several benefits in doing this:

1. Prove that I could teach someone else what I know (and learn valuable lessons about how to structure future knowledge sharing sessions)
2. Practice some technical writing -- it's important to be able to explain things to someone in written form and actually have them understand
3. The main impetus of this exercise: Challenge myself to see how fast I could get up and running with a new programming language
<br>

I had written a little bit of C# code many years ago in one of my Computer Science courses but that is about it. I wanted to see
how quickly I could get going with C# and write a program to demonstrate a few programming basics (only slightly more advanced than "Hello World" in the scheme of things, but I was mostly aiming to complete something within an hour). Here is what I did in about an hour:
<br>


Followed Microsoft's "Get Started" _**[Guide](https://docs.microsoft.com/en-us/dotnet/core/tutorials/with-visual-studio-code)**_.
<br>

Pain point: The command ```dotnet new console``` didn't work in VSCode. 
Solution: Rebooted computer -- apparently the environmental path didn't get updated/linked properly to VSCode after installing the .NET Core SDK. 
<br>

Once the pre-requsites were set up I initialized a C# project. I like how doing this automatically generates a "Hello World" program for you as a starting point.
<br>

I was able to quickly set up a sample class (House class) and then in the Program class create a few
house objects to show how they can be operated on, the difference between static class variables and instance
variables, etc. 
<br>

The part that took the longest was actually typing up a README.md and writing explanations. Next longest 
was getting my local environment set up and troubleshooting a few issues. Writing C# code felt very similar to other OOP languages like `Java`. There are of course some differences but for someone
familiar with Java C# seems easy to pick up.
<br>

Here's a link to the _**[Code](https://github.com/HansHovanitz/CSharpExperiment)**_.

