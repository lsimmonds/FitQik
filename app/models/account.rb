class Account < ActiveRecord::Base
  include Authority::Abilities
  stampable #Also lets this model be user stamped
  has_many :transactions
end
