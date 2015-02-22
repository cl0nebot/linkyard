class CreateAuthorization
  def initialize(user, attributes)
    @user = user
    @attributes = attributes
  end

  def call
    return if @user.has_authorization_for?(@attributes[:provider])

    @user.authorizations.build(@attributes)
    @user.save!

    create_default_interaction_for(@attributes[:provider])
  end

  private
  def create_default_interaction_for(provider)
    interaction = Interaction.new_by_name(provider + "Interaction", {})
    interaction.user = @user
    interaction.save!
  end
end
