$:.unshift(File.dirname(__FILE__))
require 'app_helper'
require 'config/environments'
require 'active_record'

class Lion < Sinatra::Base
  configure do
    # set :root, File.dirname(__FILE__)
    enable :logging
    file = File.new("#{settings.root}/log/#{settings.environment}.log", 'a+')
    file.sync = true
    use Rack::CommonLogger, file
  end

  class SinatraPost < ActiveRecord::Base
  end

  get '/' do
    'Hello World'
  end

  run! if app_file == $0
end
