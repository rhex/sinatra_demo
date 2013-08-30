require 'mongoid'
class Link
  include Mongoid::Document
  field :title, :type => String
  field :link, :type => String
end
