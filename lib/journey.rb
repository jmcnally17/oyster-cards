class Journey
  attr_reader :entry_station, :exit_station

  MINIMUM = 1.0
  PENALTY_FARE = 6.0

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def complete?
    @exit_station != nil
  end

  def end_journey(exit_station)
    @exit_station = exit_station
  end

  def fare
    return PENALTY_FARE if @exit_station == :unknown || @entry_station == :unknown
    MINIMUM
  end
end
