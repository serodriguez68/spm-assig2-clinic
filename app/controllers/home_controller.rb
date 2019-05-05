class HomeController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def admin
    authorize :home
  end

  def patient
    authorize :home
  end
end
