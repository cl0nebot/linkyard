class OauthAttributes < Struct.new(:provider, :uid, :token, :secret, :first_name, :last_name, :name, :link, :email)
  def attribute_hash
    { 
      :provider => provider,
      :uid => uid,
      :token => token,
      :secret => secret,
      :first_name => first_name,
      :last_name => last_name,
      :name => name,
      :link => link,
    }
  end
end
