$LOAD_PATH.push(File.join( File.dirname(__FILE__), 'lib'))
require 'lang2unicode'
require 'ostruct'

def success(message)
  puts "\033[32m#{message}\033[0m"
end

def failure(message)
  puts "\033[31m#{message}\033[0m"
  exit -1
end

task :default do
  puts "Verifying all languages..."
  Dir.glob("data/*") do |file|
    language = File.basename(file)
    Rake::Task["verify"].execute(OpenStruct.new(:language => language))
  end
  puts "Complete."
end

task :verify, [:language] do |t, args|
  unless args.language
    failure "You must specify a language to verify. Try rake verify[en]"
  end

  begin
    Lang2Unicode::Language.new(args.language)
  rescue Exception => e
    failure e.message
  else
    success "#{args.language}: Valid!"
  end
end

task :visualize, [:language] do |t, args|
  unless args.language
    failure "You must specify a language to visualize. Try rake visualize[en]"
  end

  language = Lang2Unicode::Language.new(args.language)
  filename = "#{args.language}.html"

  File.open(filename, "w") do |f|
    f.write <<-eos
      <DOCTYPE html>
      <html>
      <head>
      <meta charset="UTF-8">
      <title>Font name - WFS Metrics</title>
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
      <table cellpadding="0" cellspacing="0">
    eos

    language.codepoints.each_slice(16) do |codepoints|
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

    success "Open #{filename} to view the results"
  end
end
