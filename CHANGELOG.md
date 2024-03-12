0.4.0 / 2024-03-12
==================
  * Removed 4 characters from Arabic:
    * U+0615 ARABIC SMALL HIGH TAH
    * U+066A ARABIC PERCENT SIGN
    * U+066B ARABIC DECIMAL SEPARATOR
    * U+066C ARABIC THOUSANDS SEPARATOR

  * Removed 1 character from Devanagari:
    * U+0950 DEVANAGARI OM

  * Removed 1 character from Gurumukhi:
    * U+0A51 GURMUKHI SIGN UDAAT

  * Removed 1 character from Hebrew:
    * U+05F4 HEBREW PUNCTUATION GERSHAYIM

  * Removed 5 characters from Japanese:
    * U+3094 HIRAGANA LETTER VU
    * U+309B KATAKANA-HIRAGANA VOICED SOUND MARK
    * U+309C KATAKANA-HIRAGANA SEMI-VOICED SOUND MARK
    * U+309D HIRAGANA ITERATION MARK
    * U+309E HIRAGANA VOICED ITERATION MARK

  * Removed 2 characters from Kannada:
    * U+0964 DEVANAGARI DANDA
    * U+0965 DEVANAGARI DOUBLE DANDA

  * Removed 8 characters from Malayalam:
    * U+0D3D MALAYALAM SIGN AVAGRAHA
    * U+0D4E MALAYALAM LETTER DOT REPH
    * U+0D79 MALAYALAM DATE MARK
    * U+0D7A MALAYALAM LETTER CHILLU NN
    * U+0D7B MALAYALAM LETTER CHILLU N
    * U+0D7D MALAYALAM LETTER CHILLU L
    * U+0D7E MALAYALAM LETTER CHILLU LL
    * U+0D7F MALAYALAM LETTER CHILLU K

  * Removed 2 characters from Tamil:
    * U+0B9D (unassigned)
    * U+0BFA TAMIL NUMBER SIGN

  * Removed 4 characters from Telugu:
    * U+0C00 TELUGU SIGN COMBINING CANDRABINDU
    * U+0C58 TELUGU LETTER TSA
    * U+0C59 TELUGU LETTER DZA
    * U+0C5A TELUGU LETTER RRRA

0.3.0 / 2023-07-14
==================
  * Add Fula (Adlam script).

0.2.0 / 2023-07-13
==================
  * Fix Tamil and Gurmukhi character ranges.
  * Add Amharic, Fula, N’Ko, Pan African (Latin & IPA), Tachelhit,
    Somali (Osmanya script), Urdu, and Vai.

0.1.31 / 2022-11-14
==================
  * Revert the version number of Hebrew and Devanagari definitions; no content
    changes.

0.1.30 / 2022-09-27
==================
  * Major updates to the Hebrew and Devanagari definitions; the contents were
    based on the `exemplarCharacters` property of the latest (v41) CLDR data.
    http://unicode.org/Public/cldr/latest

0.1.29 / 2022-09-26
==================
  * Remove 5 characters from Japanese.
    * U+3095, HIRAGANA LETTER SMALL KA
    * U+3096, HIRAGANA LETTER SMALL KE
    * U+3099, COMBINING KATAKANA-HIRAGANA VOICED SOUND MARK
    * U+309A, COMBINING KATAKANA-HIRAGANA SEMI-VOICED SOUND MARK
    * U+309F, HIRAGANA DIGRAPH YORI

0.1.28 / 2022-09-21
==================
  * Remove U+0178 (LATIN CAPITAL LETTER Y WITH DIAERESIS) from French.

0.1.27 / 2022-09-21
==================
  * Remove "Other combining marks" from Arabic.
    * U+0656, ARABIC SUBSCRIPT ALEF
    * U+0657, ARABIC INVERTED DAMMA
    * U+0658, ARABIC MARK NOON GHUNNA
    * U+0659, ARABIC ZWARAKAY
    * U+065A, ARABIC VOWEL SIGN SMALL V ABOVE
    * U+065B, ARABIC VOWEL SIGN INVERTED SMALL V ABOVE
    * U+065C, ARABIC VOWEL SIGN DOT BELOW
    * U+065D, ARABIC REVERSED DAMMA
    * U+065E, ARABIC FATHA WITH TWO DOTS

