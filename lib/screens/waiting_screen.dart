import 'package:flutter/material.dart';
class Waiting extends StatelessWidget {
  final int reminig;
  final String period;
  Waiting(this.reminig,this.period);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/waiting4.jpg'),
            Text('The next challenge will be in $reminig $period.' ,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),),
            SizedBox(height: 50,),
            GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                width: 200,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration( 
                       color: Colors.orange[300],
                       borderRadius: BorderRadius.all(Radius.circular(20))

                 ),
                child:Text(
                  'Finish',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),)
                ),
            ),
          ],
        ),
      ),
    );
  }
}