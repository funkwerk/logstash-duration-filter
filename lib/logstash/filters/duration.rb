# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

class LogStash::Filters::Duration < LogStash::Filters::Base

  config_name "duration"

  config :iso, :validate => :string, :default => "", :required => true

  public
  def register
  end # def register

  public
  def filter(event)
    if @iso
      value = event.get(@iso)
      if not valid(value)
        return event.set("duration", 0)
      end
      days = value[/([0-9]+)D/, 1].to_i
      hours = value[/([0-9]+)H/, 1].to_i
      minutes = value[/([0-9]+)M/, 1].to_i
      seconds = value[/([0-9]+)S/, 1].to_i
      duration = total_seconds(days, hours, minutes, seconds)
      if value[/^-/]
        duration *= -1
      end

      event.set("duration", duration)
    end

    filter_matched(event)
  end # def filter

  private
  def total_seconds(days=0, hours=0, minutes=0, seconds=0)
    seconds + 60 * (minutes + 60 * (hours + 24 * days))
  end # def total_seconds

  private
  def valid(value)
    value[/^(-)?(P([0-9]+D)+(T([0-9]+H)?([0-9]+M)?([0-9]+S)?)?$|P([0-9]+D)?(T([0-9]+H)?([0-9]+M)?([0-9]+S)?)+$)/]
  end

end # class LogStash::Filters::Duration
