class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique    
    def authorize_admin!
        unless current_user.admin?
            flash[:alert] = "You must be admin to access this section"
            redirect_to root_path
        end
    end

end
