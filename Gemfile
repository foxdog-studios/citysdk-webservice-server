source 'https://rubygems.org'

ruby '2.1.2'
#ruby-gemset=citysdk

gem 'activesupport'
gem 'dalli' # memcache
gem 'faraday'
gem 'i18n'
gem 'rgeo'
gem 'rgeo-geojson'
gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-config-file'

group :development do
  gem 'capistrano', '~>2'
  gem 'capistrano-ext'
  gem 'rerun'
  gem 'thin'
end

if File.exists?('Gemfile.local') then
  eval File.read('Gemfile.local'), nil, 'Gemfile.local'
end

