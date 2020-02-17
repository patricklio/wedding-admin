class ApplicationController < ActionController::Base
    private

    # logout redirect path
    def after_sign_out_path_for(resource_or_scope)
        new_admin_user_account_session_path
    end
end
