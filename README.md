# Hotsheet

**Manage your database with a simple and familiar web interface**

This gem allows you to mount a view to manage your database using a table view
where you can edit database records inline.

- Look at and modify your DB within the app itself (no rails console required!).
- Give controlled DB access to your admin users without having to create CRUD views for each table.
- Lightweight and fast. We keep usage simple and configuration to the minimum.

![demo_gif](https://github.com/user-attachments/assets/debf45a1-c6d2-4a1f-a734-37559bb095de)


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

After installing, you can directly go to `/hotsheet` within your app by default.

### Configuration

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

## Roadmap

This is a newly created gem which we are actively working on, and we will firstly focus on:

1. Single-user experience (styles and usability)
2. Configuration and access permissions
3. Concurrent users (broadcasting, conflict resolution)

Feel free to look at our [planned enhancements](https://github.com/renuo/hotsheet/issues?q=is%3Aopen+is%3Aissue+label%3Aenhancement) or add your own.

## License

Hotsheet is available as open source under the terms of the [MIT License].\
Copyright © 2024 [Renuo AG](https://www.renuo.ch).

[Contributing Guide]: https://github.com/renuo/hotsheet/blob/main/CONTRIBUTING.md
[MIT License]: https://github.com/renuo/hotsheet/blob/main/LICENSE
