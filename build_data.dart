import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const fixed = <int, List<String>>{
  7: ['Asia/Ho_Chi_Minh']
};

void main() async {
  final res = await http.get(Uri.parse(
      'https://raw.githubusercontent.com/dmfilipenko/timezones.json/master/timezones.json'));
  if (res.statusCode != 200) throw Exception('Failed to load data');
  final file = File('./lib/src/data.dart');
  final json = jsonDecode(utf8.decode(res.bodyBytes)) as List;
  final fixedKeys = fixed.keys;
  for (var timezone in json) {
    if (fixedKeys.contains(timezone['offset'])) {
      timezone['utc'].addAll(fixed[timezone['offset']]);
    }
  }
  await file
      .writeAsString('library easy_timezone;const data = ${jsonEncode(json)};');
  print('success');
}
