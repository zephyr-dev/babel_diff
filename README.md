# BabelDiff

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'babel_diff'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install babel_diff

## Usage

```ruby
BabelDiff.run
```

Running the above command from the Rails console will create two files, "phrases.en.additions.yml" and "phrases.en.updates.yml", in your locales directory.

These files will contain all added and updated translation keys, respectively. If this is your first time running BabelDiff, the additions file will contain all of your translation keys.

The file "phrases.en.previous_version.yml" will also be created to serve as the benchmark against which future diffs will be compared.

If you want to run BabelDiff on a different locale file, you can pass it to the "#run" method. The default file path is "config/locales/phrases.en.yml".

The following code:

```ruby
BabelDiff.run("config/locales/random_folder/phrases.fr.yml")
```

would produce the following files:

Additions        => config/locales/random_folder/phrases.additions.fr.yml 
Updates          => config/locales/random_folder/phrases.updates.fr.yml 
Previous Version => config/locales/random_folder/phrases.previous_version.fr.yml 
