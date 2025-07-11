# Contributing Guide

## Prerequisites

- Bun
- Ruby
- SQLite

## Local Setup

Clone this repository and run the setup script:

```sh
git clone https://github.com/renuo/hotsheet.git
cd hotsheet
bin/setup
```

### Run

- `bin/run_dummy`: Start the dummy app's Rails server

### Lint

- `bin/lint`: Run all linters

### Test

- `bin/check`: Run specs for **all** supported Rails versions
- `bin/check rails_8_0`: Run specs for a **specific** Rails version defined in [Appraisals](Appraisals)

### Appraisal

- `bundle exec appraisal install`: Re-generate the respective gemfiles after one has been changed.
