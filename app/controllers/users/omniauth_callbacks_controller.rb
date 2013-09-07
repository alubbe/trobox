class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def box
      render json: auth_hash
      # @user = User.find_or_create_from_auth_hash(auth_hash)
      # self.current_user = @user
      # redirect_to '/'
    end

    def box
        # You need to implement the method below in your model (e.g. app/models/user.rb)
        @user = User.find_or_create_from_box_oauth(auth_hash, current_user)

        if @user.persisted?
          sign_in_and_redirect @user
          #set_flash_message(:notice, :success, :kind => "Box")
        else
          session["devise.box_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end

    protected

    def auth_hash
      request.env['omniauth.auth']
    end
end