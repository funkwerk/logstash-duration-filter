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
      expect(subject.get("duration")).to eq(3_723)
    end

    sample('iso' => "-PT1H2M3S") do
      expect(subject.get("duration")).to eq(-3_723)
    end

    sample('iso' => "P1D") do
      expect(subject.get("duration")).to eq(86_400)
    end

    sample('iso' => "P1DT2H3M4S") do
      expect(subject.get("duration")).to eq(93_784)
    end

    sample('iso' => "P1M") do
      expect(subject.get("duration")).to eq(0)
    end

    sample('iso' => "PT2M1H3S") do
      expect(subject.get("duration")).to eq(0)
    end
  end
end
