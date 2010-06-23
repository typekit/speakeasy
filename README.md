## Introduction

This project is an attempt to define a mapping between natural languages and
Unicode codepoints.

All languages will be referenced by their IANA language subtags. See 
[http://www.iana.org/assignments/language-subtag-registry](http://www.iana.org/assignments/language-subtag-registry)

Each language's data will be contained in a standalone YAML file contained in
the data directory of this project.

Each yaml file will have the following keys:

* version (currently 1)
* codepoints (currently a list of ranges or a single glyph see data/en for an example)

## Contributing

* Fork lang2unicode
* Create a topic branch - `git checkout -b my_lang`
* Create data/my_lang
* Verify it's correctly formatted - `rake verify[my_lang]`
* Verify it has all the characters you want - `rake visualize[my_lang];open my_lang.html`
* Push to your branch - `git push origin my_lang`
* Create an [issue][issues] with a link to your branch
* That's it!

## Resources
* [http://www.langtag.net/](http://www.langtag.net/)
* [http://github.com/runpaint/unicode-data](http://github.com/runpaint/unicode-data)
