## This is the rakegem gemspec template. Make sure you read and understand
## all of the comments. Some sections require modification, and others can
## be deleted if you don't need them. Once you understand the contents of
## this file, feel free to delete any comments that begin with two hash marks.
## You can find comprehensive Gem::Specification documentation, at
## http://docs.rubygems.org/read/chapter/20
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  ## Leave these as is they will be modified for you by the rake gemspec task.
  ## If your rubyforge_project name is different, then edit it and comment out
  ## the sub! line in the Rakefile
  s.name              = 'speakeasy'
  s.version           = '0.3.0'
  s.date              = '2023-07-14'
  s.rubyforge_project = 'speakeasy'

  ## Make sure your summary is short. The description may be as long
  ## as you like.
  s.summary     = "A mapping of languages to Unicode codepoints"
  s.description = "A mapping of languages to Unicode codepoints"

  ## List the primary authors. If there are a bunch of authors, it's probably
  ## better to set the email to an email list or something. If you don't have
  ## a custom homepage, consider using your GitHub URL or the like.
  s.authors  = ["Matt Colyer"]
  s.email    = 'matt@typekit.com'
  s.homepage = 'http://github.com/typekit/speakeasy'

  ## This gets added to the $LOAD_PATH so that 'lib/NAME.rb' can be required as
  ## require 'NAME.rb' or'/lib/NAME/file.rb' can be as require 'NAME/file.rb'
  s.require_paths = %w[lib]

  ## This sections is only necessary if you have C extensions.
  #s.require_paths << 'ext'
  #s.extensions = %w[ext/extconf.rb]

  ## If your gem includes any executables, list them here.
  #s.executables = ["name"]
  #s.default_executable = 'name'

  ## Specify any RDoc options here. You'll want to add your README and
  ## LICENSE files to the extra_rdoc_files list.
  #s.rdoc_options = ["--charset=UTF-8"]
  #s.extra_rdoc_files = %w[README LICENSE]

  ## List your runtime dependencies here. Runtime dependencies are those
  ## that are needed for an end user to actually USE your code.
  #s.add_dependency('DEPNAME', [">= 1.1.0", "< 2.0.0"])

  ## List your development dependencies here. Development dependencies are
  ## those that are only needed during development
  #s.add_development_dependency('DEVDEPNAME', [">= 1.1.0", "< 2.0.0"])

  s.add_development_dependency('rspec', [">= 3.5.0"])

  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[
    CHANGELOG.md
    Gemfile
    Gemfile.lock
    LICENSE
    README.md
    Rakefile
    data/Deva
    data/Guru
    data/HK
    data/IPA
    data/am
    data/ar
    data/be
    data/bn
    data/ca
    data/chr
    data/cs
    data/da
    data/de
    data/el
    data/en
    data/es
    data/fa
    data/ff
    data/ff-Adlm
    data/fi
    data/fil
    data/fr
    data/gu
    data/he
    data/hi
    data/hr
    data/hu
    data/hy
    data/id
    data/it
    data/ja
    data/kk
    data/kn
    data/ko
    data/lv
    data/mk
    data/ml
    data/ms
    data/mt
    data/nl
    data/no
    data/nqo
    data/panafrican
    data/pl
    data/pt
    data/ro
    data/ru
    data/shi
    data/sk
    data/sl
    data/so-Osma
    data/sr
    data/sv
    data/ta
    data/te
    data/th
    data/tr
    data/uk
    data/ur
    data/vai
    data/vi
    data/zh-Hans
    data/zh-Hant
    data/zh-Latn-pinyin
    lib/speakeasy.rb
    lib/speakeasy/language.rb
    speakeasy.gemspec
    spec/language_spec.rb
    spec/spec_helper.rb
  ]
  # = MANIFEST =

  ## Test files will be grabbed from the file list. Make sure the path glob
  ## matches what you actually use.
  s.test_files = s.files.select { |path| path =~ /^test\/test_.*\.rb/ }
end
