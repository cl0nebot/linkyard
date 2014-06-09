class Authorization < ActiveRecord::Base
  belongs_to :user

  def update_access_token(token)
    puts "Token #{token} updated"
    true
  end
end
