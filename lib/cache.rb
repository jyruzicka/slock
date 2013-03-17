require 'date'

# The SCache module keeps tabs on which
# times have been displayed currently.
module SCache
  class << self
    attr_accessor :cache

    # Load from cache.
    def load
      # If you're using your own file, replace this with a hash
      # of times. See populate_cache.rb for an example of hash
      # syntax.
      @cache = JCache::Cache['slock']
      @cache[:times].each do |day, hsh| # Times to be notified of
        hsh.each do |time, message|
          Reminder.new(day:day, time:time, message:message)
        end
      end
    end

    # If the last time we ran this was yesterday,
    # the last_accessed value should be set to nil.
    def verify
      @cache[:last_accessed] = nil if
        @cache.has_key?(:last_accessed) &&
        @cache[:last_accessed].to_date != Date.today
    end

    def load_and_verify
      load
      verify
    end

    def has_run? t
      cache_string = cache[:last_accessed].strftime('%H:%M')
      cache_string >= t.time
    end

    def save
      # You'll need to rewrite this if you're not using jcache
      @cache[:last_accessed] = Time.now
      @cache.save
    end
  end
end

SCache::load_and_verify
at_exit{ SCache::save }