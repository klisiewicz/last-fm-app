import 'dart:convert';
import 'dart:io';

Future<Map<String, dynamic>> readJsonFromFile(String fileName) async {
  final file = File('test/res/$fileName.json');
  final fileString = await file.readAsString();
  return jsonDecode(fileString) as Map<String, dynamic>;
}
