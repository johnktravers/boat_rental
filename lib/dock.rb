class Dock
  attr_reader :name,
              :max_rental_time,
              :rental_log,
              :return_log

  def initialize(name, max_rental_time)
    @name = name
    @max_rental_time = max_rental_time
    @rental_log = {}
    @return_log = {}
  end

  def rent(boat, renter)
    @rental_log[boat] = renter
  end

  def charge(boat)
    hours = [boat.hours_rented, max_rental_time].min

    { card_number: @rental_log[boat].credit_card_number,
      amount: hours * boat.price_per_hour }
  end

  def return(boat)
    @return_log[boat] = @rental_log[boat]
  end

  def log_hour
    @rental_log.each_key do |boat|
      if !@return_log.keys.include?(boat)
        boat.add_hour
      end
    end
  end

  def revenue
    @return_log.keys.sum do |boat|
      charge(boat)[:amount]
    end
  end

end
