## Setup
On Mac
======
- `xcode-select --install` #Install XCode Command line tools 
- Install (homebrew)[https://brew.sh/]
- `brew install rbenv` #Install rbenv

On Linux
========
- yum / apt install rbenv?

General Instructions
====================
- `CD to the project directory`
- `eval "$(rbenv init -)"`
- `rbenv install 2.6.8` # Install ruby
- `rbenv local 2.6.8` # Switch to Ruby Version 2.6.8
- `rbenv rehash`
- `gem install bundle`
- `bundle install`

## Testing
Run tests
```sh
RAILS_ENV=test bundle exec rspec parser_spec.rb
```