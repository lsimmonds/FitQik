class User < ActiveRecord::Base
  model_stamper #Sets this model as a source for user stamping
  stampable #Also lets this model be user stamped

  has_one :admin
  has_one :teacher
  has_one :student
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
