# frozen_string_literal: true

require "pagy"
require "pagy/extras/bootstrap"

# Pagy Variables (https://ddnexus.github.io/pagy/docs/api/pagy#variables)
Pagy::DEFAULT[:limit] = 100
Pagy::DEFAULT.freeze
