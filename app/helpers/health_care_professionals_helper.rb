module HealthCareProfessionalsHelper
  def display_resigned_at_date(hcp)
    if hcp.resigned?
      l hcp.resigned_at.to_date, format: :long
    else
      'Active'
    end
  end
end
