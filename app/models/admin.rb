class Admin < ActiveRecord::Base
  stampable #Also lets this model be user stamped
  belongs_to :user
end
