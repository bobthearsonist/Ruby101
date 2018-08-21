require 'sinatra'
require 'mongoid'

Mongoid.load! "mongoid.config"

get '/configuration' do
  configuration = Configuration. new(["address","name","balance"])
end

class Configuration
  include Mongoid::Document

  field :headers, type: String
  validates :headers, presence: true

  index({ headers: 'text' })
end