class Product < ApplicationRecord
  belongs_to :user         #Seller_type_user
  has_many :purchases       #Buyer_type_user
  has_one_attached :image
  validate :seller_add_product
  private
  def seller_add_product
    if user.present? && user.user_type != 'seller'
      errors.add(:user,"only seller add product")
    end 
  end
end
