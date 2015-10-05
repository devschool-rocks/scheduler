class Instructors::ApplicationController < ApplicationController
  before_action :authenticate_instructor!
  layout 'instructors'

  def after_sign_in_path_for(resource)
    instructor_root_path
  end
end
