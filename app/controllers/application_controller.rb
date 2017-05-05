class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :permissions
  before_action :configure_permitted_parameters, if: :devise_controller?

  def permissions
    puts controller_name
    puts 'in app'
    not_permitted = false
    if user_signed_in?
      if  current_user.is_admin != 1
      case controller_name
        when 'users'
          unless action_name == 'show'
            not_permitted = true
          end
        when 'products','categories','rooms'
          unless action_name == 'index' or action_name == 'show'
            not_permitted = true
          end
        when 'orders'
          if ['edit','update','index'].include? action_name
            not_permitted = true
          end
      end
      if not_permitted
        flash[:error] = "You are not authorized for this action"
        redirect_to categories_url
      end

      end
    end
  end

  protected

  def configure_permitted_parameters
   test = devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar , :first_name , :last_name , :is_admin , :room_id , :extension])
   puts(test)
  end


end
