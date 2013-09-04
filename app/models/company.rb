require 'mongoid'
class Company
  include Mongoid::Document

  field :code, type: String
  field :sector, type: String
  field :share_id, type: Integer
end
