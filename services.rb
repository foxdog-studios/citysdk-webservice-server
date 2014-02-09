# encoding: utf-8

$LOAD_PATH.unshift File.dirname(__FILE__)
require 'active_support/core_ext'
require 'faraday'
require 'sinatra'
require "sinatra/config_file"
require 'json'

require './services_utils.rb'

configure do | sinatraApp |
  set :environment, :production
  if defined?(PhusionPassenger)
    PhusionPassenger.on_event(:starting_worker_process) do |forked|
      if forked
        # We're in smart spawning mode.
        CitySDK_Services.memcache_new
      end
      # Else we're in direct spawning mode. We don't need to do anything.
    end
  end
end

config_path = File.expand_path('../config.yml', __FILE__)
config_file config_path

$settings = settings

class CitySDK_Services < Sinatra::Base

  def do_abort(code,message)
    throw(:halt, [code, {'Content-Type' => 'application/json'}, message])
  end

  before do

  end

  after do
    content_type 'application/json'
  end

  def parse_request_json
    begin
      return JSON.parse(request.body.read)
    rescue => exception
      self.do_abort(422, {
        "result"=>"fail",
        "error"=>"Error parsing JSON",
        "message"=>exception.message
      }.to_json)
    end
  end

  def httpget(connection, path)
    response = ''
    begin
      response = connection.get do |req|
        req.url path
        req.options[:timeout] = 5
        req.options[:open_timeout] = 2
      end
    rescue Exception => e
      self.do_abort(408, {
        "result"=>"fail",
        "error"=>"Error requesting resource.",
        "message"=>e.message
      }.to_json)
    end
    return response
  end

  get '/' do
    { :status => 'success',
      :url => request.url,
    }.to_json
  end

end

settings.routes.each do |route|
  require route
end

