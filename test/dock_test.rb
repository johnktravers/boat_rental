require 'minitest/autorun'
require 'minitest/pride'
require './lib/boat'
require './lib/renter'
require './lib/dock'

class DockTest < Minitest::Test

  def setup
    @dock = Dock.new("The Rowing Dock", 3)
  end

  def test_it_exists
    assert_instance_of Dock, @dock
  end

  def test_initialize
    assert_equal "The Rowing Dock", @dock.name
    assert_equal 3, @dock.max_rental_time
    assert_equal Hash.new, @dock.rental_log
  end

  def test_rent_and_rental_log
    patrick_and_eugene_rent_kayaks_and_sup

    expected = { @kayak_1 => @patrick,
                 @kayak_2 => @patrick,
                 @sup_1 => @eugene }
    assert_equal expected, @dock.rental_log
  end

  def test_it_can_charge_renters
    patrick_and_eugene_rent_kayaks_and_sup
    2.times do
      @kayak_1.add_hour
    end

    expected = { :card_number => "4242424242424242",
                 :amount => 40 }
    assert_equal expected, @dock.charge(@kayak_1)
  end

  def test_it_does_not_charge_past_max_hours
    patrick_and_eugene_rent_kayaks_and_sup
    5.times do
      @sup_1.add_hour
    end

    expected = { :card_number => "1313131313131313",
                 :amount => 45 }
    assert_equal expected, @dock.charge(@sup_1)
  end


  # Helper methods

  def patrick_and_eugene_rent_kayaks_and_sup
    @kayak_1 = Boat.new(:kayak, 20)
    @kayak_2 = Boat.new(:kayak, 20)
    @sup_1 = Boat.new(:standup_paddle_board, 15)
    @patrick = Renter.new("Patrick Star", "4242424242424242")
    @eugene = Renter.new("Eugene Crabs", "1313131313131313")

    @dock.rent(@kayak_1, @patrick)
    @dock.rent(@kayak_2, @patrick)
    @dock.rent(@sup_1, @eugene)
  end

end
