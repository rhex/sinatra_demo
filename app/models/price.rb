require 'mongoid'
class Price
  include Mongoid::Document
  field :share_id, type: Integer
  field :date, type: Time
  field :open, type: Integer
  field :close, type: Integer
  field :high, type: Integer
  field :low, type: Integer
  field :volume, type: Integer
end
