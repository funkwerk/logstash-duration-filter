# encoding: utf-8
require 'logstash/filters/base'
require 'logstash/namespace'

class LogStash::Filters::Duration < LogStash::Filters::Base

  config_name 'duration'

  config :iso, :validate => :string, :default => '', :required => true

  public
  def register
  end

  public
  def filter(event)
    return unless @iso
    event.set('duration', parse(event.get(@iso)))
    filter_matched(event)
  end

  def parse(value)
    match = match_pattern value
    return 0 if match.nil?

    duration = total_seconds(
      match[:days].to_i,
      match[:hours].to_i,
      match[:minutes].to_i,
      match[:seconds].to_i
    )
    duration = -duration if match[:negate] == '-'
    duration
  end

  def match_pattern(value)
    pattern = /^(?<negate>-)?P((?<days>\d+)D)?(T((?<hours>\d+)H)?((?<minutes>\d+)M)?((?<seconds>\d+)(.(?<milliseconds>\d+))?S)?)?$/

    value.match pattern
  end

  def total_seconds(days, hours, minutes, seconds)
    seconds + 60 * (minutes + 60 * (hours + 24 * days))
  end
end
