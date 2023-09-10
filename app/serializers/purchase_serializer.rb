class PurchaseSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :product, except: [:created_at, :updated_at]
end
