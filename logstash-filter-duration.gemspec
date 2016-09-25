Gem::Specification.new do |s|
  s.name = 'logstash-filter-duration'
  s.version = '0.1.1'
  s.licenses = ['Apache License 2.0']
  s.summary = 'This filter parses ISO durations and converts it into seconds.'
  s.description = 'This gem is a Logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/logstash-plugin install gemname. This gem is not a stand-alone program'
  s.authors = ['Funkwerk AG']
  s.require_paths = ['lib']
  s.homepage = 'https://github.com/funkwerk/logstash-duration-filter/'
  s.files = Dir['lib/**/*', 'spec/**/*', '*.gemspec', '*.md', 'Gemfile']
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
  s.metadata = { 'logstash_plugin' => 'true', 'logstash_group' => 'filter' }
  s.add_development_dependency 'logstash-devutils'
end
