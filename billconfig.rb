require 'sinatra'
require 'mongoid'

Mongoid.load! "mongoid.config"

get '/health' do
  true
end

get '/configuration' do
  Configuration.all.to_json
end

class Configuration
  include Mongoid::Document

  field :providerid, type: String
  field :headers, type: String
  validates :providerid, presence: true
  validates :headers, presence: true

  index({ providerid: 1}, {unique: true, name: "proder_index"})
end