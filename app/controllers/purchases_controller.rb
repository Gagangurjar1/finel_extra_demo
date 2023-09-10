class PurchasesController < ApplicationController 
  # def index
  #   if buyer
  #     purchase = @current_user.purchases
  #     if purchase.present?
  #       render json: purchase
  #     else
  #       render json: { message: "No product exists" }
  #     end
  #   end      
  # end
  def index
    if buyer
      purchases = @current_user.purchases.includes(:product)
      if purchases.present?
        render json: purchases, each_serializer: PurchaseSerializer
      else
        render json: { message: "No product exists" }
      end
    end
  end
  
  def show
    if buyer
      purchase = Purchase.find_by(id: params[:id])
      render json: purchase, serializer: PurchaseSerializer
    end
  end
  
  def create
    if buyer
      purchase= Purchase.new(purchase_params)
      if purchase.save
        render json: { message: "Purchase Product", data: purchase }
      else
        render json: { errors: purchase.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "Only Buyer Type User Purchase Product " }, status: :unauthorized
    end
  end 
  
  # def show
  #   if buyer
  #     purchase= Purchase.find_by(id: params[:id])
  #     render json: purchase
  #   end    
  # end  


  private       
  def purchase_params
    params.require(:purchase).permit(:product_id,:user_id)
  end

  def buyer
    @current_user.user_type == "buyer"
  end 
end
