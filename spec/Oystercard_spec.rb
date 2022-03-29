require_relative '../lib/Oystercard.rb'

describe Oystercard do

  it "has a balance when created" do
    expect(subject.balance).to eq 0
  end

  it "can have the balance topped up" do
    expect(subject.top_up(5)).to eq "Your balance is £5"
  end

  it "has a maximum balance of £90" do
    subject.top_up(90)
    expect {subject.top_up(1) }.to raise_error("Top-up will exceed limit")
  end

end