// import 'package:flutter/material.dart';

// class CVScreen extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     var orientation = MediaQuery.of(context).orientation;

//     if(orientation == Orientation.portrait)
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Wrap(
//         children: <Widget>[
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * 0.25,
//             color: Color(0xFFD5FFFD),
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Icon(Icons.arrow_back_ios),
//                     CircleAvatar(
//                       backgroundImage: AssetImage('assets/images/pp.jpeg'),
//                       radius: MediaQuery.of(context).size.width * 0.17,
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           mainAxisSize: MainAxisSize.max,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             Text("Amany Gomaa Gharib", textAlign: TextAlign.center),
//                             Text("Mobile Developer & UI & UX Designer", textAlign: TextAlign.center),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Text("Female"),
//                                 Text(
//                                   " | ",
//                                   style: TextStyle(
//                                     color: Color(0xFF8CDBD8),
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15
//                                   )
//                                 ),
//                                 Text("23")
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.12,
//                           padding:EdgeInsets.all(8) ,
//                           decoration: BoxDecoration(
//                             color: Color(0xFFA2E8E8),
//                             shape: BoxShape.circle
//                           ),
//                           child: Image.asset('assets/images/contact.png')
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           "CONTACT",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold
//                           )
//                         )
//                       ],
//                     ),
//                     Row(
//                       children: <Widget>[
//                         Text(
//                           "EDUCATION",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold
//                           )
//                         ),
//                         SizedBox(width: 8),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.12,
//                           padding:EdgeInsets.all(8) ,
//                           decoration: BoxDecoration(
//                             color: Color(0xFFA2E8E8),
//                             shape: BoxShape.circle
//                           ),
//                           child: Image.asset('assets/images/education.png')
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Divider(color: Color(0xFF8CDBD8), thickness: 3),
//                 Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Expanded(
//                       child: Column(
//                         children: <Widget>[
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Wrap(
//                               alignment: WrapAlignment.center,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Icon(
//                                     Icons.email,
//                                     color: Color(0xFF8CDBD8),
//                                   ),
//                                 ),
//                                 Text("amany@gmail.com")
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Icon(
//                                     Icons.phone,
//                                     color: Color(0xFF8CDBD8),
//                                   ),
//                                 ),
//                                 Text("+20 121 5454 121")
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 24.0),
//                             child: Row(
//                               children: <Widget>[
//                                 Container(
//                                   width: MediaQuery.of(context).size.width * 0.10,
//                                   padding:EdgeInsets.all(8) ,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xFFA2E8E8),
//                                     shape: BoxShape.circle
//                                   ),
//                                   child: Image.asset('assets/images/ach.png')
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   "ACHIEVEMENTS",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold
//                                   )
//                                 )
//                               ],
//                             ),
//                           ),
//                           Divider(color: Color(0xFF8CDBD8), thickness: 3),
//                           Wrap(
//                             children: <Widget>[
//                               Text("2019"),
//                               Divider(color: Colors.grey, thickness: 1.0, endIndent: 77,),
//                               Text(
//                                 "WEB DEVELOPEMENT & DIGITAL MARKEING at ITI",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontStyle: FontStyle.italic
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 24.0),
//                             child: Row(
//                               children: <Widget>[
//                                 Container(
//                                   width: MediaQuery.of(context).size.width * 0.12,
//                                   padding:EdgeInsets.all(8) ,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xFFA2E8E8),
//                                     shape: BoxShape.circle
//                                   ),
//                                   child: Image.asset('assets/images/ach.png')
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   "SKILLS",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold
//                                   )
//                                 )
//                               ],
//                             ),
//                           ),
//                           Divider(color: Color(0xFF8CDBD8), thickness: 3),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Image.asset(
//                                     'assets/images/html.png', 
//                                     width: MediaQuery.of(context).size.width * 0.10,
//                                   )
//                                 ),
//                                 Text("HTML")
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                   child: Image.asset(
//                                     'assets/images/css.webp', 
//                                     width: MediaQuery.of(context).size.width * 0.10,
//                                   )
//                                 ),
//                                 Text("CSS")
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       width: 3.0,
//                       height: MediaQuery.of(context).size.height,
//                       color: Color(0xFF8CDBD8),
//                     ),
//                     Expanded(
//                         child: Column(
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text("2016"),
//                                   Text("_______________"),
//                                   Text("      2020"),
//                                 ],
//                               )
//                             ],
//                           ),
//                           Text(
//                             "Bachelor of Management Information System, Faculty of Commerece",
//                             textAlign: TextAlign.center,
                            
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Text(
//                               "Alexandria University",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 24.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 Text(
//                                   "LANGUAGES",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold
//                                   )
//                                 ),
//                                 SizedBox(width: 8),
//                                 Container(
//                                   width: MediaQuery.of(context).size.width * 0.12,
//                                   padding:EdgeInsets.all(8) ,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xFFA2E8E8),
//                                     shape: BoxShape.circle
//                                   ),
//                                   child: Image.asset('assets/images/ach.png')
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Divider(color: Color(0xFF8CDBD8), thickness: 3),
//                           Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Text(
//                               "Arabic",
//                               style: TextStyle(
//                                 fontStyle: FontStyle.italic
//                               )
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Text(
//                               "English",
//                               style: TextStyle(
//                                 fontStyle: FontStyle.italic
//                               )
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 24.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 Text(
//                                   "IN PROGRESS",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold
//                                   )
//                                 ),
//                                 SizedBox(width: 8),
//                                 Container(
//                                   width: MediaQuery.of(context).size.width * 0.12,
//                                   padding:EdgeInsets.all(8) ,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xFFA2E8E8),
//                                     shape: BoxShape.circle
//                                   ),
//                                   child: Image.asset('assets/images/ach.png')
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Divider(color: Color(0xFF8CDBD8), thickness: 3,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Text("Flutter"),
//                               SizedBox(width: 8,),
//                               Image.asset(
//                                 'assets/images/40.png',
//                                 width: MediaQuery.of(context).size.width * 0.12,
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Text("Dart"),
//                               SizedBox(width: 8,),
//                               Image.asset(
//                                 'assets/images/60.png',
//                                 width: MediaQuery.of(context).size.width * 0.12,
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       )
//     );
//     return Center(child: Text("E3del el mobile"));
//   }
// }