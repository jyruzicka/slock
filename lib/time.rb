require 'json'

# The reminder class represents a reminder to be displayed at a given time.
# Reminders are created using SCache::load
class Reminder
  attr_accessor :time, :message, :day

  @times = []
  class << self
    attr_accessor :times

    def add t
      @times << t
    end
  end

  def initialize hsh={}
    hsh.each do |k,v|
      setter = "#{k}="
      self.send(setter,v) if respond_to?(setter)
    end
    
    Reminder::add self
  end

  # Should this reminder be run now?
  # Depends on the day and time
  def should_run_now?
    now = Time.now
    day = now.strftime('%A')

    day_match = case @day
    when :always
      true
    when :weekdays
      %w|Monday Tuesday Wednesday Thursday Friday|.include? day
    when :weekend
      %w|Saturday Sunday|.include? day
    else
      day.downcase.to_s == @day
    end

    if day_match
      now_string = now.strftime('%H:%M')
      now_string >= @time && !SCache.has_run?(self)
    else
      false
    end
  end

  def to_s
    "#{@time} #{@day}: #{@message}"
  end
end