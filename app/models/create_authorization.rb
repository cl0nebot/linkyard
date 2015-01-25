class CreateAuthorization
  def initialize(user, attributes)
    @user = user
    @attributes = attributes
  end

  def call
    return if @user.has_authorization_for?(@attributes[:provider])

    @user.authorizations.build(@attributes)
    @user.save!
  end
end
