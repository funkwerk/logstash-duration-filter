# Logstash Duration Filter

[![Travis Build Status](https://travis-ci.org/funkwerk/logstash-filter-duration.svg)](https://travis-ci.org/funkwerk/logstash-filter-duration)

This is a plugin for [Logstash](https://github.com/elastic/logstash).

## Usage

grok {
  match => {'message' => 'delay=(?<delay>.*)'}
}
if [delay] {
  duration {
    iso => 'delay'
  }
}
