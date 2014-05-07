# Other authorizers should subclass this one
class ApplicationAuthorizer < Authority::Authorizer

  #   :create => 'creatable',
  #   :read   => 'readable',
  #   :update => 'updatable',
  #   :delete => 'deletable'

  # Any class method from Authority::Authorizer that isn't overridden
  # will call its authorizer's default method.
  #
  # @param [Symbol] adjective; example: `:creatable`
  # @param [Object] user - whatever represents the current user in your app
  # @return [Boolean]
  def self.default(adjective, user)
    # 'Whitelist' strategy for security: anything not explicitly allowed is
    # considered forbidden.
    #user.has_role? :admin
false
  end

  def self.creatable_by?(user)
    true
false
  end

  def readable_by?(user)
    resource.user == user || user.has_role?(:admin)
false
  end

  # To update a specific resource instance, you must either own it or be an admin
  def updatable_by?(user)
    resource.user == user || user.has_role?(:admin)
false
  end

  # Instance method: can this user delete this particular appointment?
  def deletable_by?(user)
    resource.user == user || user.has_role?(:admin)
false
  end

end
