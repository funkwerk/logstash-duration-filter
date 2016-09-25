# encoding: utf-8
require 'logstash/filters/base'
require 'logstash/namespace'

class LogStash::Filters::Duration < LogStash::Filters::Base

  config_name 'duration'

  config :iso, :validate => :string, :default => '', :required => true

  public def register
  end

  public def filter(event)
    return unless @iso
    event.set('duration', parse(event.get(@iso)))

    filter_matched(event)
  end

  def parse(value)
    return 0 unless valid?(value)
    days = value[/([0-9]+)D/, 1].to_i
    hours = value[/([0-9]+)H/, 1].to_i
    minutes = value[/([0-9]+)M/, 1].to_i
    seconds = value[/([0-9]+)S/, 1].to_i
    duration = total_seconds(days, hours, minutes, seconds)
    duration = -duration if value[/^-/]
    duration
  end

  def total_seconds(days = 0, hours = 0, minutes = 0, seconds = 0)
    seconds + 60 * (minutes + 60 * (hours + 24 * days))
  end

  def valid?(value)
    value[/^(-)?P([0-9]+D)?(T([0-9]+H)?([0-9]+M)?([0-9]+S)?([0-9]+MS)?)?$/]
  end
end
