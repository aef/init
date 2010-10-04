# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'semver'

Hoe.spec 'init' do |p|
  developer('Alexander E. Fischer', 'aef@raxys.net')

  extra_deps << ['semver', '>= 0.2.2']

  extra_dev_deps << ['rspec', '>= 1.3.0']
  extra_dev_deps << ['facets', '>= 2.8.4']

  self.version = SemVer.find.format '%M.%m.%p' 
  self.rubyforge_name = 'aef'
  self.url = 'https://rubyforge.org/projects/aef/'
  self.readme_file = 'README.rdoc'
  self.extra_rdoc_files = %w{README.rdoc}
  self.spec_extras = {
    :rdoc_options => ['--main', 'README.rdoc', '--inline-source', '--line-numbers', '--title', 'Init']
  }
end

# vim: syntax=Ruby
