class HomePolicy
  attr_reader :current_user, :resource

  def initialize(current_user, resource)
    @current_user = current_user
  end

  def admin?
    current_user.admin?
  end

  def patient?
    current_user.patient?
  end

end
