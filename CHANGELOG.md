# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## "New beginnings" [2.1.0] - 2020-07-18
- Improved New-journey form with DOM manipulation
### Commit Messages
- update gems
- update yarn packages
- begin implementing javascript on new journey
- begin to scaffold out new traveler-option select system in new journey form
- improved new-journey-form with JS and simplified options
- updated README

## "PHD (PostgreSQL, Heroku, and Deploy)" [2.0.0] - 2020-02-24
- Cleanup old omniauth functionality made to satisfy project requirements
- Convert database to PostgreSQL for Heroku deployment
### Commit Messages
- changes to repo link in about; test youtube in readme
- remove video demo link by thumbnail
- prepare converting database to PostgreSQL
- disable and hide omniauth functionality
- test adding rake as gem
- disable omniauth initializer
- update nokogiri dependency
- reformat item choice radio buttons in new journey

## [1.3.1] - 2020-01-08
- Merged "Moderator" and "Memories" into Master
- some cleanup work
### Commit messages
- allowed moderator to read from external list and refactored it as a class
- testing that all resources update and flag as expected
- fixed duplicate links
- updated README, credit to chris fritz
- let users know about cookie requirement on home page
- updated bad_words
- Bump rack from 2.0.7 to 2.0.8
- Merge pull request #2 from khongcodes2/dependabot/bundler/rack-2.0.8
- adjusted layout, memories
- adjusted layout, admin panel
- added descriptions for seeds
- double checked admin functions, light refactoring, added seeds
- commented out test flags in seeds file
- Merge branch 'moderator'; finished implementation of moderator and memories features
- Merge branch 'master' of https://github.com/khongcodes2/Wandering
- updated puma in Gemfile
- update yarn
- transfer notes into dev_notes
- updated Changelog
- updated README with screenshots

## "Moderator" [1.3.0] - 2019-12-09
### Commit messages
- add admin column to users, create admin in seeds
- added flag to all tables
- implement show flag message
- created moderated module and admin attribute to users
- added moderated module to journeys, spaces, travelers, users
- added permissions error page, added scope 'flagged' to resources
- admin can edit users
- started implementing admin modification
- bugfix admin modify travelers
- change journey names named after traveler on traveler name change
- begin implemenitng update spaces, provide cases in memory_text for if resourcs deleted
- can delete spaces as admin
- automatically redirect to admin panel if login as admin, change navbar admin link
- made modular flagged sections for admin control panel
- admin functions work
- created partial delete for seeds, to allow for users to persist when reseeding occurs
- organized obj_info in flagged section
- pre-push notes cleanup
- updated Changelog

## "Memories" [1.2.0] - 2019-12-03
### Commit messages
- started implementing memories model
- started creating controller for text display
- implemented changing text based on read location and mem_type
- wrote memory text helpers
- item_pickup and item_drop mem_types functioning
- item_discover mem_type functioning
- traveler_leave mem_type functioning and began experimenting with spectral as webfont
- space_discovery mem_type functioning
- begin mem_type functioning
- end mem_type functioning - memories functioning and visible in show pages
- journey#index shows most recent journeys on top
- added some desert seeds, commented out
- added minor changes to text to create more immersrive experience, improvements to readability in design
- partitioned the css file
- eliminated space_journeys, replaced with memories
- moved end_journey actions off view template and into after_action filter
- reverted to using space_memories, to keep collection semi-independent from memories due to different points in time the memories should be instantiated


## [1.1.1] - 2019-11-24
### Commit messages
- minor changes to seeds amount
- once enter wrapup, stay in wrapup (fixed bug allowing user to leave wrapup)
- some styling for ease of readability in journeys controller
- documented descriptions for helpers, made some css changes, fixed one seed
- updated Changelog

## [1.1.0] - 2019-11-21
### Commit messages
- added seeds, DRYed code slightly, fixed omniauth
- further DRYed code
- added flavor and navigation to journeys index
- resolved bug where drop to last space in journey's collection by space id; moved drop functionality to ItemsHelper
- fixed some seeds
- updated Changelog


## [1.0.0] - 2019-11-13
### Commit messages
