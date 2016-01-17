# Recipes App

A noob attempt at a CRUD app in Ruby using Sinatra and Slim.

From the root in cmd, run:
  shotgun -I lib app.rb

Go to localhost:9393 in a browser


To share to other machines on the network specify the wildcard 0.0.0.0 to allow access from any machine:

  shotgun -I lib app.rb -o 0.0.0.0
