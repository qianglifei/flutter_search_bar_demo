import 'package:flutter/material.dart';
import 'asset.dart';


class SearchBarDemo extends StatefulWidget{
   _SearchBarDemoState createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBarDemo> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('SearchBarDemo'),
        actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                    ///print('开始搜索');
                    showSearch(
                        context: context,
                        delegate: SearchBarDelegate()
                    );
                }
            )
        ],
      ),
    );
  }
}

class SearchBarDelegate extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon:Icon(Icons.clear),
        onPressed: (){
           query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation), onPressed: () => close(context,null));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container(
        width: 100.0,
        height: 100.0,
        color: Colors.blue,
        child: Card(
                color: Colors.redAccent,
                child:Center(
                  child: Text(query),
                ),
         )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionList  = query.isEmpty ? recentSuggest : searchList.where((input) => input.startsWith(query)).toList();
    print(query.length);
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context,index) =>
            ListTile(
                /// 富文本，可以实现，一行文本多种样式...
                title: RichText(text:
                    ///
                    TextSpan(
                        text: suggestionList[index].substring(0,query.length),
                        style: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.bold
                        ),
                        children: [
                            TextSpan(
                                text: suggestionList[index].substring(query.length),
                                style: TextStyle(fontSize: 24.0, color: Colors.black)
                            )
                        ]
                    )
                )
            )
    );
  }
}