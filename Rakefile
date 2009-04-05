# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/init.rb'

Hoe.new('init', Aef::Init::VERSION) do |p|
  p.rubyforge_name = 'aef'
  p.developer('Alexander E. Fischer', 'aef@raxys.net')
  p.extra_dev_deps = %w{rspec facets}
  p.url = 'https://rubyforge.org/projects/aef/'
  p.readme_file = 'README.rdoc'
  p.extra_rdoc_files = %w{README.rdoc}
  p.spec_extras = {
    :rdoc_options => ['--main', 'README.rdoc', '--inline-source', '--line-numbers', '--title', 'Init']
  }
end

# vim: syntax=Ruby
