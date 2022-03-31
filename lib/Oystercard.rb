require_relative './journey'
require_relative './station'

class Oystercard
  attr_reader :balance, :limit, :journeys, :current_journey

  LIMIT = 90.0
  
  def initialize
    @balance = 0.0
    @limit = LIMIT
    @journeys = []
    @current_journey = nil
  end

  def top_up(amount)
    raise "Top-up will exceed limit of £#{@limit}" if exceed_limit?(amount)
    @balance += amount.to_f
  end

  def in_journey?
    @current_journey != nil
  end

  def touch_in(station)
    check_penalty_in
    raise "Insufficient balance" if insufficient_balance?
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    check_penalty_out
    @current_journey.end_journey(station)
    deduct
    @journeys.push(@current_journey)
    @current_journey = nil
  end

private

  def deduct
    @balance -= @current_journey.fare
  end

  def exceed_limit?(amount)
    @balance + amount > @limit
  end

  def insufficient_balance?
    @balance < Journey::MINIMUM
  end

  def check_penalty_in
    apply_penalty_in if @current_journey != nil
  end

  def apply_penalty_in
    @current_journey.end_journey(:unknown)
    deduct
    @journeys.push(@current_journey)
  end

  def check_penalty_out
    apply_penalty_out if @current_journey == nil
  end

  def apply_penalty_out
    @current_journey = Journey.new(:unknown)
  end
end
