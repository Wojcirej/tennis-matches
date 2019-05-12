# Tennis matches

# Development environment setup
```
bundle install
rails db:create
rails db:create RAILS_ENV=test
rails db:schema:load
rails db:seed
```
# Development server
```
rails s
```
# Launch tests
```
rspec
```
# Bump version
```
ruby bump_version [TYPE]
```

Script will create new git tag with new version number, which will be also pushed to the remote as new commit.

### Available bump types

- patch - change last number, e.g. 1.2.3 -> 1.2.4
- minor - change middle number, e.g. 1.2.3 -> 1.3.0
- major - change first number, e.g. 1.2.3 -> 2.0.0

When no bump type specified, script proceeds with `patch` type.
