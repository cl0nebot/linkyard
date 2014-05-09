class Builder < ActiveRecord::Base
  belongs_to :user

  validates :type, :presence => true
  
  def build
    raise 'Abstract method'
  end
end
