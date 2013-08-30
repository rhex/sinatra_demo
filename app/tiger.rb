$:.unshift(File.dirname(__FILE__))
require 'models/company'
require 'app_helper'

# This is Tiger
class Tiger < Sinatra::Base
  include Mongo
  puts "fileapp is #{app_file}, file is #{__FILE__}, $0 is #{$0}, rack_env is #{ENV['RACK_ENV']}"
  Mongoid.load!('config/mongoid.yml')

  get '/' do
    'This is tiger'
  end

  get '/mongoid' do
    company = Company.new(:code => 'hello world', :sector => 'localhost', :share_id => 123)
    company.save
    "Hello, I use mongoid create company #{company.code}, #{company.sector}"
  end

# warning: redefining `object_id' may cause serious problems'
#  helpers do
#    def object_id(val)
#      BSON::ObjectId.from_string(val)
#    end
#
#    def document_by_id(id)
#      id = object_id(id) if String === id
#      settings.mongo_db['test'].find_one(:_id => id).to_json
#    end
#  end
#
#  # list all documents in the test collection
#  get '/documents/?' do
#    content_type :json
#    settings.mongo_db['test'].find.to_a.to_json
#  end
#
#  # find a document by its ID
#  get '/document/:id/?' do
#    content_type :json
#    document_by_id(params[:id]).to_json
#  end
#
#  # insert a new document from the request parameters,
#  # then return the full document
#  post '/new_document/?' do
#    content_type :json
#    new_id = settings.mongo_db['test'].insert params
#    document_by_id(new_id).to_json
#  end
#
#  # update the document specified by :id, setting its
#  # contents to params, then return the full document
#  put '/update/:id/?' do
#    content_type :json
#    id = object_id(params[:id])
#    settings.mongo_db['test'].update({:_id => id}, params)
#    document_by_id(id).to_json
#  end
#
#  # update the document specified by :id, setting just its
#  # name attribute to params[:name], then return the full
#  # document
#  put '/update_name/:id/?' do
#    content_type :json
#    id   = object_id(params[:id])
#    name = params[:name]
#    settings.mongo_db['test'].update({:_id => id}, {'$set' => {:name => name}})
#    document_by_id(id).to_json
#  end
# 
#  # delete the specified document and return success
#  delete '/remove/:id' do
#    content_type :json
#    settings.mongo_db['test'].remove(:_id => object_id(params[:id]))
#    {:success => true}.to_json
#  end
#
#  get '/link' do
#    @links = Link.all
#    erb "This is mongodb link"
#  end
  run! if app_file == $0
end
