import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

// Generate MD5 hash
generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}

// Return an empty string if it is null
String emptyIfNull(String input) => input == null ? "" : input;

String capitalize(String input) {
  if (emptyIfNull(input).length == 0) return "";
  if (input.length == 1) return input.toUpperCase();
  return input[0].toUpperCase() + input.substring(1);
}