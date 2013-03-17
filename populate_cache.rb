require 'jcache'

cache = JCache::Cache['slock']

times = {
  weekdays: {
    "08:45" => "You should think about starting work soon...",
    "09:00" => "It's about time to start work now.",
    "13:00" => "Back to work.",
    "15:00" => "Have a break! Afternoon tea time",
    "17:00" => "End of the work day."
  },
  always: {
    "10:30" => "Have a break! Morning tea time.",
    "12:00" => "Have a break! Lunch time.",
    "21:00" => "Do you need to do anything before you go to bed?",
    "22:00" => "Bed time."
  }
}

cache[:times] = times
cache.save