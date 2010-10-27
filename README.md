# Speakeasy

Speakeasy is a ruby library that maps a language to the minimum set of
unicode codepoints required to represent it. The goal is to be minimal
when including codepoints and exclude common punctuation characters when
possible.

## Language definition format

All languages will be referenced by their [IANA language subtags][iana].

Each language's data is a standalone YAML file contained in the data directory
of this project.

    data/
      ca
      cs
      de
      ...

Each YAML file will have the following keys and must be saved in UTF8:

* `version` (currently 2)
* `anglicized_name` (the language name in English)
* `native_name` (the name of the language in the language)
* `codepoints` (currently a list of ranges or a single codepoint see [data/en](tree/master/data/en) for an example).

An example YAML file:

    ---
    version: 2
    anglicized_name: English
    native_name: English
    codepoints:
    - !ruby/range 65..90 # Uppercase
    - !ruby/range 97..122 # Lowercase

Note: codepoints should only include normalized unicode codepoints.

## Contributing

* Fork speakeasy
* Create a topic branch - `git checkout -b my_lang`
* Create or edit `data/my_lang`
* Verify it's correctly formatted - `rake test[my_lang]`
* Verify it has all the characters you want - `rake visualize[my_lang]`
* Push to your branch - `git push origin my_lang`
* Create a github pull request.
* That's it!


## Resources

* [Language Tags RFC5646](http://tools.ietf.org/rfc/bcp/bcp47.txt)
* [http://www.langtag.net/](http://www.langtag.net/)
* [http://github.com/runpaint/unicode-data](http://github.com/runpaint/unicode-data)


## Author

Matt Colyer / matt@typekit.com

Copyright (c) 2010 Typekit. Licensed under the Apache 2.0 license.


[iana]: http://www.iana.org/assignments/language-subtag-registry
