class Customers::ApplicationController < ApplicationController
  before_action :authenticate_customer!

  def after_sign_in_path_for(resource)
    customer_root_path
  end
end
