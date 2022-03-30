require_relative '../lib/journey'

describe Journey do
  let(:journey) { Journey.new(:entry_station) }
  let(:exit_station) { double (:Station) }
  
  it "has an entry station when created" do
    expect(journey.entry_station).to eq :entry_station
  end

  it "sets exit station as nil when created" do
    expect(journey.exit_station).to eq nil
  end

  it "sets 'complete' to false when created" do
    expect(journey.complete?).to be false
  end

  context "#end_journey" do
    it "updates the exit station to the argument that is passed" do
      expect { journey.end_journey(exit_station) }.to change{ journey.exit_station }.to(exit_station)
    end
  end
end
