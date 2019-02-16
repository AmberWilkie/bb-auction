

## Ideas for improvement

These ideas would improve the code base, but I chose not to implement them because of time considerations:
* _Concurrency issues._ If two people bid on a product at the same time, it will create potential problems with one overwriting the other. Temporary database locking would solve the issue in this simple app.
* _Testing_. I chose to test the `BidCreator` service but not other parts of the code. In a production application, acceptance testing and model specs would be required.
* _Managing bids_. Users should be able to manage the bids they have placed. Potentially they might cancel a bid.
* _Styling and UX_. I've added some basic styling but there is obviously a lot more to be done in terms of a pleasant user experience.
