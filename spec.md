MIN VIABLE PRODUCT REQUIREMENTS
 
[v] include one has_many
      - Region    has_many Spaces
      - Region    has_many Journeys
      - Space     has_many Items
      - Traveler  has_many Journeys
      - User      has_many Travelers

[v] include one belongs_to
      - Journey belongs_to Travler
      - Journey belongs_to Region
      - Space   belongs_to Region

[v] include 2 has_many :through
      - Item      has_many Travelers through Journeys
      - Item      has_many Users through Travelers
      - Traveler  has_many Items through Journeys
      - User      has_many Journeys through Travelers
      - User      has_many Items through Journeys

[v] include many-to-many :through
      - Items   <-> ItemJourneys  <-> Journeys
      - Spaces  <-> SpaceJourneys <-> Journeys

[v] some validations
      - User      validates username and password
      - Item      validates noun and adjective
      - Space     validates noun and adjective and description
      - Traveler  validates name and descript

[v] display errors
      - divs for displaying errors

[v] ActiveRecord scope method
      - Items.starting_three gets 3 random items not associated with a space to select from on new Journey form
      - Travelers.no_user gets all travelers with no users for free use for users who are not logged in, creating journeys

[v] User authentication
      - bcrypt

[v] Omniauth
      - User can log in with Twitter credentials

[v] Nested resource - RESTful URLs (JOURNEY - pick region?)
      - Spaces nested in Regions

[v] Nested forms
      - New Traveler can be created from New Journey

  [v] Nested new route with form that relates to parent resource
      - New form for Spaces nested in Regions

  [v] Include nested index or show route
      - Spaces nested in Regions

[v] DRY
   => Logic in controllers should be model methods
   => Views should use helpers and partials when appropriate
   => Follow Rails Style Guide
      - Separation of concerns - didn't use any model class methods in views
      - DRY - used a lot of partials
      - All the session concerns is handled by controllers except for what's in classes

[v] Don’t scaffold
      - Didn't scaffold