class Purchase < ApplicationRecord
  belongs_to :product
  belongs_to :user       #Buyer_type_user
  validate :buyer_purchase_product
  private
  def buyer_purchase_product
    if user.present? && user.user_type != 'buyer'
      errors.add(:user,"only buyer purchase product")
    end 
  end  
end
