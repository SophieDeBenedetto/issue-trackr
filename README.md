# Issue Trackr

A Rails app that allows users to log in through GitHub and add their repositories for issue tracking. The app will pull in any existing issues and add a webhook to the repo, listenting for an issue-based events. The app receives a payload from GitHub when a new issue is opened, or an issue is updated, on one of the user's added repos. The user will then receive a text message and email alert. Users can also browse their issues or view individual issues. 

## Why Did I Build This?

This app was developed to demo some Rails refactoring best practices and design patterns. Communications between the app and the GitHub and Twilio APIs are handles by adapters; updating issues from webhook payloads are hanlded by service objects; various other services are implemented, as well as decorators to handle presentation logic. 

You can view a live demo of the app [here](http://issue-trackr.herokuapp.com/), and you can check out my series of blog posts on Rails refactoring and design patterns for beginners [here](http://www.thegreatcodeadventure.com/rails-refactoring-part-i-the-adapter-pattern/), [here](https://thegreatcodeadventure.com/rails-refactoring-part-ii-services) and [here](https://thegreatcodeadventure.com/rails-refactoring-part-ii-the-decorator-pattern).
