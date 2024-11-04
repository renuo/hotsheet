# Hotsheet

### Manage your database with a simple and familiar web interface

This gem allows you to mount a view to manage your database using a table view where you can edit DB records inline.

## Installation

Add and install the gem by adding this to the application's Gemfile:

```rb
gem "hotsheet"
```

And executing:

```sh
bundle
bin/rails g hotsheet:install
```

## Usage

By default, the gem will fetch all models in you application and allow you to manage them.

You can also configure which models and columns whithin them you want to manage by creating an initializer file in your application:

```rb
# config/initializers/hotsheet.rb

Hotsheet.configure do |config|
  config.model :Author do |model|
    model.included_attributes = %i[name birthdate gender]
    # model.excluded_attributes = %i[created_at updated_at]
  end
end

```

Finally, you will need to create a configuration file to specify which models you want to manage with Hotsheet.

## Development: Local Setup

After cloning the repo, run `bin/setup` to install dependencies.

- Run tests: `bin/check`
- Run linters: `bin/fastcheck`
- Start dummy app: `spec/dummy/bin/run`

## TODO

- Support live updates (show when someone has the intention to edit a resource) via ActionCable
- Conflict resolution strategy (locking / merging / latest change etc.)
- Fine grained access / permissions (cancancan)
- Type specific input fields
- Undo feature (or confirm / discard changes icons)
- Configure visibility of non-editable (excluded) fields
- Use importmap-rails for js dependencies
