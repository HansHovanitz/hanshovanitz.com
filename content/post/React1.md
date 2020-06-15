+++
Categories = ["Development","React"]
Description = ""
Tags = ["Development","React", "JavaScript"]
date = "2020-06-15T13:53:49-07:00"
menu = "main"
title = "React – Building a Front End for my Mock Response Service "

+++

### -React: Building a Front End for my Mock Response Service-

<br>
![react](/images/react/react_title.jpg)
<br>

I do a lot of work with APIs. This involves sending a lot of JSON/XML requests and receiving JSON/XML responses. 
<br>

**Background:** 
When I want to test a system I am working on sometimes a downstream API is not available yet. In fact, this happens quite often. This is a great use case for mocking. However, mocking can require importing dependencies into your application and then code setup. I found myself running into situations where I needed to mock an external API response so often that I wanted to simplify the process. I ended up building a backend system that returns configurable JSON/XML responses. Just hit the API with something like this: https://myService.com/{key}/{id} and get the response that matches the provides key/id like this:
```javascript
{
    "hello": "world"
}
```
<br>

**Problem:**
In order to create the mock responses I’d have to carefully construct the data and then do some manipulation to get it ready for database insertion. I found that sometimes if I was in a hurry I’d forget to do things like escape the JSON text (as required by Couchbase). Also, as other colleagues began to use the service, I found myself having to spend time teaching how to use the tool and then manually correcting the database when mistakes were made. 
<br>

**Solution:**
What I needed was a way to enforce that the correct user input was gathered and then to take the tedious data manipulation work out of the equation. I deduced that a UI form would be perfect for the job. This would free up my time but the benefit would be amplified because it would free up the time of my colleagues as well. 
<br>

**Implementation:**
There are lots of great frameworks to help build a slick UI. Granted, I didn’t really need anything fancy – after all this tool is designed for be used internally and not public facing, but I was in the mood to learn something new. Enter `ReactJS`. I was instantly impressed with the ease of setting up a React application. Hello World was up and running in minutes. The anatomy of a React file felt pretty intuitive. I created my React component as a Class:
```javascript
class MockCreate extends Component {
    constructor(props) {
        super(props)
        this.state = {
            data: "",
            fields: {},
            errors: {}
        }
     }
…
```
<br>

And then added functions to do expected things like validation:
```javascript
    handleValidation() {
        let fields = this.state.fields;
        let errors = {};
        let formIsValid = true;
        //id required
        if (!fields["id"]) {
            formIsValid = false;
            errors["id"] = "ID Required";
            this.state.data = " Missing Required Fields"
        }
….....

        this.setState({errors: errors});
        return formIsValid;

    }
```
<br>

And eventually sent off a request to my existing mocking service:
```javascript
    createMockResponse = async init => {
        if (this.handleValidation()) {
            …

            //prepare the document for couchbase
…    
            let res = await http.mockCreate(mockUtils.getCreateURI(), document);
…
```
<br>

But in order to let a user to interact with this code comes, in my opinion, some of the real magic of `ReactJS`: The fact that .jsx files allow for embedded HTML:
```javascript
render() {
       return (
        <div style={{ backgroundColor: 'white', padding: 10 }}>
            <FormControl variant="filled">
…
…
```
<br>

Using `MaterialUI` for some styling I was able to create what a user sees within the render function. 
<br>

Within a button in the render function this line calls the “createMockResponse” function shown earlier:
```javascript
onClick={() => this.createMockResponse()
```
<br>

When the front end is running the user will see something like this:
<br>
![react](/images/react/view.jpg)
<br>

And that is pretty much it. There is of course more code to it and some use of utilities but I think the general feeling/flow is captured above. It is really straight forward to create a front end form using the power of `ReactJS`. I was trying to keep this from becoming too long-winded… and I think I’ve already failed, so you can find more in-depth documentation about terms and practices that I’ve mentioned here: [React](https://reactjs.org/docs/react-component.html). 
<br>

**Learnings:**

-Though React is declarative and component based, compared to other front end frameworks that I’ve used React felt closer to a “traditional” (OOP) experience. So if you are someone like me who has spent most of their time doing object oriented Java I think React is going to make more sense to you than something like `AngularJS`.
 
-The “state” object of a React component is both powerful and easy to use. It made gluing HTML elements to the function logic a breeze. 
 
-React was probably overkill for my needs, but it was a lot of fun! 