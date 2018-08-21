require 'sinatra'
get '/configuration' do
  configuration = Configuration. new(["address","name","balance"])
end

class Configuration
  def initialize(headers)
    @headers = headers
  end
end