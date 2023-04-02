import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> generateText(String prompt) async {
  final apiUrl = Uri.parse('https://api.openai.com/v1/completions');
  final apiKey = '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';
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };
  print(prompt);
  final body = jsonEncode({
  "model": "text-davinci-003",
    'prompt':"generate a maximum of 3 and at least 1 minimum classified tags with highest confidence rate for this text-'$prompt'- return it in string format with the tags seperated by comma"

  });
  final response = await http.post(apiUrl, headers: headers, body: body);
  final responseBody = jsonDecode(response.body);
  print(response.body);
  print(responseBody);
  final generatedText = responseBody['choices'][0]['text'];
  // print(generatedText.length);
  // List<dynamic> list = jsonDecode(generatedText);
  List<String> list = generatedText.trimLeft().split(',');
  List<String> trimmedList = list.map((str) => str.trim()).toList();
  List<String> trimmedList2 = trimmedList.map((str) => str.replaceAll('"', '')).toList();
  return  trimmedList;
}