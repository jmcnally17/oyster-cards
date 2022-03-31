require_relative '../lib/Oystercard.rb'
require_relative '../lib/journey.rb'

describe Oystercard do
  let (:station) { double (:station) }
  let (:station2) { double (:station) }
  let (:journey) { double (:journey) }

  context "when created" do
    it "has a balance" do
      expect(subject.balance).to eq 0.0
    end

    it "current journey is nil" do
      expect(subject.current_journey).to eq nil
    end

    it "doesn't have any saved journeys" do
      expect(subject.journeys).to eq []
    end

    it {is_expected.to respond_to(:in_journey?)}
  end

  context "#top_up" do
    it "can update the balance" do
      expect { subject.top_up(5) }.to change { subject.balance }.by(5.0)
    end

    it "has a maximum balance of £90" do
      subject.top_up(subject.limit)
      expect {subject.top_up(1) }.to raise_error("Top-up will exceed limit of £#{subject.limit}")
    end
  end

  context "#touch_in" do
    it "will not start journey if balance is below the minimum fare" do
      expect { subject.touch_in(:station) }.to raise_error("Insufficient balance")
    end

    it "creates a new journey" do
      subject.top_up(5)
      expect(subject.touch_in(station)).to be_an_instance_of(Journey)
    end

    it "makes the card in journey'" do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.in_journey?).to be true
    end
  end

  context "#touch_out" do
    before (:each) do
      subject.top_up(5)
      subject.touch_in(station)
    end

    it "will deduct the minimum fare" do
      expect { subject.touch_out(station2) }.to change{ subject.balance }.by(-1)
    end

    it "logs the entire journey" do
      subject.touch_out(station2)
      expect(subject.journeys[-1]).to be_an_instance_of(Journey)
    end

    it "makes the card not in journey" do
      subject.touch_out(station2)
      expect(subject.in_journey?).to be false
    end
  end

  context "penalty fares" do
    it 'deducts the penalty fare from balance when forgetting to touch in' do
      expect { subject.touch_out(station2) }.to change{ subject.balance }.by(-6.0)
    end

    it "logs the penalty journey when forgetting to touch in" do
      subject.touch_out(station2)
      expect(subject.journeys[-1]).to be_an_instance_of(Journey)
    end

    it 'deducts the penalty fare from balance when forgetting to touch out' do
      subject.top_up(30)
      subject.touch_in(:Euston)
      expect { subject.touch_in(:Stratford) }.to change{ subject.balance }.by(-6.0)
    end

    it 'logs the penalty journey when forgetting to touch out' do
      subject.top_up(30)
      subject.touch_in(:Euston)
      subject.touch_in(:Stratford)
      expect(subject.journeys[-1]).to be_an_instance_of(Journey)
    end
  end
end