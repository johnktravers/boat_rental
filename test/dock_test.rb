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
    kayak_1 = Boat.new(:kayak, 20)
    kayak_2 = Boat.new(:kayak, 20)
    sup_1 = Boat.new(:standup_paddle_board, 15)
    patrick = Renter.new("Patrick Star", "4242424242424242")
    eugene = Renter.new("Eugene Crabs", "1313131313131313")

    @dock.rent(kayak_1, patrick)
    @dock.rent(kayak_2, patrick)
    @dock.rent(sup_1, eugene)

    expected = { kayak_1 => patrick,
                 kayak_2 => patrick,
                 sup_1 => eugene }
    assert_equal expected, @dock.rental_log
  end


end
