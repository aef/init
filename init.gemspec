# encoding: UTF-8
=begin
Copyright Alexander E. Fischer <aef@raxys.net>, 2009-2012

This file is part of Init.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
=end

require File.expand_path('../lib/aef/init/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'init'
  s.version     = Aef::Init::VERSION.dup
  s.authors     = ['Alexander E. Fischer']
  s.email       = ['aef@raxys.net']
  s.homepage    = 'http://github.com/aef/init'
  s.license     = 'ISC'
  s.summary     = 'Clean and simple *nix init scripts with Ruby'
  s.description = <<-DESCRIPTION
Init is a lightweight framework for writing readable, reusable *nix init
scripts in Ruby.
  DESCRIPTION

  s.rubyforge_project = nil
  s.has_rdoc          = 'yard'
  s.extra_rdoc_files  = ['HISTORY.md', 'LICENSE.md']

  s.files         = `git ls-files`.lines.map(&:chomp)
  s.test_files    = `git ls-files -- {test,spec,features}/*`.lines.map(&:chomp)
  s.executables   = `git ls-files -- bin/*`.lines.map{|f| File.basename(f.chomp) }
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 1.8.7'

  s.add_development_dependency('bundler', '~> 1.1.5')
  s.add_development_dependency('rake', '~> 0.9.2.2')
  s.add_development_dependency('rspec', '~> 2.11.0')
  s.add_development_dependency('simplecov', '~> 0.6.4')
  s.add_development_dependency('pry', '~> 0.9.10')
  s.add_development_dependency('yard', '~> 0.8.2.1')

  s.cert_chain = "#{ENV['GEM_CERT_CHAIN']}".split(':')
  s.signing_key = ENV['GEM_SIGNING_KEY']
end
