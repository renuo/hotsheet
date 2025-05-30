# Hotsheet

**Manage your Rails database through a spreadsheet-like interface.**

- Look at and modify your DB within the app itself (no rails console required!).
- Give controlled DB access to your admin users without having to create CRUD views for each table.
- Lightweight and fast. We keep usage simple and configuration to the minimum.

<image width=450 alt=demo src=https://github.com/user-attachments/assets/d63544ff-0720-4839-9c14-b5c8cd084cd2>

## Installation

1. Add `gem "hotsheet"` to your Gemfile.
1. Run `bundle`.
1. Run `bin/rails g hotsheet:install`.

## Usage

After installing, you can directly go to `/hotsheet` within your app by default.

### Configuration

You can configure which models ('sheets') this gem should manage, and specify which
database columns should be editable or viewable in the spreadsheet. This can be
done by configuring the initializer file created by the install command:

```rb
# config/initializers/hotsheet.rb

Hotsheet.configure do
  sheet :User do
    column :name
    column :birthdate, editable: false
  end
end
```

## Contributing

See [Contributing Guide](https://github.com/renuo/hotsheet/blob/main/CONTRIBUTING.md) and please
follow the [Code of Conduct](https://github.com/renuo/hotsheet/blob/main/CODE_OF_CONDUCT.md).

## Roadmap

This is a newly created gem, and we will firstly focus on:

1. Single-user experience (styles and usability)
1. Configuration and access permissions
1. Concurrent users (broadcasting, conflict resolution)

Feel free to look at our [planned enhancements](https://github.com/renuo/hotsheet/issues?q=is%3Aopen+is%3Aissue+label%3Aenhancement)
or add your own.

## License

Hotsheet is available as open source under the terms of the
[MIT License](https://github.com/renuo/hotsheet/blob/main/LICENSE).\
Copyright © 2024-present [Renuo AG](https://www.renuo.ch).
