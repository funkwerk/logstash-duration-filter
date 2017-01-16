# Logstash Duration Filter

[![Travis Build Status](https://travis-ci.org/funkwerk/logstash-filter-duration.svg)](https://travis-ci.org/funkwerk/logstash-filter-duration)
[![Downloads](https://img.shields.io/gem/dt/logstash-filter-duration.svg)](https://rubygems.org/gems/logstash-filter-duration)
[![Latest Tag](https://img.shields.io/github/tag/funkwerk/logstash-filter-duration.svg)](https://rubygems.org/gems/logstash-filter-duration)

This is a plugin for [Logstash](https://github.com/elastic/logstash).

## Usage

```ruby
grok {
  match => {'message' => 'delay=(?<delay>.*)'}
}
if [delay] {
  duration {
    iso => 'delay'
  }
}
```
