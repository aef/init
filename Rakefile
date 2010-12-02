# -*- ruby -*-

$LOAD_PATH.unshift('lib')

require 'hoe'
require 'aef/init'

Hoe.spec 'init' do
  developer('Alexander E. Fischer', 'aef@raxys.net')

  extra_dev_deps << ['rspec', '~> 2.2.0']
  extra_dev_deps << ['facets', '~> 2.9.0']

  self.version = Aef::Init::VERSION 
  self.rubyforge_name = 'aef'
  self.url = 'https://rubyforge.org/projects/aef/'
  self.readme_file = 'README.rdoc'
  self.extra_rdoc_files = %w{README.rdoc}
  self.spec_extras = {
    :rdoc_options => ['--main', 'README.rdoc', '--inline-source', '--line-numbers', '--title', 'Init']
  }
end

# vim: syntax=Ruby
