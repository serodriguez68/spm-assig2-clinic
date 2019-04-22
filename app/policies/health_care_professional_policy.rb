class HealthCareProfessionalPolicy
  attr_reader :current_user, :hcp

  def initialize(current_user, hcp)
    @current_user = current_user
    @hcp = hcp
  end

  def overall_policy
    current_user.admin?
  end

  def index?
    overall_policy
  end

  def new?
    overall_policy
  end

  def create?
    overall_policy
  end

  def edit?
    overall_policy
  end

  def update?
    overall_policy
  end

  def destroy?
    overall_policy && !hcp.resigned?
  end

  def index_of_specialty?
    current_user.admin? or current_user.patient?
  end

end
