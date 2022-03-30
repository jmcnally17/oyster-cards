require_relative './journey'
require_relative './station'

class Oystercard
  attr_reader :balance, :limit, :entry_station, :journeys, :current_journey

  LIMIT = 90.0
  MINIMUM = 1.0
  
  def initialize
    @balance = 0.0
    @limit = LIMIT
    @entry_station = nil
    @journeys = []
    @current_journey = nil
  end

  def top_up(amount)
    raise "Top-up will exceed limit of £#{@limit}" if exceed_limit?(amount)
    @balance += amount.to_f
    "Your balance is £#{@balance}"
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    fail "Insufficient balance" if insufficient_balance?
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM)
    create_journey(@entry_station, station)
    "Journey complete."
    @entry_station = nil
  end

private

  def deduct(amount)
    #raise "Not enough money on the card" if overdrawn?(amount)
    @balance -= amount
    "Your balance is now £#{@balance}"
  end

  def exceed_limit?(amount)
    @balance + amount > @limit
  end

=begin
  def overdrawn?(amount)
    @balance < amount
  end
=end

  def insufficient_balance?
    @balance < MINIMUM
  end

  def create_journey(entry_station, exit_station)
    @journeys.push({ in_station: entry_station, out_station: exit_station })
  end
end
