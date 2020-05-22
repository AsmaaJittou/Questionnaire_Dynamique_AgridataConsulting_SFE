import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:programe/models/test.dart';
import 'TestTile.dart';


class TestList extends StatefulWidget {
  @override
  _TestListState createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  @override
  Widget build(BuildContext context) {

    final tests = Provider.of<List<Test>>(context);


        return ListView.builder(
      itemCount: tests.length,
      itemBuilder:  (context,index)
      {
return TestTile(test: tests[index] );
      },
    );
  }
}
