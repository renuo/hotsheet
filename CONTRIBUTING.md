# Contributing Guide

## Local Setup

### Prerequisites

- Bash ([^5.0](https://www.gnu.org/software/bash/))
- Ruby ([`.ruby-version`](.ruby-version))

### Setup

Clone this repository and run the setup script:

```sh
git clone https://github.com/renuo/hotsheet.git
cd hotsheet
bin/setup
```

### Run

- `spec/dummy/bin/run`: Start the dummy app's Rails server

### Lint

- `bin/fastcheck`: Run all linters
- `bin/fastcheck -A`: Format the code with RuboCop

### Test

- `bin/check`: Run specs for **all** supported Rails versions
- `bin/check rails_8_0`: Run specs for a **specific** Rails versions
  defined in [Appraisals](Appraisals)
