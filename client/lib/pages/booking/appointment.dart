//TODO: FUTURE CODE TO IMPLEMENT
// import 'booking.dart';
//
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:flutter/material.dart';
//
// class Appointment extends StatefulWidget {
//   const Appointment({Key? key}) : super(key: key);
//
//   @override
//   State<Appointment> createState() => _Appointment();
// }
//
// class _Appointment extends State<Appointment> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   String url = "http://localhost:8080/appointment";
//   //Not sure if url needed
//
//   //TODO: Remove this widget later and import it from the utilities folder
//   Widget menuButtons(Color color, Text message, Icon icons,
//       BuildContext context, MaterialPageRoute page) {
//     return Padding(
//         padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
//         child: ElevatedButton.icon(
//           onPressed: () {
//             Navigator.push(context, page);
//           },
//           label: message,
//           icon: icons,
//           style: ElevatedButton.styleFrom(
//             primary: color,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             fixedSize: const Size(260, 70),
//             side: const BorderSide(
//               color: Colors.transparent,
//               width: 1,
//             ),
//             textStyle: GoogleFonts.lexendDeca(
//               textStyle: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: scaffoldKey,
//         backgroundColor: Colors.blue,
//         body: GestureDetector(
//             onTap: () => FocusScope.of(context).unfocus(),
//             child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 1.1,
//                 constraints: BoxConstraints(
//                     maxHeight: MediaQuery.of(context).size.height * 1.2,
//                     minHeight: MediaQuery.of(context).size.height * 1),
//                 decoration: const BoxDecoration(
//                   color: Color(0xFF14181B),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage('images/background.jpeg'),
//                   ),
//                 ),
//                 child: Container(
//                     width: 100,
//                     height: 100,
//                     decoration: const BoxDecoration(
//                       color: Color(0x990F1113),
//                     ),
//                     child: SingleChildScrollView(
//                         child:
//                             Column(mainAxisSize: MainAxisSize.max, children: [
//                       const Padding(
//                         padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
//                         child: Text(
//                           'Appointment',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontFamily: 'Poppins',
//                               color: Colors.white,
//                               fontSize: 50,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//
//                       SingleChildScrollView(
//                           child: Column(
//                               mainAxisSize: MainAxisSize.max,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                             menuButtons(
//                                 Color.fromARGB(255, 82, 80, 80),
//                                 const Text(
//                                   'Book Appointment',
//                                 ),
//                                 const Icon(Icons.calendar_today_rounded,
//                                     size: 15),
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Booking())),
//                             menuButtons(
//                                 Color.fromARGB(255, 82, 80, 80),
//                                 const Text(
//                                   'Upcoming Appointment',
//                                 ),
//                                 const Icon(Icons.calendar_today_rounded,
//                                     size: 15),
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => Appointment(),
//                                 ))
//                           ]))
//
//                     ]))))));
//   }
// }