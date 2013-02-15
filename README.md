# WeThePeople

`we_the_people` is a gem to access the new [We The People](https://petitions.whitehouse.gov) petitions API.

# Quickstart

First, you'll need to configure your API key:

```ruby
WeThePeople.api_key = "1234abcd"
```

Now you're ready to start asking for resources.  Here are a few example calls:

```ruby
>> petition = WeThePeople::Resources::Petition.find("1234")
>> petition.body
# => "Example body"
>> petition.title
# => "My Example Petition"
>> petition.issues.first.name
# => "Civil Rights"

>> petitions = WeThePeople::Resources::Petition.all
>> petition2 = petitions.first
# Not yet implemented in the API (signatures)...
>> petition2.signatures.all.first.city
# => "Orlando"
```

# Configuration

You can configure a few options on the `WeThePeople` module:

* `api_key` - Required to make any calls; your We The People API key.
* `default_page_size` - The page size to request by default for all resources.
* `client` - If you don't want to use `rest-client` you can substitute in another HTTP client object that conforms to the same API here.
* `mock` - If set to "1", all requests will return mock results.

# Contributing

Hack some code, make a pull request.  I'll review it and merge it in!  Need some ideas as to where to get started?  Here are a few:

* Tests.  Please?
* Make resources be able to be related + associated.  It looks like responses may end up going this route.
* Documentationages.
