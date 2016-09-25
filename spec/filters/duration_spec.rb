# encoding: utf-8
require 'spec_helper'
require 'logstash/filters/duration'

describe LogStash::Filters::Duration do
  describe 'Parse duration in ISO format' do
    let(:config) do <<-CONFIG
      filter {
        duration {
          iso => 'iso'
        }
      }
    CONFIG
    end

    sample('iso' => 'P1D') do
      expect(subject.get('duration')).to eq(total_seconds(days: 1))
    end

    sample('iso' => 'PT1H') do
      expect(subject.get('duration')).to eq(total_seconds(hours: 1))
    end

    sample('iso' => 'PT1M') do
      expect(subject.get('duration')).to eq(total_seconds(minutes: 1))
    end

    sample('iso' => 'PT1S') do
      expect(subject.get('duration')).to eq(total_seconds(seconds: 1))
    end

    sample('iso' => 'PT1.2S') do
      expect(subject.get('duration')).to eq(total_seconds(seconds: 1))
    end

    sample('iso' => 'P1DT2H3M4S') do
      expect(subject.get('duration')).to eq(total_seconds(days: 1, hours: 2, minutes: 3, seconds: 4))
    end

    sample('iso' => '-P1DT2H3M4S') do
      expect(subject.get('duration')).to eq(-total_seconds(days: 1, hours: 2, minutes: 3, seconds: 4))
    end
  end
end
