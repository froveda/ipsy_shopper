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

## Models
### Song
This class represents a song in the application. It has the following fields:

- name (String)
- duration (Integer): Duration of the song. It is expressed in seconds. Default value: `0`
- genre (String)

Also, a Song can be `featured`:

- featured (Boolean): Default value `false`

and if it is `featured`, the following fields can be retrieven:

- here (Image)
- description (String)

Since a song can change its `featured` value after being created, I prefer to add it as a boolean field in the model instead of creating a new model `Song::Featured`. This way, the boolean field can be changed easily, avoiding to change the instace class type.

Associations:
- Belongs to Album
- Belongs to Playlist

### Album
This class represents an Album in the application. It has the following fields:
- name (String)
- art (Image)

Associations:
- Has many Songs
- Belongs to Artist

### Artist
This class represents an Artist in the application. It has the following fields:
- name (String)
- bio (String)

Associations:
- Has many albums

### Playlist
This class represents a Playlist in the application. It has the following fields:
- name (String)

Associations:
- Has many songs