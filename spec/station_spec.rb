require_relative '../lib/station'

describe Station do
  let (:station) { Station.new(:station, :zone) }

  it 'has a name' do
    expect(station.name).to eq :station
  end

  it 'has a zone' do
    expect(station.zone).to eq :zone
  end
end
