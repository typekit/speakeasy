require 'rubygems'
require 'rake'
require 'date'

#############################################################################
#
# Helper functions
#
#############################################################################

def name
  @name ||= Dir['*.gemspec'].first.split('.').first
end

def version
  line = File.read("lib/#{name}.rb")[/^\s*VERSION\s*=\s*.*/]
  line.match(/.*VERSION\s*=\s*['"](.*)['"]/)[1]
end

def date
  Date.today.to_s
end

def rubyforge_project
  name
end

def gemspec_file
  "#{name}.gemspec"
end

def gem_file
  "#{name}-#{version}.gem"
end

def replace_header(head, header_name)
  head.sub!(/(\.#{header_name}\s*= ').*'/) { "#{$1}#{send(header_name)}'"}
end

#############################################################################
#
# Standard tasks
#
#############################################################################
desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I ./lib/ -r ./lib/#{name}.rb"
end

#############################################################################
#
# Custom tasks (add your own tasks here)
#
#############################################################################
$LOAD_PATH.push(File.join(File.dirname(__FILE__), 'lib'))
require 'speakeasy'
require 'ostruct'

task :default do
  puts "Verifying all languages..."
  Dir.glob("data/*") do |file|
    language = File.basename(file)
    Rake::Task["test"].execute(OpenStruct.new(:language => language))
  end
  puts "Complete."
end

def success(message)
  puts "\033[32m#{message}\033[0m"
end

def failure(message)
  puts "\033[31m#{message}\033[0m"
  exit -1
end

desc "Take a comma separated list of hex values and print a list of characters and ranges"
task :convert, [:file] do |t, args|
  data = File.read(args.file)
  ranges = data.split(",")
  ranges = ranges.map do |range|
    if range.include? '-'
      range = range.split("-").map{ |s| s.to_i(16) }
      "!ruby/range #{range[0]}..#{range[1]}"
    else
      range.to_i(16)
    end
  end

  puts ranges.to_yaml.gsub("\"","")
end

desc "Verifies that a language loads correctly."
task :test, [:language] do |t, args|
  unless args.language
    failure "You must specify a language to verify. Try rake test[en]"
  end

  begin
    Speakeasy::Language.new(args.language)
  rescue Exception => e
    failure e.message
  else
    success "#{args.language}: Valid!"
  end
end

desc "Generates an HTML file which previews all of the characters included"
task :visualize, [:language] do |t, args|
  unless args.language
    failure "You must specify a language to visualize. Try rake visualize[en]"
  end

  language = Speakeasy::Language.new(args.language)
  filename = "#{args.language}.html"

  File.open(filename, "w") do |f|
    f.write <<-eos
      <DOCTYPE html>
      <html>
      <head>
      <meta charset="UTF-8">
      <title>#{language.anglicized_name}</title>
      <style>
        table {
          margin: 1em 0;
          font-size: 2em;
          border-top: 1px #ddd solid;
          border-left: 1px #ddd solid;
        }

        td {
          width: 80px;
          height: 70px;
          text-align: center;
          border-bottom: 1px #ddd solid;
          border-right: 1px #ddd solid;
        }
      </style>
      </head>
      <body>
      <h1>#{language.anglicized_name} (#{language.native_name})</h1>
      <table cellpadding="0" cellspacing="0">
    eos

    language.codepoints.each_slice(8) do |codepoints|
      f.write "<tr>"
      codepoints.each do |codepoint|
        f.write "<td>&##{codepoint};</td>"
      end
      f.write "</tr>"
    end

    f.write <<-eos
      </table>
      </body>
      </html>
    eos

    `open #{filename}`
    success "Open #{filename} to view the results"
  end
end


#############################################################################
#
# Packaging tasks
#
#############################################################################

task :release => :build do
  unless `git branch` =~ /^\* master$/
    puts "You must be on the master branch to release!"
    exit!
  end
  sh "git commit --allow-empty -a -m 'Release #{version}'"
  sh "git tag v#{version}"
  sh "git push origin master"
  sh "git push origin v#{version}"
end

task :build => :gemspec do
  sh "mkdir -p pkg"
  sh "gem build #{gemspec_file}"
  sh "mv #{gem_file} pkg"
end

task :gemspec => :validate do
  # read spec file and split out manifest section
  spec = File.read(gemspec_file)
  head, manifest, tail = spec.split("  # = MANIFEST =\n")

  # replace name version and date
  replace_header(head, :name)
  replace_header(head, :version)
  replace_header(head, :date)
  #comment this out if your rubyforge_project has a different name
  replace_header(head, :rubyforge_project)

  # determine file list from git ls-files
  files = `git ls-files`.
    split("\n").
    sort.
    reject { |file| file =~ /^\./ }.
    reject { |file| file =~ /^(rdoc|pkg)/ }.
    map { |file| "    #{file}" }.
    join("\n")

  # piece file back together and write
  manifest = "  s.files = %w[\n#{files}\n  ]\n"
  spec = [head, manifest, tail].join("  # = MANIFEST =\n")
  File.open(gemspec_file, 'w') { |io| io.write(spec) }
  puts "Updated #{gemspec_file}"
end

task :validate do
  libfiles = Dir['lib/*'] - ["lib/#{name}.rb", "lib/#{name}"]
  unless libfiles.empty?
    puts "Directory `lib` should only contain a `#{name}.rb` file and `#{name}` dir."
    exit!
  end
  unless Dir['VERSION*'].empty?
    puts "A `VERSION` file at root level violates Gem best practices."
    exit!
  end
end
