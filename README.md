# Hotsheet

### Manage your database with a simple and familiar web interface

This gem allows you to mount a view to manage your database using a table view where you can edit DB records inline.

## Installation

Add and install the gem by adding this to the application's Gemfile:

```ruby
gem "hotsheet"
```

And executing:

```bash
bundle
```

## Usage

You can mount the view in your routes file like this:

```ruby
mount Hotsheet::Engine, at: "hotsheet"
```

By default, the gem will fetch all models in you application and allow you to manage them.

You can also configure which models and columns whithin them you want to manage by creating an initializer file in your application:

```ruby
# config/initializers/hotsheet.rb

Hotsheet.configure do |config|
  config.model :Author do |model|
    model.included_attributes = %i[name birthdate gender]
    # model.excluded_attributes = %i[created_at updated_at]
  end
end

```

Finally, you will need to create a configuration file to specify which models you want to manage with Hotsheet.

## TODO

- Support live updates (show when someone has the intention to edit a resource) via ActionCable
- Conflict resolution strategy (locking / merging / latest change etc.)
- Fine grained access / permissions (cancancan)
- Type specific input fields
- Undo feature (or confirm / discard changes icons)
- Configure visibility of non-editable (excluded) fields
- Generator for configuration file/s
- Use importmap-rails for js dependencies
