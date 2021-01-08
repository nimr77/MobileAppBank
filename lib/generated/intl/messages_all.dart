// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that looks up messages for specific locales by
// delegating to the appropriate library.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:implementation_imports, file_names, unnecessary_new
// ignore_for_file:unnecessary_brace_in_string_interps, directives_ordering
// ignore_for_file:argument_type_not_assignable, invalid_assignment
// ignore_for_file:prefer_single_quotes, prefer_generic_function_type_aliases
// ignore_for_file:comment_references

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';

import 'messages_ar_UA.dart' as messages_ar_ua;
import 'messages_en.dart' as messages_en;
import 'messages_en_US.dart' as messages_en_us;
import 'messages_es_ES.dart' as messages_es_es;
import 'messages_fr.dart' as messages_fr;
import 'messages_fr_CA.dart' as messages_fr_ca;
import 'messages_in.dart' as messages_in;
import 'messages_ko.dart' as messages_ko;
import 'messages_pt.dart' as messages_pt;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
  'ar_UA': () => new Future.value(null),
  'en': () => new Future.value(null),
  'en_US': () => new Future.value(null),
  'es_ES': () => new Future.value(null),
  'fr': () => new Future.value(null),
  'fr_CA': () => new Future.value(null),
  'in': () => new Future.value(null),
  'ko': () => new Future.value(null),
  'pt': () => new Future.value(null),
};

MessageLookupByLibrary _findExact(String localeName) {
  switch (localeName) {
    case 'ar_UA':
      return messages_ar_ua.messages;
    case 'en':
      return messages_en.messages;
    case 'en_US':
      return messages_en_us.messages;
    case 'es_ES':
      return messages_es_es.messages;
    case 'fr':
      return messages_fr.messages;
    case 'fr_CA':
      return messages_fr_ca.messages;
    case 'in':
      return messages_in.messages;
    case 'ko':
      return messages_ko.messages;
    case 'pt':
      return messages_pt.messages;
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
    localeName,
    (locale) => _deferredLibraries[locale] != null,
    onFailure: (_) => null);
  if (availableLocale == null) {
    return new Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? new Future.value(false) : lib());
  initializeInternalMessageLookup(() => new CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  return new Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(String locale) {
  var actualLocale = Intl.verifiedLocale(locale, _messagesExistFor,
      onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}
