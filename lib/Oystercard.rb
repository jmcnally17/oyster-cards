class Oystercard
  attr_reader :balance, :limit

  LIMIT = 90
  
  def initialize
    @balance = 0
    @limit = LIMIT
    @in_journey = false
  end

  def top_up(amount)
    fail "Top-up will exceed limit of £#{@limit}" if exceed_limit?(amount)
    @balance += amount
    "Your balance is £#{@balance}"
  end

  def deduct(amount)
    fail "Not enough money on the card" if overdrawn?(amount)
    @balance -= amount
    "Your balance is £#{@balance}"
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

private

  def exceed_limit?(amount)
    @balance + amount > @limit
  end

  def overdrawn?(amount)
    @balance < amount
  end

end
