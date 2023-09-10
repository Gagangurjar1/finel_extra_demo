class ApplicationController < ActionController::Base
  include JsonWebToken
 #................Authentication request............
  before_action :authenticate_request
 #...................Authenticate User..................
  def authenticate_request
    begin
      header = request.headers[ 'Authorization' ]
      header = header.split(" ").last if header
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    rescue JWT::DecodeError => e
      render json: { error: 'Invalid token' }, status: :unprocessable_entity
    end
    rescue ActiveRecord::RecordNotFound
    render json: "No record found.."
  end 
end
