require 'ruby-growl'

class SlockGrowl
  def self.notify t
    if !@instance
      @instance = Growl.new 'localhost', 'Slock'
      @instance.add_notification 'alarm'
    end

    @instance.notify 'alarm', t.time, t.message, 0, true
  end
end
