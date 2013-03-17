#!/usr/bin/env ruby
ROOT = File.dirname(File.realpath(__FILE__))

require 'jcache'
%w(growl time cache).each{ |s| require File.join(ROOT, 'lib', s) }

latest_reminder = Reminder.times.select(&:should_run_now?).sort_by(&:time).last
SlockGrowl.notify(latest_reminder) if latest_reminder