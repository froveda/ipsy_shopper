# Ipsy Shopper Coding Challenge


Create a [Ruby On Rails](http://rubyonrails.org) api-only application using:

```
rails new ipsy_shopper --api -O
```

I used the `-O` because I use [MongoDB](https://www.mongodb.com) and ActiveRecord is not necessary.

Considerations:
- Use [MongoID gem](https://github.com/mongodb/mongoid) as an ODM for MongoDB
- Use [RSpec](http://rspec.info/) with [FactoryGirl gem](https://github.com/thoughtbot/factory_girl) as the test framework
- Use [CarrierWave gem](https://github.com/carrierwaveuploader/carrierwave) for attachments