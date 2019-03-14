module Sinatra
  # module with authentication helper methods
  module AuthenticationHelper
    def authenticated?
      return false if session[:user_id].nil?

      @current_user = User.find(session[:user_id])
    end

    def login_required!
      redirect('/users/sign_in') unless authenticated?
    end

    def business_owner(user_id, business_owner_id)
      user_id == business_owner_id
    end
  end
end
