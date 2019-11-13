# Wandering

## About

Wandering is a short, little game that relies on its persistent database to allow users (players) to create travelers to explore and wander through procedurally generated spaces and paths. Along the way, the traveler can pick up and drop items as their curiosity demands. 

At the end of the journey, players are invited to add to the story of this world by describing either a new space or item they discover.

Changes in item locations caused by travelers' actions are persisted in the spaces saved to the databases. New items and spaces are also persisted in the database. The connections between spaces are not persisted - each time a traveler journeys through a region, they will find that spaces are linked in new ways, and spaces reached in a previous journey may not be reachable - though new ones will be.

The clock ticks down as travelers move from space to space. The more spaces the traveler passes through, the more time has passed since the journey has begun, and the more likely it is for the traveler to have to return to the Ether, where all travelers come from, and where they must all return.

#### Media touchstones:

  Video games:
  - Caves of Qud
  - Journey
  - NieR: Automata

  Tabletop games:
  - Fall of Magic by Heart of the Deernicorn
  - Alone Among the Stars by Takuma Okada

  Books:
  - Stages of Rot by Linnaea Sterte
  - That poem about Ozymandias

## Instructions

To begin, run
$ bundle install
$ rails db:migrate
$ rails db:seed

The seed file contains hashes and arrays of strings describing items and spaces. When you run seed, you are generating these items and spaces! Please make sure to do this or else the database will not be populated and you will not be able to travel through spaces, and the project will not run as intended.

This file heavily uses a cookie - please enable cookies on this site.

This web application was built on Ruby-2.6.1 with Rails 6.0.1.

## Contributing

  Bug reports and pull requests are welcome on GitHub at https://github.com/khongcodes2/Wandering

## Authors

    Kevin Hong - https://github.com/khongcodes2/