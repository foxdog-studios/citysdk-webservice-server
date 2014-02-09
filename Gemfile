source 'https://rubygems.org'

ruby '2.1.0'

#ruby-gemset=citysdk-webservice-server

gem "sinatra", :require => "sinatra/base"
gem 'sinatra-config-file'
gem "i18n"
gem "active_support"
gem "faraday"
gem "rgeo"
gem "rgeo-geojson"
gem "passenger"
gem 'dalli' # memcache

group :development do
  gem 'capistrano', '~>2'
  gem 'capistrano-ext'
  gem 'rerun'
  gem 'thin'
end

if File.exists?('Gemfile.local') then
  eval File.read('Gemfile.local'), nil, 'Gemfile.local'
end

