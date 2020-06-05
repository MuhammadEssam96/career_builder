import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  const Testing({Key key}) : super(key: key);

  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  String dropdownValue;
  String dropdownValue2;
  List<String> web=['html','css'];
  List<String> mobile=['java','swift'];
   List<String> emptyList=[];
  String selectedTrack;
  bool butoon=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('test'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            DropdownButton<String>(
              hint: Text('select track'),
            value: selectedTrack,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                selectedTrack = newValue;
                if(selectedTrack=='Mobile Development'){
                  emptyList=mobile;
                  dropdownValue2='java';
                }else{
                  emptyList=web;
                  dropdownValue2='html';
                }
              });
            },
            items: <String>['Web Development', 'Mobile Development']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
           ),


           DropdownButton<String>(hint: Text('select language'),
            value: dropdownValue2,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.blue),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue2 = newValue;
                
                
              });
            },
            items:emptyList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
    ),
          butoon?Container(child: Text('hi'),)
        :RaisedButton(child: Text('hello'),
        onPressed: (){
          setState(() {
           butoon=true;
          }); 
        },
        )
          ],
        ),
      )
    );
  }
}