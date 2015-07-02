# The Active Admin Store

Demo application demonstrates new event on ActiveAdmin.modal_dialog.
Issue #3991


# Start local

```
$ git clone https://github.com/workgena/demo.activeadmin.info.git
$ cd demo.activeadmin.info
$ git checkout modal_dialog
$ bundle install

$ bundle exec rake db:setup

$ bundle exec rails s
```

In your browser go to http://localhost:3000/admin

And open DevTools -> Console

And you will se two log-messages from listening events

https://github.com/workgena/demo.activeadmin.info/blob/modal_dialog/app/assets/javascripts/active_admin.js.coffee
