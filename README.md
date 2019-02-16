

## Ideas for improvement

These ideas would improve the code base, but I chose not to implement them because of time considerations:
* _Concurrency issues._ If two people bid on a product at the same time, it will create potential problems with one overwriting the other. Temporary database locking would solve the issue in this simple app.
* _Partials_. Using partials would reduce code complexity in the views and allow for more flexibility in design.
* _Testing_. I chose to test the `BidCreator` service but not other parts of the code. In a production application, acceptance testing and model specs would be required.
