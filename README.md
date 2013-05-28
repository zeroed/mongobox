# Mongobox

Mongobox is just an interface to [Mongodb](http://www.mongodb.org).

It works with a local installation of Mongodb or a cloud mongoservice [Mongolab](https://mongolab.com).

<i>Work in progress</i>

## Installation

Add this line to your application's Gemfile:

    gem 'mongobox'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongobox

## Usage

Create a `Box`

```ruby
box = Mongobox::Box.new({database_name: 'test'})
```

you can specify a different url and port under the `args[:ulr]` option if you want.
Still working on `args[:login],args[:password]` if you create a `Box` giving `(args = {...}, secure = true)`

### API

Currently working on basics features like...

```ruby
collections
collection(collection_name)
delete_collection
store(item)
...
find_all
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
