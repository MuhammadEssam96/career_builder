import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Inprog extends StatefulWidget {
   Inprog({ @required this.style, }) ;

  final TextStyle style;

  @override
  _InprogState createState() => _InprogState();
}

class _InprogState extends State<Inprog> {

  final List inprogress=[];
  final List skilldata=[];
  final dbref=FirebaseDatabase.instance.reference().child('user_skills');
  final dbRef2 = FirebaseDatabase.instance.reference().child('skills');
   


  fetchInpro()async{
  dbref.orderByChild('user_id').equalTo('2').once().then(( snapshot) {
    print(snapshot.value);
  if(snapshot.value!=null){
    var respose=snapshot.value.values;
    for(int i=0;i<respose.length;i++){
      if(respose.elementAt(i)['status']=='inprogress'){
         var skillId=respose.elementAt(i)['skill_id'];
         inprogress.add(respose.elementAt(i));
         fetchSkills(skillId); 
      }
    }
     if(inprogress.isEmpty){
           skilldata.add({
          'langname': 'no old skills yet',
          'level': '0'
        });
            setState(() {});
        }

    
    print('inprogress$inprogress');
    }else{
      skilldata.add({
          'langname': 'no new skills yet',
          'level': '0'
        });
        setState(() {
          
        });
    }

    }
    );
     }
  fetchSkills(var skillId){
         dbRef2.child('$skillId').once().then((snapshot2){
           var response2=snapshot2.value;
          if(response2!=null){
            skilldata.add({
              'langname':'${response2['name']}',
              'level':'${response2['level']}'
            });
           print('skill data $skilldata');
           print('skill data ${skilldata.length}');
           setState(() { 
           });  
          }
         });  
        }
  @override
  void initState() { 
    super.initState();
    fetchInpro();
  }
  
  @override
  Widget build(BuildContext context) {
    int  skilllength=skilldata.length;
             double equation=(skilllength*35).toDouble();
              double sizedboxHeight=50 + equation ;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
      Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xffA2E8E8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              FontAwesomeIcons.hourglassHalf,
              size: 35,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          //inprogress text
          Container(
            padding: EdgeInsets.only(top: 20),
//                          margin: EdgeInsets.only(top: 20),
            child: Text(
              'Inprogress',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      //vertical
           Container(
          margin: EdgeInsets.only(top: 3),
          width: MediaQuery.of(context).size.width - 60,
          height: 2,
          color: Color(0xff8CDBD8)),
           Container(
            //  color: Colors.indigo,
             child: SizedBox(
               height:sizedboxHeight,
             child: skilldata.isNotEmpty ? ListView.builder(
             itemCount:skilldata.length,
             physics: const NeverScrollableScrollPhysics(),
             itemBuilder: (context,index){
             
              return Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(child: Text('${skilldata[index]['langname']}',style: widget.style,),),
             );
             
          }):Center(child: CircularProgressIndicator())
      ),
           )
    ],
    );
  }
}