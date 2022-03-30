require_relative '../lib/journey'

describe Journey do
  let(:journey) { Journey.new(:entry_station) }
  
  it "has an entry station when created" do
    expect(journey.entry_station).to eq :entry_station
  end

  it "sets exit station as nil when created" do
    expect(journey.exit_station).to eq nil
  end

  it "sets 'complete' to false when created" do
    expect(journey.complete?).to be false
  end

end