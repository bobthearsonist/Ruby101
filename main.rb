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

  configurations.map{|configuration|ConfigurationSerializer.new(configuration)}.to_json
end

class ConfigurationSerializer
  def initialize(configuration)
    @configuration = configuration
  end

  def as_json(*)
    data = {
      provider:@configuration.providerid,
      headers:@configuration.headers
    }
    data[:errors]=@configuration.errors if@configuration.errors.any?
    data
  end
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