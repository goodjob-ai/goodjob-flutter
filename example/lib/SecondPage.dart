import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("SecondPage"),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text("${Provider.of<Counter>(context).count}"), //1
          ),
          InkWell(
            onTap: () {
              Provider.of<Counter>(context,listen: false).initCounter(lang: "zhCN");
              Navigator.pop(context);
            },
            child: FlatButton(child: Text("切换中文,返回上一页"),),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<Counter>(context, listen: false).add(); //2
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
