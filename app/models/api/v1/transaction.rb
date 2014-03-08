class Api::V1::Transaction < ActiveRecord::Base
  belongs_to :account
end
