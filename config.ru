# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

# Rewrite all requests directly to 'index.html' - unless they start with /api
if ENV['RACK_ENV'] == 'development'
  use Rack::Rewrite do
    # in development we allow rails path
    rewrite %r{^(?!.*(api|rails|\.)).*$}, '/index.html'
  end
else
  use Rack::Rewrite do
    rewrite %r{^(?!.*(api|\.)).*$}, '/index.html'
  end
end

run Rails.application