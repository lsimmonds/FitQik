class EditorAuthorizer < ApplicationAuthorizer
  # Class method: can this user at least sometimes create a Editor?
  def self.creatable_by?(user)
    user.has_role?(:editor) || user.has_role?(:admin)
  end

  def self.readable_by?(user)
    true
  end

  def readable_by?(user)
    true
  end

  def updatable_by?(user)
    puts "in updatable_by editor"
    user.has_role?(:editor) || user.has_role?(:admin)
  end

  # Instance method: can this user delete this particular subject?
  def deletable_by?(user)
    user.has_role?(:editor) || user.has_role?(:admin)
  end
end

