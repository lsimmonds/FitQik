class AppointmentAuthorizer < ApplicationAuthorizer
  # Class method: can this user at least sometimes create a Appointment?
  def self.creatable_by?(user)
    !user.teacher.nil? || user.has_role?(:admin)
  end

  def self.readable_by?(user)
    true
  end

#  def readable_by?(user)
#    resource.teachers.include? user.teacher || resource.students.include? user.student || user.has_role?(:admin)
#  end

  def updatable_by?(user)
    ( !user.teacher.nil? && resource.teachers.include?(user.teacher) ) || user.has_role?(:admin)
  end

  # Instance method: can this user delete this particular appointment?
  def deletable_by?(user)
    ( !user.teacher.nil? && resource.teachers.include?(user.teacher) ) || user.has_role?(:admin)
  end
end

