class Oystercard
  attr_reader :balance
  
  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Top-up will exceed limit" if exceed_limit?(amount)
    @balance += amount
    "Your balance is £#{@balance}"
  end

private

  def exceed_limit?(amount)
    @balance + amount > 90
  end

end