0.1.26 / 2022-06-08
==================
  * Remove U+02C7 (CARON) and U+02C9 (MODIFIER LETTER MACRON) from Simplified Chinese.

0.1.25 / 2022-05-31
==================
  * Correct integer representation of U+0C48 (TELUGU VOWEL SIGN AI)

0.1.24 / 2021-06-16
==================
  * Remove « and » from Finnish

0.1.23 / 2021-06-07
==================
  * Add Indonesian
  * Add Finnish
  * Add Filipino
  * Add Malay
  * Add Kazakh
  * Add Romanian
  * Add Croatian
  * Add Slovak
  * Add Hindi
  * Add Persian / Farsi

0.1.22 / 2020-11-11
==================
  * Add Pinyin

0.1.21 / 2020-08-20
==================
  * Update glyphs in KO.
  * Add Latvian.

0.1.20 / 2018-02-16
==================
  * Reduce required glyphs for Malayalam.

0.1.19 / 2018-02-12
==================
  * Remove Ruble symbol to Russian, intend to readd in future PR.

0.1.18 / 2018-01-12
==================
  * Add Ruble symbol to Russian
  * Add definitions for Telugu, Malayalam and IPA


0.1.17 / 2017-01-18
==================

  * Reduce codepoints for Arabic to be more inclusive.
  * Add Definitions for Norwegian, Danish, Macedonian, Belarusian, Ukrainian and refine Russian.

0.1.16 / 2015-08-24
==================

  * Add missing Unicode codepoints in Vietnamese definition for Ỡ and Ỹ.
  * Add Definition for Armenian.

0.1.15 / 2015-04-07
==================

  * Import Unicode Consortium data for Thai and Cherokee support.

0.1.14 / 2015-03-17
==================

  * Import Unicode Consortium data for Kannada support.

0.1.13 / 2015-01-20
==================

  * Include the 'à' and 'î' for Italian definition.

0.1.12 / 2015-01-15
==================

  * Innocuous change to properly release gem.

0.1.11 / 2015-01-15
==================

  * Import Unicode Consortium data fro Bengali support.

0.1.10 / 2014-09-16
==================

  * Innocuous change to properly release gem.

0.1.9 / 2014-09-16
==================

  * Import CLDR Data for Vietnamese support.

0.1.8 / 2014-08-19
==================

  * Define Turkish and Hungarian.

0.1.7 / 2014-07-25
==================

  * Re-define Western language definitions to conform to Unicode Consortium's description of languages.
  * Properly name Greek source file as 'el' and not 'gr' to conform to IANA Language Tag Registry.

0.1.6 / 2014-06-25
==================

  * Adds the following language definitions:
  * Traditional Chinese (zh-Hant)
  * Simplified Chinese (zh-Hans)
  * Hong Kong Chinese (HK)
  * Japanese (ja) * N.B. - this defines Hiragana only and does not include Katakana or Kanji
  * Korean (ko)
  * Devanagari (Deva)
  * Gujarait (gu)
  * Gurmukhi (Guru)
  * Tamil (ta)
  * Arabic (ar)
  * Hebrew (he)


0.1.5 / 2013-03-18
==================

  * Add Y-diaeresis to French glyphs

0.1.4 / 2011-08-24
==================

  * Add Language#language_id
  * Add Language.all

0.1.3 / 2010-10-27
==================

  * Refine the README
  * Create a visualize_all task to generate all files.
  * Improved the visualization page.
  * Add Greek.
  * Add Catalan
  * Add Czech.
  * Add Polish.
  * Add Italian.
  * Add Dutch.
  * Add Swedish.
  * Add Portuguese.
