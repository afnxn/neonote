import 'dart:convert';

import 'package:neonote/models/Post.dart';
import 'package:http/http.dart' as http;
class RemoteService{
  Future getPosts(userInput) async{
      var client=http.Client();
      Map<String,Map<String,String>> bo={
        "document": {
          "text": userInput
        }
      };
      var url=Uri.parse('https://nlapi.expert.ai/v2/analyze/standard/en');
      var response=await client.post(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJraWQiOiI1RDVOdFM1UHJBajVlSlVOK1RraXVEZE15WWVMMFJQZ3RaUDJGTlhESHpzPSIsImFsZyI6IlJTMjU2In0.eyJjdXN0b206Y291bnRyeSI6IlVTIiwic3ViIjoiNjhhZGVhYWUtZTc5Zi00ZDk0LWEzNTMtZWRjNDk3ZTljNGMxIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImlzcyI6Imh0dHBzOlwvXC9jb2duaXRvLWlkcC5ldS13ZXN0LTEuYW1hem9uYXdzLmNvbVwvZXUtd2VzdC0xX0FVSGdRMDhDQiIsInBob25lX251bWJlcl92ZXJpZmllZCI6ZmFsc2UsImNvZ25pdG86dXNlcm5hbWUiOiI2OGFkZWFhZS1lNzlmLTRkOTQtYTM1My1lZGM0OTdlOWM0YzEiLCJjdXN0b206Y29tcGFueSI6Ik5lb05vdGUiLCJhdWQiOiIxZWdzNjNxOTlwM3NlYmVjaHNiNzI5dDgwbyIsImV2ZW50X2lkIjoiY2FlMzBiZTAtYWQ2My00YmE3LTlmZWEtNWJhYjMxZjM4ZGY4IiwidG9rZW5fdXNlIjoiaWQiLCJhdXRoX3RpbWUiOjE2Nzg0OTU3NjcsIm5hbWUiOiJNb2hhbW1lZCBBZm5hbiIsImN1c3RvbTpqb2JUaXRsZSI6IkRldmVsb3BlciIsInBob25lX251bWJlciI6IisxMzEyOTc1OTUzMiIsImV4cCI6MTY3ODU4MjE2NywiaWF0IjoxNjc4NDk1NzY3LCJmYW1pbHlfbmFtZSI6Ildhc2VlbSIsImVtYWlsIjoibXdhc2VlM0B1aWMuZWR1IiwiY3VzdG9tOm1hcmtldGluZ0F1dGgiOiIwIn0.INCE58B_WSP3hMVdr09MNdZP9P6jcqis4Whwbc6r4OGWULWHSYPi3OXXWWt3BMvzQPIl9CtJXVxGzcjM5DhhupUZBJy-0FBMOQPuQZtWkB7oZCqROZr4VM8NkQGjE8NhS2XmcPHbkVrAVfjTkecKsI_Wp0ofocuT2cxNcC6PK_4x1iAOGoL2NoUfaHEg1vWkRuTVxZnO-pbkn2XRcqBTTxAcRDjBkgHy28KA8su0PZk7jl4JSQEa_3pRxp_I1YnykeuWKZm2j99gfMh4xayf9z3Z3Tn8oiLrg6VibIyOh_7CqDT9DSizUxFcCmUd6Axix9xlYPIj9oC99yEyleNM6g',}
      ,body:jsonEncode(bo)
          );
      if(response.statusCode==200){
      print(response.statusCode);
        var json=response.body;
        return postFromJson(json);
      }
  }
}