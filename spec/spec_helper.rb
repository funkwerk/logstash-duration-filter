# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"

def total_seconds(duration = {})
  duration[:days] ||= 0
  duration[:hours] ||= 0
  duration[:minutes] ||= 0
  duration[:seconds] ||= 0

  duration[:seconds] + 60 * (duration[:minutes] + 60 * (duration[:hours] + 24 * duration[:days]))
end
