# AngularJS demo

* Quick note about asset compilation - 
I used [LiveReload](http://livereload.com/) when developing this demo. It watches the file system for changes and compiles coffee / scss and reloads the browser automatically. If you don't have it / don't want to pay $10 for it, then you can just start by editing `build/demo.js` in stead of `src/demo.coffee`. Just be wary of this getting overwritten if you ever do decide to use LiveReload.

#### TL;DR
- Fork and clone this repo
- Navigate to `file://path/to/index.html` in a web browser
- Get acquainted with how the app is supposed to work
- Navigate to `file://path/to/demo.html` in a web browser
- Open `demo.html` and `src/demo.coffee` and start coding

#### The annotated source for `src/application.coffee`

…lives in `docs/application.html`. Open this in a browser and have a look if you want a quick detailed overview of the javascript that drives this app.

#### About the files

```
index.html             # All markup for the full working application.
demo.html              # A blank starting place for coding the demo yourself. START CODING HERE.

src                    # Editable source files here
| application.coffee     # This is the full working, annotated source for the meat of the application.
| application.scss       # Styles for both the Demo and the working version
| demo.coffee            # A blank starting place for coding the demo yourself. START CODING HERE.
| local-storage.coffee   # The low-level adapter for storing things in local storage
| task.coffee            # The "Model" object for task persistence.

build                  # Where the files are sourced in the HTML. My LiveReload builds to this dir.
  | ...

lib                    # Dependencies (angularjs, underscorejs, normalize css, zurb foundation css)
  | ...
```

- While `src/local-storage.coffee` and `src/task.coffee` are important to this particular app, they don't bear any direct relevance to learning AngularJS. Other than knowing the API methods in `src/task.coffee`, you can safely ignore both of these files.
- `src/task.coffee` expects you to have already defined `App = angular.module('App', [])` before it is loaded, so just be aware of this.
