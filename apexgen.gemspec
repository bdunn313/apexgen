# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','apexgen','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'apexgen'
  s.version = Apexgen::VERSION
  s.author = 'Brad Dunn'
  s.email = 'brad@braddunn.com'
  s.homepage = 'https://github.com/bdunn313/apexgen'
  s.platform = Gem::Platform::RUBY
  s.summary =     %q{Apex code scaffolder for use on salesforce/force.com platforms}
  s.description = %q{Apexgen allows you to generate object XML, 
                     create scaffolding for triggers, classes and class methods, 
                     as well as initialize a project. Currently, only object 
                     XML generation is supported, however the other features described
                     above are in active development.}
  s.license = 'MIT'
# Add your other files here if you make them
  s.files = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','apexgen.rdoc']
  s.rdoc_options << '--title' << 'apexgen' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'apexgen'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba', '~> 0.5.1')
  s.add_runtime_dependency('gli','2.5.0')
  s.add_runtime_dependency('active_support', '~> 3.0.0')
end
