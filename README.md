#DonorsSelect

#The Problem
DonorsChoose has thousands of interesting projects. However the search for projects is cumbersome and clunky for potential donors. DonorsChoose's project finder does not optimize the searching process and is leaving money on the table.

#The Solution
DonorsSelect reimagines the DonorsChoose project discovery experience in a single-page application. Users can filter projects by state, subject, and grade. At each step of the filtration process, a recommended project is available. Users can also browse projects based on their filter criteria. The simplicity and straighforwardness of DonorsSelect is a winning choice for DonorsChoose and will increase participation and donations.

#Running Locally
DonorsSelect uses Redis and Resque to cache project data for quicker load times. To run the application locally, follow these steps:

1. <code>git clone git@github.com:mikesea/donors_select.git</code>
2. <code>bundle</code> and start the server with <code>bundle exec thin start</code>
3. start redis with <code>redis-server /usr/local/etc/redis.conf</code>
4. start the resque job with <code>QUEUE=* rake environment resque:work VERBOSE=true</code>

#Tests
To run the tests, after cloning the repo, simply run:
```
$ rake spec
```

#That's it!
We hope you enjoy DonorsSelect!

