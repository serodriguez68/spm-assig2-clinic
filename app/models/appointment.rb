class Appointment < ApplicationRecord
  # Constants
  APPOINTMENT_LENGTH = 1 # hour
  OPENING_BUSINESS_HOUR = 9 # 9am
  CLOSING_BUSINESS_HOUR = 17 # 5pm

  # Validations
  validates :start_time, presence: true
  validate :created_on_available_slot, on: :created

  # Associations
  belongs_to :health_care_professional
  belongs_to :user

  # Class Methods
  scope :on_date, -> (date) { where(start_time: [date.to_date.beginning_of_day..date.to_date.end_of_day]) }
  scope :between_dates, -> (start_date, end_date) { where(start_time: [start_date.to_date.beginning_of_day..end_date.to_date.end_of_day]) }

  def self.available_on?(hcp, start_time)
    date = start_time.to_date
    return available_slots_on_date(hcp, date).include? start_time
  end

  def self.available_slots_between(hcp, start_date, end_date, time_now = DateTime.now)
    ra = raw_availability_between(start_date, end_date, time_now)
    busy_slots = hcp.appointments.between_dates(start_date, end_date).pluck(:start_time)
    return ra - busy_slots
  end

  def self.available_slots_on_date(hcp, date, time_now = DateTime.now)
    available_slots_between(hcp, date, date, time_now)
  end

  # Returns an array of Datetimes with all raw availabilites for the given date range
  # Empty array if no raw availabilites are available
  def self.raw_availability_between(start_date, end_date, time_now = DateTime.now)
    raw_avail = []
    (start_date..end_date).each do |date|
      raw_avail += raw_availability_on_date(date, time_now)
    end
    return raw_avail
  end

  # Returns an array of Datetimes with all raw availabilites for the given date
  # Empty array if none are available
  def self.raw_availability_on_date(date, time_now = DateTime.now)
    first_raw_slot = first_raw_slot_available_on_date(date, time_now)
    last_raw_slot = last_raw_slot_available_on_date(date, time_now)

    return [] if first_raw_slot.nil? || last_raw_slot.nil?

    current_max = first_raw_slot
    raw_availability = [current_max]

    while current_max < last_raw_slot
      current_max += APPOINTMENT_LENGTH.hours
      raw_availability.push(current_max)
    end
    return raw_availability
  end

  # Returns the Datetime of the first raw slot available on the given date
  def self.first_raw_slot_available_on_date(date, time_now = DateTime.now)
    date = date.to_date

    if date < Date.today
      return nil

    elsif date == Date.today

      if time_now.hour < OPENING_BUSINESS_HOUR
        # hour is before opening hour = first slot is opening hour
        return date.to_date.beginning_of_day + OPENING_BUSINESS_HOUR.hours

      elsif time_now.hour >= OPENING_BUSINESS_HOUR && time_now.hour < (CLOSING_BUSINESS_HOUR - APPOINTMENT_LENGTH)
        # hour is in between business hours = next hour
        return (time_now + APPOINTMENT_LENGTH.hours).beginning_of_hour

      else
        # hour is after closing time - 1 hour: nil
        return nil
      end

    else
      # date > Date.today
      return date.to_date.beginning_of_day + OPENING_BUSINESS_HOUR.hours
    end
  end

  # Returns the Datetime of the last raw slot available on the given date
  def self.last_raw_slot_available_on_date(date, time_now = DateTime.now)
    date = date.to_date

    if date < Date.today
      return nil

    elsif date == Date.today

      if time_now.hour < (CLOSING_BUSINESS_HOUR - APPOINTMENT_LENGTH)
        # hour is in between business hours : next hour
        return (date.to_date.beginning_of_day + CLOSING_BUSINESS_HOUR.hours - APPOINTMENT_LENGTH.hours)
      else
        # hour is after closing time - 1 hour: nil
        return nil
      end

    else
      # date > Date.today
      return (date.to_date.beginning_of_day + CLOSING_BUSINESS_HOUR.hours - APPOINTMENT_LENGTH.hours)
    end

  end


  #  Instance Methods
  def end_time
    start_time + APPOINTMENT_LENGTH.hours
  end

  private
  def created_on_available_slot
    unless self.class.available_on?(health_care_professional, start_time)
      errors.add(:start_time, "#{health_care_professional.name} is not available on #{start_time}")
    end
  end

end
