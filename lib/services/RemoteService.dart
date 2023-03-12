import 'dart:convert';

import 'package:neonote/models/Post.dart';
import 'package:http/http.dart' as http;
class RemoteService{
  Future getPosts(userInput) async{
      var client=http.Client();
      print(userInput);
      Map<String,Map<String,String>> bo={
        "document": {
          "text": userInput
        }
      };
      var url=Uri.parse('https://nlapi.expert.ai/v2/analyze/standard/en');
      var response=await client.post(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJraWQiOiI1RDVOdFM1UHJBajVlSlVOK1RraXVEZE15WWVMMFJQZ3RaUDJGTlhESHpzPSIsImFsZyI6IlJTMjU2In0.eyJjdXN0b206Y291bnRyeSI6IlVTIiwic3ViIjoiNjhhZGVhYWUtZTc5Zi00ZDk0LWEzNTMtZWRjNDk3ZTljNGMxIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC5ldS13ZXN0LTEuYW1hem9uYXdzLmNvbVwvZXUtd2VzdC0xX0FVSGdRMDhDQiIsInBob25lX251bWJlcl92ZXJpZmllZCI6ZmFsc2UsImNvZ25pdG86dXNlcm5hbWUiOiI2OGFkZWFhZS1lNzlmLTRkOTQtYTM1My1lZGM0OTdlOWM0YzEiLCJjdXN0b206Y29tcGFueSI6Ik5lb05vdGUiLCJhdWQiOiIxZWdzNjNxOTlwM3NlYmVjaHNiNzI5dDgwbyIsImV2ZW50X2lkIjoiNDQ1OTc1ZDgtMDMyNC00OTgxLThlODQtMWE2MmFhNTc0ZTk5IiwidG9rZW5fdXNlIjoiaWQiLCJhdXRoX3RpbWUiOjE2Nzg2MDAwMjgsIm5hbWUiOiJNb2hhbW1lZCBBZm5hbiIsImN1c3RvbTpqb2JUaXRsZSI6IkRldmVsb3BlciIsInBob25lX251bWJlciI6IisxMzEyOTc1OTUzMiIsImV4cCI6MTY3ODY4NjQyOCwiaWF0IjoxNjc4NjAwMDI4LCJmYW1pbHlfbmFtZSI6Ildhc2VlbSIsImVtYWlsIjoibXdhc2VlM0B1aWMuZWR1IiwiY3VzdG9tOm1hcmtldGluZ0F1dGgiOiIwIn0.T9sdwzOFcWoM6IgBMqzRf4mp2Os8naab-oXUW6hIHJKkImv66Ew6koqVNfVER968MHQaydU5stK58X7Jtc5VI-kzsIaolwqV7i5DbiG2ehtSz8loWmvDlkFoFw-OftQfwdc4NXWIV23AoBd3xPB8Qi1iFPigWxsc6X0gOX-YkkKz9TN9G6uW5ucITtJa3I2gIM_IVnCiEw_8kXDXXvhDh8n0HNUedBC-mg1IKRIsB5v1Ud0Xi78b3BWdM6Bb_pg0ZTbZpg9qdqqkCoVL4n3HgKxV5ZFD3_faRS0oTeBllSpd13oDzZT7Vl_C3YuxeCeOB6e0xnFXyZXzjrpHWjC7BA',}
      ,body:jsonEncode(bo)
          );
      print(response.statusCode);
      if(response.statusCode==200){
        print(response.statusCode);
        var json=response.body;
        return postFromJson(json);
      }
  }
}