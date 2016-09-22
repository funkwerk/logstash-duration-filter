# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"

def total_seconds(days=0, hours=0, minutes=0, seconds=0)
  seconds + 60 * (minutes + 60 * (hours + 24 * days))
end # def total_seconds
