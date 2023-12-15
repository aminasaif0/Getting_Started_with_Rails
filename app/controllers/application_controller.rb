class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    protect_from_forgery with: :exception

    def after_sign_in_path_for(resource)
        if resource.is_a?(User)
            case resource.roles
            when 'admin'
                articles_path
            when 'user'
                articles_path
            else
                articles_path
            end
        else
            super
        end
    end
end
