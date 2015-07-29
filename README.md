# CooRIDEinate - A ride coordination app
Make sure that everyone within an organiztion has a ride for off campus events.

#Github Repo
https://github.com/benjaminmeyer/ride-coordination-app

#Installing and using application
The project requires Ruby on Rails, MySQL, and Apache with Passenger to be installed
and configured. The server is currently running Ubuntu. The program expects a database
named "mass_carpool_db" with a user named "db_user" and a password of "password". To install
the database, run "rake db:migrate" within the project folder.

#Known issues, bugs and limitations
Currently cannot undo creation of event, organization, or signup.

Sign-up algorithm only checks if there is a ride available. It does not take into account who is 
driving, how many people are driving, or how many people are signed up.

Cannot recover a password.

Signup on rides is not limited. A person can sign up to ride or drive more than once on a single event.
Users can still sign up on a ride even when the max number of passengers has been reached.

Users currently cannot search or sort events or organizations.

Users cannot see who else is part of an organization.

Joining an organization is not restricted. Any user can join any organization.
