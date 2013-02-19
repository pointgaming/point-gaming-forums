Forem::ApplicationController.class_eval do
  before_filter :authenticate_forem_user

end
