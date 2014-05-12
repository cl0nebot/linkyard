class Builder < ActiveRecord::Base
  belongs_to :user

  validates :type, :presence => true
  
#don't use
  def build
    raise 'Abstract method'
  end
end
