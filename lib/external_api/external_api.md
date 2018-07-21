Hi,

this directory is outside the main project for a reason.

In a lot of cases there are libraries which wrap the raw apis.
You don't want to write functions which call the raw urls
in your business logic directly. It distracts from the main
gist of a module.

If you consume an external api and there's no hex package,
write an api wrapper an put it here
