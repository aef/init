# encoding: UTF-8
=begin
Copyright Alexander E. Fischer <aef@raxys.net>, 2009-2013

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

Gem::Specification.new do |gem|
  gem.name    = "init"
  gem.version = Aef::Init::VERSION.dup
  gem.authors = ["Alexander E. Fischer"]
  gem.email   = ["aef@raxys.net"]
  gem.description = <<-DESCRIPTION
Init is a lightweight framework for writing readable, reusable *nix init
scripts in Ruby.
  DESCRIPTION
  gem.summary  = "Clean and simple *nix init scripts with Ruby"
  gem.homepage = "https://aef.name/"
  gem.license  = "ISC"
  gem.has_rdoc = "yard"
  gem.extra_rdoc_files  = ["HISTORY.md", "LICENSE.md"]
  gem.rubyforge_project = nil

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = '>= 1.9.3'

  gem.add_development_dependency('rake')
  gem.add_development_dependency('bundler')
  gem.add_development_dependency('rspec', '~> 2.14.1')
  gem.add_development_dependency('simplecov')
  gem.add_development_dependency('pry')
  gem.add_development_dependency('yard')

  gem.cert_chain = "#{ENV['GEM_CERT_CHAIN']}".split(':')
  gem.signing_key = ENV['GEM_SIGNING_KEY']
end
