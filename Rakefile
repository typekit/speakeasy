$LOAD_PATH.push(File.join( File.dirname(__FILE__), 'lib'))
require 'language'
require 'helpers'

task :verify, [:language] do |t, args|
  unless args.language
    failure "You must specify a language to verify. Try rake verify[en]"
  end

  begin
    Language.new(args.language)
  rescue Exception => e
    failure e.message
  else
    success "Valid!"
  end
end

task :visualize, [:language] do |t, args|
  unless args.language
    failure "You must specify a language to visualize. Try rake visualize[en]"
  end

  language = Language.new(args.language)
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
