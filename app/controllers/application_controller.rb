class ApplicationController < ActionController::Base
def after_sign_in_path_for(resource)
  if current_user.has_role?(:admin)
    admin_users_path
  elsif current_user.has_role?(:supplier)
    root_path
  elsif current_user.has_role?(:customer)
    root_path
  else
    home_path(current_user)
  end

end
end
