class AppointmentPolicy
  attr_reader :current_user, :app

  def initialize(current_user, app)
    @current_user = current_user
    @app = app
  end

  def new?
    current_user.patient?
  end

  def create?
    current_user.patient? and app.user == current_user
  end

  def destroy?
    current_user.patient? and app.user == current_user and !app.past?
  end

  def my?
    current_user.patient?
  end

  def all?
    current_user.admin?
  end

  def available_slots_between?
    current_user.patient? or current_user.admin?
  end

  class Scope
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user  = current_user
      @scope = scope
    end

    def resolve
      if current_user.admin?
        scope.all
      elsif current_user.patient?
        scope.where(user: current_user)
      end
    end

  end

end
