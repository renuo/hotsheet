# frozen_string_literal: true

cores = ENV.fetch "RAILS_MAX_THREADS", Concurrent.physical_processor_count
env = ENV.fetch "RAILS_ENV", "development"

environment env
pidfile ENV.fetch "PIDFILE" if ENV.key? "PIDFILE"
port ENV.fetch "PORT", 3000
threads cores, cores
workers cores if env == "production"

plugin :tmp_restart
