# Speakeasy

Speakeasy is a ruby library that maps a language to the minimum set of
unicode codepoints required to represent it. Full support requires every
mandatory character in the profile, including its required punctuation,
currency characters, and numerals. There is no universal ASCII baseline.

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

## Generated definitions

65 of the 78 profiles use generated requirements from
[Parlance](https://github.com/OneAdobe/af-parlance), revision
`d4faf5c545045beed464705bda870c04166e1aa2`. The producer and coverage policy
are recorded in `parlance-manifest.json`. Each refreshed definition retains its
version-2 format, document marker, ranges, and glyph comments, with a minimal
`parlance` reference to the canonical schema and shared definition hash.

The ten legacy profiles (`IPA`, `Phag`, `ff-Adlm`, `khb`, `km`, `nqo`,
`panafrican`, `shi`, `so-Osma`, `tdd`) remain unchanged. The existing Chinese
definitions (`HK`, `zh-Hans`, `zh-Hant`) also remain unchanged and are outside
the generated set because exact replacement repertoires are not yet approved.
Japanese remains a kana-only profile.

The generated requirements include the configured base, punctuation, currency,
and numeral categories, not optional auxiliary characters. Parlance is a
build-time file generator, not a runtime dependency. Third-party licenses and
notices accompany its generated data.

## Example

    require 'rubygems'
    require 'speakeasy'

    Speakeasy::Language.each do |language|
      print "#{language.anglicized_name} (#{language.native_name}) "
      puts language.codepoints[0..10].inspect
    end

It should return

    Catalan (Català) [65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75]
    Czech (Česky) [65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75]
    German (Deutsch) [65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75]
    English (English) [65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75]
    ....

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

## Copyright and License

Copyright (c) 2010 Adobe Systems Incorporated. Licensed under the Apache 2.0 license

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

[iana]: http://www.iana.org/assignments/language-subtag-registry
