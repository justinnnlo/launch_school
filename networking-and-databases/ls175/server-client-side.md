Web development has many files. Some are executed on the client and others on the server side.

- Client side
  - Stylesheets (`.css`)
    - Interpreted by the browser to determine how to display the website
  - JavaScript (`.js`)
    - Code run in the browser to determine website interactions
  - HTML (`.html`)
    - Code that establishes the content and structure of the content
- Server side
  - Gemfile
    - Used by Bundler to manage dependencies
  - Ruby files (`.rb`)
    - Runs on the server while handling incoming requests
  - View templates (`.erb`)
    - Evaluated by the server to generate a response that will be sent to the client
    - It has some client-side code (e.g. HTML tags), but view templates are processed by the server before sending to the client
      - Note: there are some JavaScript applications that are client-side