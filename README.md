# Example of DRb serving distributed objects on network

DRb service example 

Server generates random prices and fakes a pub / sub system for clients to subscribe.
Clients connect to the server, subscribe to pub / sub and print lower and higher values based on preferences.

This code example goes along with a blog post on [Synbioz blog](http://www.synbioz.com/blog) which explains what is [DRb](http://ruby-doc.org/stdlib-2.2.0/libdoc/drb/rdoc/DRb.html) and how to use it.

To run the example it's easy as doing:

```bash
$ ruby server.rb
$ ruby  client.rb
```

You should see prices displayed in the server window every one second:

```
Server running at druby://localhost:4000.
Press Ctrl-C to exit.
Current price: 658.2826350050323
Current price: 605.6441756083915
Current price: 572.0022666250939
```


And things like this in the client window:

```
Price below 600: 599.4422758787825
Price below 600: 505.2421950784502
Price above 700: 721.0054761980296
Price above 700: 705.4535746533276
```
