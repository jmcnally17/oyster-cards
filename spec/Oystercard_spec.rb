require_relative '../lib/Oystercard.rb'

describe Oystercard do

  it "has a balance when created" do
    expect(subject.balance).to eq 0
  end

  it "can have the balance topped up" do
    expect(subject.top_up(5)).to eq "Your balance is £5"
  end

  it "has a maximum balance of £90" do
    subject.top_up(subject.limit)
    expect {subject.top_up(1) }.to raise_error("Top-up will exceed limit of £#{subject.limit}")
  end

  it "deduct amount from balance as long as balance is sufficient" do
    subject.top_up(50)
    expect(subject.deduct(5)).to eq "Your balance is £45"
  end

  it "prevents deduction if amount is greater than balance" do
    subject.top_up(4)
    expect{subject.deduct(5)}.to raise_error("Not enough money on the card")
  end

  it {is_expected.to respond_to(:in_journey?)}

  it "is in journey if it has been touched in" do
    subject.touch_in
    expect(subject.in_journey?).to be true
  end

  it "is not in journey if it has been touched out" do
    subject.touch_in
    subject.touch_out
    expect(subject.in_journey?).to be false
  end

end