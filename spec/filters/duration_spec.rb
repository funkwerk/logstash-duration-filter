# encoding: utf-8
require 'spec_helper'
require "logstash/filters/duration"

describe LogStash::Filters::Duration do
  describe "Parse duration in ISO format" do
    let(:config) do <<-CONFIG
      filter {
        duration {
          iso => 'iso'
        }
      }
    CONFIG
    end

    sample('iso' => "PT1H2M3S") do
      expect(subject.get("duration")).to eq(total_seconds(days=0, hours=1, minutes=2, seconds=3))
    end

    sample('iso' => "PT1H2M3S1000MS") do
      expect(subject.get("duration")).to eq(total_seconds(days=0, hours=1, minutes=2, seconds=3))
    end

    sample('iso' => "-PT1H2M3S") do
      expect(subject.get("duration")).to eq(-total_seconds(days=0, hours=1, minutes=2, seconds=3))
    end

    sample('iso' => "P1D") do
      expect(subject.get("duration")).to eq(total_seconds(days=1))
    end

    sample('iso' => "P1DT2H3M4S") do
      expect(subject.get("duration")).to eq(total_seconds(days=1, hours=2, minutes=3, seconds=4))
    end

    sample('iso' => "P1M") do
      expect(subject.get("duration")).to eq(total_seconds())
    end

    sample('iso' => "PT2M1H3S") do
      expect(subject.get("duration")).to eq(total_seconds())
    end
  end
end
