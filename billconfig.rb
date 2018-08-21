require 'sinatra'
require 'mongoid'

Mongoid.load! "mongoid.config"

get '/health' do
  true
end

get '/configurations' do
  Configuration.all.to_json
end

get '/configuration' do
  configurations = Configuration.all

  [:providerid].each do |filter|
    configurations = Configuration.send(filter, params[filter]) if params[filter]
  end

  configurations.to_json
end

class Configuration
  include Mongoid::Document

  field :providerid, type: String
  field :headers, type: String
  validates :providerid, presence: true
  validates :headers, presence: true

  index({ providerid: 1}, {unique: true, name: "proder_index"})

  scope :providerid, -> (providerid) { where(providerid: providerid) }
end