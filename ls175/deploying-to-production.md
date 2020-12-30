1. Configue an app for deployment
  - Prevent the app from reloading in production with `require "sinatra/reloader if development?`, where `development` and `production` are methods provided by Sinatra
    - In Heroku, the environment variable is automatically set to `production`
  - Specify a Ruby version in `Gemfile`
  - Configue the application in `Gemfile` to use a production server
    ```ruby
    group :production do
      gem "puma"
    end
    ```
  - Create a `config.ru` file in the project's root to tell the server how to start the application
    ```ruby
    require "./book_viewer" # file to execute Sinatra
    run Sinatra::Application
    ```
  - Create a `Procfile` in the root to specify the processes that should be started when the app ¿is uploaded to Heroku or is called by an HTTP method?
    - Test locally with `heroku local`
2. Create a Heroku app
  - `heroku apps:create $NAME` creates a new Heroku app
    - $NAME can be omitted: can be automatically generated
  - `git push heroku main` to push it to Heroku
    - Note: Heroku only looks at the `main` branch