# frozen_string_literal: true

threads_count = ENV.fetch "RAILS_MAX_THREADS", 3

threads threads_count, threads_count
port ENV.fetch "PORT", 3000
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]

plugin :tmp_restart
