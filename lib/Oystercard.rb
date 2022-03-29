class Oystercard
  attr_reader :balance, :limit

  LIMIT = 90
  
  def initialize
    @balance = 0
    @limit = LIMIT
  end

  def top_up(amount)
    fail "Top-up will exceed limit of £#{@limit}" if exceed_limit?(amount)
    @balance += amount
    "Your balance is £#{@balance}"
  end

private

  def exceed_limit?(amount)
    @balance + amount > @limit
  end

end
