# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{init}
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alexander E. Fischer"]
  s.cert_chain = ["/home/dimedo/.gem/gem-public_cert.pem"]
  s.date = %q{2010-10-04}
  s.description = %q{Clean and simple *nix init scripts with Ruby}
  s.email = ["aef@raxys.net"]
  s.extra_rdoc_files = ["COPYING.txt", "History.txt", "Manifest.txt", "README.rdoc"]
  s.files = [".semver", "COPYING.txt", "History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "examples/mongrel.rb", "examples/murmur.rb", "init.gemspec", "lib/aef/init.rb", "lib/aef/init/init.rb", "spec/bin/mock_daemon.rb", "spec/bin/simple_init.rb", "spec/init_spec.rb", "spec/spec_helper.rb"]
  s.homepage = %q{https://rubyforge.org/projects/aef/}
  s.rdoc_options = ["--main", "README.rdoc", "--inline-source", "--line-numbers", "--title", "Init"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{aef}
  s.rubygems_version = %q{1.3.7}
  s.signing_key = %q{/home/dimedo/.gem/gem-private_key.pem}
  s.summary = %q{Clean and simple *nix init scripts with Ruby}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<semver>, [">= 0.2.2"])
      s.add_development_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_development_dependency(%q<facets>, [">= 2.8.4"])
      s.add_development_dependency(%q<hoe>, [">= 2.6.2"])
    else
      s.add_dependency(%q<semver>, [">= 0.2.2"])
      s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
      s.add_dependency(%q<rspec>, [">= 1.3.0"])
      s.add_dependency(%q<facets>, [">= 2.8.4"])
      s.add_dependency(%q<hoe>, [">= 2.6.2"])
    end
  else
    s.add_dependency(%q<semver>, [">= 0.2.2"])
    s.add_dependency(%q<rubyforge>, [">= 2.0.4"])
    s.add_dependency(%q<rspec>, [">= 1.3.0"])
    s.add_dependency(%q<facets>, [">= 2.8.4"])
    s.add_dependency(%q<hoe>, [">= 2.6.2"])
  end
end
