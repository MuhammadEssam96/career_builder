import 'package:careerbuilder/screens/challengeScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  final dbRef = FirebaseDatabase.instance.reference().child('users');
  var fname;
  var email;
  var img;
  getData()async{
    dbRef.orderByChild('id').equalTo('0').once().then((DataSnapshot snapshot){
         fname= snapshot.value[0]['first_name'];
         email=snapshot.value[0]['email'];
         img=snapshot.value[0]['profile_picture'];

        setState(() {
          
        });
    });
  }
   
  
  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
//            borderRadius: BorderRadius. only(
//              bottomLeft: Radius.circular(80)),
        color: Color(0xff222931),
      ),

      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff09D8D2),
//                  borderRadius: BorderRadius. only(bottomLeft: Radius.circular(50)),
//                  image: DecorationImage(
//                  image: AssetImage('assets/pro.png'),
//                  fit: BoxFit.cover,
//                ),
            ),
            accountName: Text('${fname ??'loading..'}',style: TextStyle(fontSize: 25),),
            accountEmail: Text('${email ??'loading..'}',style: TextStyle(fontSize: 18),),
            currentAccountPicture:ClipOval(
                  child: Image.network(img ??'https://via.placeholder.com/150',
                    width: 300,
                    height: 200,
                    fit: BoxFit.cover,
                    ),
                    ),
          ),
//            DrawerHeader(
//              decoration: BoxDecoration(
//                image: DecorationImage(
//                  image: AssetImage('assets/pro.png'),
//                  fit: BoxFit.cover,
//                ),
//              ),
//
//            ),
          Divider(),
          //profile
          ListTile(
            title: Center(
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 50),
//                  color: Colors.amber,
                height: 50,
                width: 200,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.account_circle,color: Colors.white),
                    SizedBox(width: 20,),
                    Text('Profile',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                    return ChallengeScreen();
                  },));
            },
          ),
          //tracks
          ListTile(
            title: Center(
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 10),
//                  color: Colors.amber,
                height: 50,
                width: 200,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.directions,color: Colors.white,),
                    SizedBox(width: 20,),
                    Text('My Tracks',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                    return ChallengeScreen();
                  },));
            },
          ),
          //offers
          ListTile(
            title: Center(
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 5,top: 10),
//                  color: Colors.amber,
                height: 50,
                width: 200,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.local_offer,color: Colors.white),
                    SizedBox(width: 20,),
                    Text('Offers',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                    return ChallengeScreen();
                  },));
            },
          ),
          //setting
          ListTile(
            title: Center(
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 40,top: 10),
//                  color: Colors.amber,
                height: 50,
                width: 200,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.settings,color: Colors.white),
                    SizedBox(width: 20,),
                    Text('Setting',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                    return ChallengeScreen();
                  },));
            },
          ),
          //logoutButton
          Divider(color: Colors.black26,indent: 30,endIndent: 30,),
          Container(

              margin: EdgeInsets.only(left: 50,right: 50,top: 10),
              child:RaisedButton(
                color: Color(0xff09D8D2),
                shape: RoundedRectangleBorder
                  (borderRadius:BorderRadius.all
                  (Radius.circular(30.0))),
                child: Text('LogOut',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                onPressed: (){
                },
              )
          )
        ],
      ),
    );
  }
}