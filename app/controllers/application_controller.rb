class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ActionController::MimeResponds


  def protect_not_json
    render body: nil, status: 406 if request.format != :json
  end
end
