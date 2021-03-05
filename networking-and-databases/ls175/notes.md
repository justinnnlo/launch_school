# Sinatra and web frameworks

Sinatra is a Rack-based web development framework. Frameworks come with a lot of out-of-the-box tools that make our work easier by abstracting a lot of complexity.

[Note: is it a framework or DSL? The Sinatra book says no, it's a DSL.]

At its core, Sinatra abstracts Rack and makes it easier to handle HTTP requests with routes without having to worry of the underlying plumbing. *The extension is that Sinatra doesn't respond to anything we don't tell it to.*

But keep in mind that at their core a web development framework like Sintatra helps us conenct to a TCP server and make HTTP requests.

At its code it doesn't assume much about the application apart that:
1. It will be written in Ruby
2. It will have URLs

## Sinatra structure

Sinatra ties a specific URLs (routes) to Ruby code that is executed when a request is made to that URL. A request returns the text produced by the code. This enables us to separate views from application code.

## Routing

Sinatra allows us to route according to HTTP requests. For example, just as we do `get "/" do end` we can do `post "/" do end` or `put "/" do end`.

## Rack

WEBrick is a web server that comes with Ruby, but it's cumbersome to use. Rack is a library that helps us connect to WEBrick for us.

**What is a web server? Are there different types of web servers?**

Rack is a **generic inteface to connect to web servers**. Thus, Rack helps us replace our TCP Server objects (as used in the echo exercise) with WEBrick and the Ruby code with a Rack application.

### TCP and Sockets

The Ruby `socket` library provides the `TCPSocket` class to use socket APIs more easily. An API (Application Programming Interface) is a collection of programs that an application can use to access other components of the operating system. Thus, a socket API allows applications to more easily use sockets.


### What is Rack?

Rak is a web server interface that provides an API to create web applications. Rack-based frameworks include Sinatra and Ruby on Rails.

In a sense, rack is a protocol or specification because it establishes the guidelines for the server and application to talk to each other.

For example, Rack specifies:
- That the server convert the HTTP request to a Ruby hash which is sent to the app
- The app uses this hash and returns information to the server in a 3 element array (HTTP status code, hash of HTTP headers, response body)
- The server takes the array and converts it into an HTTP response it sends to the browser (client)

Rack allows us to support multiple web servers. The problem before Rack was that connection and communicating with the web wasn't very abstracted.

### From Ruby code to Rack

1. Create a "rackup" file: a configuration that specifies what and how to run
  - By default Rack expects the rackup file to be `config.ru`
  - However, rackup files can have other names as long as they use the `.ru` extension
2. The rack application used in the rackup file must be a Ruby object that responds to `call(env)` method
  - `call(env)` takes one arguments — the application's environment variables
  - `call(env)` always returns a 3 element array containing
    1. Status code
    2. Response headers
    3. Response body

## Sinatra and routes

Sinatra makes it easy to write Ruby code for when someone visits a particular URL.

Sinatra provides a DSL to define routes. **Routes are how a developer maps a URL pattern to a ruby code.** In the code below, `get "/" do` defines a route that matches to the path `"/"`. A user that visits that path will view the code returned by that path.

```ruby
require "sinatra"                   # Use Sinatra framework
require "sinatra/reloader"          # Reload the application's files every time we load the page

get "/" do                          # Match the path "/"
  File.read "public/template.html"  # Ruby code to run at this path and send to the browser
end
```

**Anomaly**: a path seems to execute only the last line of code. Is it because the path returns the last line that's executed? Seems like it.

## Rendering templates

We can make dynamic applications by creating templates and having Sinatra render them with content.

Templates are text files that are converted to HTML before being sent to the browser as the response. A templating language defines how a template is converted to HTML and how to embed dynamic values.

In Sinatra, templates live in the `views` directory.

Embedded ruby (`ERB`) is a templating language. It embeds Ruby code into another file.

A dynamic value in ERB is `<h1><%= @title %></h1>`. When the template is rendered the value for `@title` with replace the ERB tag `<%= @title %>`. If `@title == "Book Viewer"` then that would render as `<h1>Book viewer</h1>` (note: HTML doesn't use quotes around strings).

ERB is written in `.erb` files. We can include any Ruby code in ERB files by placing them between `<%` and `%>`. To display a value (as above), we need the special opening ERB tag `<=%` — though the closing tag remains `%>` whether we're displaying a value or not.

To use ERB in Sinatra we need to include the gem `"tilt/erubis"`. `tilt` is an interface used in many Ruby templating languages to make templeting as generic as possible.

Sinatra will serve any files placed in a `public` directory that lives in the same directory as the Sinatra application.

### Helpful gems

- `"sinatra"`: includes Sinatra
- `"sinatra/reloader"` helps us reload a file with different content without having to restart the server
- `"tilt/erubis"`: renders much faster than built-in ERB, plus other services

## Layouts

Sinatra has templates, which allow us to more easily create an HTML document based on our code.

But as templates can reuse between themselves a lot of code Sinatra also has the concept of a layout. A layout is a template that wraps around other templates. This means that the shared HTML code is typically put on a layout and the specific nuances are put in the templates.

For example, let's say we had a simple page that asks if its your birthday and a reply. It would look like:

```erb
<html>
  <head>
    <title>Is it your birthday?</title>
  </head>
  <body>
    <%= yield %>
  </body>
</html>
```

Where `<%= yield %>` injects the template code we'll use. `yield` is a keyword used in layouts to tell the view template content where to go.

To specify what layout and templates to use, we can define that in the route:

```ruby
get "/" do
  erb :index, layout :post
end
```

In this example, at path `"/"` Sinatra will use the `post.erb` layout in the `views` directory and the `index.erb` template. If no layout is used, Sinatra by default uses the `layout.erb` file in the `views` directory.

## Route parameters

To avoid duplication when creating a route for each chapter we can use route parameters to create a single route that handles route creation for all chapters.

This requires using a route parameter in the route URL:

```ruby
get "/chapters/:number" do end
```

Values passed to the application through the URL will appear in the `params` hash that's automatically made available in routes.

## Before and after filters

Some actions will be done in every HTTP request. For example, on Facebook one of them will be checking if the user is logged in. In our book viewer, it's getting the contents of the table of contents.

Instead of define it in each route, we can define it in the `before` and `after` filters.

A `before` filter is defined with `before do end`. `before` filters execute before the routes, so we can use their results in specific routes. The instance variables defined in the `before` filter are accessible to all the routes. Inversely, the `after` filter is executed after each route gets processed (e.g., useful to disconnect after a request).

## View helpers

View helpers are methods available in templates to filter or process data, or perform another functionality. View helpers are made available through Sinatra.

Helpers are defined in a `helpers` block in a Sinatra application:

```ruby
helpers do
  def slugify(text)
    text.downcase.gsub(/\s+/, "-").gsub(/[^\w-]/, "")
  end
end
```

Which, when called:
```html
<a href="/articles/<%= slugify(@title) %>"><%= @title %></a>
```

Renders the expected output:
```html
<a href="/articles/today-is-the-day">Today is the Day</a>
```

**To confirm: view helpers are available in the `.erb` files in the `views` directory?**

## Redirecting

Sinatra handles requests for paths it doesn't have routes for by displaying an error page ("Sinatra doesn't know this ditty.").

It also has a special route called `not_found`. This route is created through `not found do end`. This route is used to create custom 404 Not Found pages.

Routes can also redirect the browser (ie, send it to a different URL) rather than returning HTML. This is done with the `redirect` method, such as:

```ruby
not_found do
  redirect "/"
end
```

Which redirects paths that aren't found to the home page.

## Search

Besides extracting data from the URL we can also get data from the `params` hash from:
1. Query parameters in the URL
2. POST requests

A POST request with an HTML form works by:
- Inputting text in the HTML form
- When the form is submitted the browser makes an HTTP request
- The request is made to the path or URL specified in the`action` attribute of the `form` element
- The `form` element's `method` attribute determines the type of HTTP method
- The `form` `input` elements will be sent as aparameters
  - Keys: determined by the `input` element's `name` attribute

## WEBrick

WEBrick is a standard Ruby library that comes with Ruby. This library specifies a default web server called WEBrick. As it comes with Ruby, WEBrick is the most common web server used.

WEBrick has a limitation: it was not designed to **handle a high concurrent workload that a Ruby app must serve in production**. This is why Heroku strongly recommends you don't use WEBrick for production. It recommends to use Puma instead, which is a multi-process multi-threaded server.

# Securing applications

Sinatra is a simpler framework than other like Ruby on Rails. This has the benefit of a smaller learning curve to understand how it works but the downside of having less functionalities.

One of the functionalities that Sinatra lacks is escaping HTML to prevent cross-site scripting attacks.

## HTML and safety

An app is only as safe as the code that is running in the browser whe nsomeone uses it. It'll primarily be HTML, CSS and JS, alongside 3rd party libraries like jQuery and analytics packages.

For example, the following code is a JS script followed by a valid HTML input:
```html
<script>alert("This code was injected!");</script>Pizza
```
The first part, `<script>alert("This code was injected!");</script>` executes an alert. The second part is an HTML text that says `Pizza`. When inserted into a form, this can create unintended behaviors in the page (like running unintended alerts).

Scripts like the above can potentially affect millions. This has to do with the fact that an HTML input can be used to place content in the production application. For example, if the code looks like:
```html
<h3><%= todo[:name] %></h3>
```
Where `<%= todo[:name] %>` inserts an HTML form input. If the input is `Pizza`, then it'd be:
```html
<h3>Pizza</h3>
```
But if the input is `<script>alert("This code was injected!");</script>Pizza`, then the resulting HTML code would be:
```html
<h3><script>alert("This code was injected!");</script>Pizza</h3>
```
Thus, this is an example of how we could write potentially malicious code to a page. Note that if this code is shown to many people, e.g. a social media post, it could affect more than one person.

## Escaping HTML

The solution is to escape HTML. This means replacing HTML characters with something called HTML entities, which are a standerdized combination of characters. Browsers won't interpret HTML entities as code. Characters that need to be escaped include: quotes, greater or less than operators, and more.

The `Rack` library has a built-in method called `Rack::Utils.escape_html` that provides this service. For example:
```
>> Rack::Utils.escape_html %{<script>alert("This code was injected!");</script>Pizza}
=> "&lt;script&gt;alert(&quot;This code was injected!&quot;);&lt;&#x2F;script&gt;Pizza"
```
Note that the `<script>` tag was replaced by `&lt;script&gt;`. That is, `<` is replaced by `&lt;` and `>` is replaced by `&gt;`. By extension, the resulting `&lt;script&gt;` isn't a JavaScript `<script>` tag — to the browser, it's an arbitrary sequence of characters.

### Using helper methods

The built-in Rack method is a bit long: `Rack::Utils.escape_html`. We can create a more convenient and readable helper method, like:
```ruby
helpers do
  def sanitize(content)
    Rack::Utils.escape_html(content)
  end
end
```
Which can be used in a template like:
```html
<h3><%= sanitize todo[:name] %></h3>
```
Thereby escaping the value of `todo[:name]`.

## Escaping inputs by default

The problem with the above approach is that it doesn't automatically escape all HTML inputs. Thus, if we forget to sanitize a specific input it could compromise the app.

Many libraries solve this by optionally allowing all HTML inputs to be escaped so developers don't have to manually do it. In Sinatra, this is done via:

```ruby
configure do
  set :erb, :escape_html => true
end
```

The caveat is that this automatically escapes all outputs (including Ruby outputs which do not originate from HTML inputs). This requires disabling auto-escaping in some circumstances. This can be done by replacing `<%=` (which escapes by default when it's enabled) with `<%==`.

# Handling bad input

Sometimes a user can send a bad input. For example, he might go to a URL that doesn't exist. In some of those cases we may want to redirect them — especially if it causes the page to behave unexpectedly.