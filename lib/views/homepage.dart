import 'package:flutter/material.dart';
import 'package:neonote/models/Post.dart';
import 'package:neonote/services/RemoteService.dart';
import 'dart:convert';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) :super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  Post? posts;
  List<String> myList = [];
  var isLoaded=false;
  TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<_ButtonTargetState> _buttonTargetKey = GlobalKey<_ButtonTargetState>();
  // String tx='';
  // @override
  // void initState(){
  //   super.initState();
  //   getdata();
  // }
 List<String> create_list(L){
   List<String> emails = L.map((user) => user.value).toList();
   return emails;
 }
 void  _getdata() async{
    String userInput = _textEditingController.text;

    posts= await RemoteService().getPosts(userInput);
    posts!.data.mainLemmas.removeWhere((element) => element.score<10);
    myList=posts!.data.mainLemmas.map((user) => user.value).toList();
    if (posts != null){
      setState(() {
        isLoaded=true;

      });
    }
  }
  @override
  Widget build(BuildContext context){
      return Scaffold(
      appBar: AppBar(
          title:Text('Posts'),

      ),
          body:Column(
            children: <Widget>[
              Expanded(child: TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: 'Enter your text here',
                  border: OutlineInputBorder(),
                ),
              ),
              ),
              Expanded(child: ElevatedButton(
                onPressed: _getdata,
                child: Text('Call API'),
              ),),
              // if(isLoaded!=false)
              //   Expanded(child: ListView.builder(
              //     itemCount:posts!.data.mainLemmas.length,
              //     itemBuilder: (context,index){
              //       return Container(
              //         child: Text(posts!.data.mainLemmas[index].value),
              //       );
              //     },
              //   ),
              // ),
              if(isLoaded!=false)
                Expanded(child:Row(
                children: <Widget>[
                  Expanded(
                    child: ButtonList(
                      items: myList,
                      onAddItem: (item) {
                        final buttonTargetState = _buttonTargetKey.currentState;
                        buttonTargetState?.addItem(item);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: ButtonTarget(
                      key: _buttonTargetKey,
                    ),
                  ),
                ],
              ),),

            ],

          ),



      );
  }
}
class ButtonList extends StatefulWidget {
  final List<String> items;
  final void Function(String) onAddItem;

  ButtonList({required this.items, required this.onAddItem});

  @override
  _ButtonListState createState() => _ButtonListState();
}

class _ButtonListState extends State<ButtonList> {
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    _items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _items[index];

        return ListTile(
          title: Text(item),
          leading: Icon(Icons.menu),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              widget.onAddItem(item);
              setState(() {
                _items.removeAt(index);
              });
            },
          ),
        );
      },
    );
  }
}

class ButtonTarget extends StatefulWidget {
  const ButtonTarget({Key? key}) : super(key: key);

  @override
  _ButtonTargetState createState() => _ButtonTargetState();
}

class _ButtonTargetState extends State<ButtonTarget> {
  final List<String> items = [];

  void addItem(String item) {
    setState(() {
      items.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];

        return ListTile(
          title: Text(item),
          leading: Icon(Icons.check),
        );
      },
    );
  }
}