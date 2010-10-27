## Introduction

This project is an attempt to define a mapping between natural languages and
Unicode codepoints.

All languages will be referenced by their IANA language subtags. See 
[http://www.iana.org/assignments/language-subtag-registry](http://www.iana.org/assignments/language-subtag-registry)

Each language's data will be contained in a standalone YAML file contained in
the data directory of this project.

Each yaml file will have the following keys (and should be saved in
UTF8):

* version (currently 2)
* codepoints (currently a list of ranges or a single glyph see data/en for an example)
* anglicized_name (the language name in English)
* native_name (the name of the language in the language)

## Contributing

* Fork speakeasy
* Create a topic branch - `git checkout -b my_lang`
* Create data/my_lang
* Verify it's correctly formatted - `rake test[my_lang]`
* Verify it has all the characters you want - `rake visualize[my_lang]`
* Push to your branch - `git push origin my_lang`
* Create a github pull request.
* That's it!

## Resources
* [Language Tags RFC5646](http://tools.ietf.org/rfc/bcp/bcp47.txt)
* [http://www.langtag.net/](http://www.langtag.net/)
* [http://github.com/runpaint/unicode-data](http://github.com/runpaint/unicode-data)
