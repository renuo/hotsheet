# Hotsheet

**Manage your database with a simple and familiar web interface**

This gem allows you to mount a view to manage your database using a table view
where you can edit database records inline.

## Installation

Add this line to your application's Gemfile:

```rb
gem "hotsheet"
```

And then execute:

```sh
bundle
bin/rails g hotsheet:install
```

## Usage

You can configure which models this gem should manage, and specify which
attributes (database columns) should be editable in the Hotsheet. This can be
done by configuring the initializer file created by the install command:

```rb
# config/initializers/hotsheet.rb

Hotsheet.configure do |config|
  config.model :Author do |model|
    model.included_attributes = %i[name birthdate gender] # mutually exclusive with "excluded_attributes"
    # model.excluded_attributes = %i[created_at updated_at] # mutually exclusive with "included_attributes"
  end
end
```

## Contributing

See [Contributing Guide] for information on how to set up hotsheet locally.

## Roadmap / Planned Features

- Fetch all models in the application by default
- Support live updates (show when someone has the intention to edit a resource) via ActionCable
- Conflict resolution strategy (locking / merging / latest change etc.)
- Fine grained access / permissions (cancancan)
- Type-specific input fields
- Undo feature (or confirm / discard changes icons)
- Configure visibility of non-editable (excluded) fields
- Use importmap-rails for JS dependencies

## License

Hotsheet is available as open source under the terms of the [MIT License].\
Copyright © 2024 [Renuo AG](https://www.renuo.ch).

[Contributing Guide]: https://github.com/renuo/hotsheet/blob/main/CONTRIBUTING.md
[MIT License]: https://github.com/renuo/hotsheet/blob/main/LICENSE
