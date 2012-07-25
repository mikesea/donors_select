#DonorsSelect

#The Problem
DonorsChoose has thousands of interesting projects. However the search for projects is cumbersome and clunky for potential donors. DonorsChoose's project finder does not optimize the searching process and is leaving money on the table.

#The Solution
DonorsSelect reimagines the DonorsChoose project discovery experience in a single-page application. Users can filter projects by state, subject, and grade. At each step of the filtration process, a recommended project is available. Users can also browse projects based on their filter criteria. The simplicity and straighforwardness of DonorsSelect is a winning choice for DonorsChoose and will increase participation and donations.

#Running Locally
DonorsSelect uses Redis and Resque to cache project data for quicker load times. To run the application locally, follow these steps:

1. Clone and bundle the app:
```
$ git clone git@github.com:mikesea/donors_select.git
$ cd donors_select
$ bundle
```

2. Create an initializer file inside the <code>config/initializers</code> called <code>pusher.rb</code>. This file should contain your [Pusher](http://pusher.com) account credentials. Here's an example:
```
Pusher.app_id = 'your-pusher-app-id'
Pusher.key = 'your-pusher-key'
Pusher.secret = 'your-pusher-secret'
```

3. Start Redis. If you're on a Mac, and you've installed Redis via Homebrew, run:
```
$ redis-server /usr/local/etc/redis.conf 
```

4. Start the Resque workers:
```
$ QUEUE=* rake environment resque:work VERBOSE=true
```

5. Start the server:
```
$ bundle exec thin start
```

#Tests

To run the tests, after cloning the repo, simply run:
```
$ rake spec
```

#That's it!
We hope you enjoy DonorsSelect!

