import 'package:flutter/material.dart';

class AdminEventCalendarPage extends StatefulWidget {
  @override
  _AdminEventCalendarPageState createState() => _AdminEventCalendarPageState();
}

class _AdminEventCalendarPageState extends State<AdminEventCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: null,
    );
  }
}


// import 'package:ctxhadminpage/Widget/drawer.dart';
// import 'package:ctxhadminpage/api_Service/apiService.dart';
// import 'package:ctxhadminpage/model/_readEventModel.dart';
// import 'package:ctxhadminpage/model/_scheduleModel.dart';
// import 'package:ctxhadminpage/share_token.dart';
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class AdminEventCalendarPage extends StatefulWidget {
//   @override
//   _AdminEventCalendarPageState createState() => _AdminEventCalendarPageState();
// }

// class _AdminEventCalendarPageState extends State<AdminEventCalendarPage> {
//   CalendarFormat format = CalendarFormat.month;
//   DateTime selectedDay = DateTime.now();
//   DateTime focusedDay = DateTime.now();
//   APIService apiService;
//   String sharetoken;
//   TextEditingController _eventController = TextEditingController();

//   @override
//   void initState(){
//     super.initState();
//     apiService = new APIService();
//     MySharedPreferences.instance
//       .getStringValue('token')
//       .then((value) => setState((){
//         sharetoken = value;
//       }));
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: _fetchEventData(),
//     );
//   }

//   Widget _fetchEventData() {
//     return FutureBuilder<Event>(
//       future: apiService.listEvent(sharetoken, DateTime.parse("2021-08-06 00:00:00.000Z")),
//       builder: (BuildContext context, AsyncSnapshot<Event> snapshot){
//         if(snapshot.hasData){
//           return _showListEvent(snapshot.data);
//         }
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }

//   Widget _showListEvent(Event event) {
//     return Scaffold(
//       drawer: DrawerWidget(),
//       appBar: AppBar(
//         title: Text("ESTech Calendar"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: (
//           ListView.builder(
//             shrinkWrap: true,
//             itemCount: event.data.length,
//             itemBuilder: (context, index) {
//               var eventData = event.data[index];
//               return GestureDetector(
//                 onTap: (){},
//                 child: Column(
//                   children: [
//                     TableCalendar(
//                       focusedDay: selectedDay,
//                       firstDay: DateTime(1980),
//                       lastDay: DateTime(2100),
//                       calendarFormat: format,
//                       onFormatChanged: (CalendarFormat _format) {
//                         setState(() {
//                           format = _format;
//                         });
//                       },
//                       startingDayOfWeek: StartingDayOfWeek.sunday,
//                       daysOfWeekVisible: true,

//                       //Day Changed
//                       onDaySelected: (DateTime selectDay, DateTime focusDay) {
//                         setState((){
//                           selectedDay = selectDay;
//                           focusedDay = focusDay;
//                         });
//                       },
//                       selectedDayPredicate: (DateTime date) {
//                         return isSameDay(selectedDay, date);
//                       },
                      
//                       //To style the Calendar
//                         calendarStyle: CalendarStyle(
//                           isTodayHighlighted: true,
//                           selectedDecoration: BoxDecoration(
//                             color: Colors.blue,
//                             shape: BoxShape.rectangle,
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                           selectedTextStyle: TextStyle(color: Colors.white),
//                           todayDecoration: BoxDecoration(
//                             color: Colors.purpleAccent,
//                             shape: BoxShape.rectangle,
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                           defaultDecoration: BoxDecoration(
//                             shape: BoxShape.rectangle,
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                           weekendDecoration: BoxDecoration(
//                             shape: BoxShape.rectangle,
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                         ),
//                         headerStyle: HeaderStyle(
//                           formatButtonVisible: true,
//                           titleCentered: true,
//                           formatButtonShowsNext: false,
//                           formatButtonDecoration: BoxDecoration(
//                             color: Colors.blue,
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                           formatButtonTextStyle: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                   ),
//                   ],
//                 ),
//               );
//             },
//           )
//           // TableCalendar(
//           //   focusedDay: selectedDay,
//           //   firstDay: DateTime(1990),
//           //   lastDay: DateTime(2050),
//           //   calendarFormat: format,
//           //   onFormatChanged: (CalendarFormat _format) {
//           //     setState(() {
//           //       format = _format;
//           //     });
//           //   },
//           //   startingDayOfWeek: StartingDayOfWeek.sunday,
//           //   daysOfWeekVisible: true,

//           //   //Day Changed
//           //   onDaySelected: (DateTime selectDay, DateTime focusDay) {
//           //     setState(() {
//           //       selectedDay = selectDay;
//           //       focusedDay = focusDay;
//           //     });
//           //     print(focusedDay);
//           //   },
//           //   selectedDayPredicate: (DateTime date) {
//           //     return isSameDay(selectedDay, date);
//           //   },

//           //   //To style the Calendar
//           //   calendarStyle: CalendarStyle(
//           //     isTodayHighlighted: true,
//           //     selectedDecoration: BoxDecoration(
//           //       color: Colors.blue,
//           //       shape: BoxShape.rectangle,
//           //       borderRadius: BorderRadius.circular(5.0),
//           //     ),
//           //     selectedTextStyle: TextStyle(color: Colors.white),
//           //     todayDecoration: BoxDecoration(
//           //       color: Colors.purpleAccent,
//           //       shape: BoxShape.rectangle,
//           //       borderRadius: BorderRadius.circular(5.0),
//           //     ),
//           //     defaultDecoration: BoxDecoration(
//           //       shape: BoxShape.rectangle,
//           //       borderRadius: BorderRadius.circular(5.0),
//           //     ),
//           //     weekendDecoration: BoxDecoration(
//           //       shape: BoxShape.rectangle,
//           //       borderRadius: BorderRadius.circular(5.0),
//           //     ),
//           //   ),
//           //   headerStyle: HeaderStyle(
//           //     formatButtonVisible: true,
//           //     titleCentered: true,
//           //     formatButtonShowsNext: false,
//           //     formatButtonDecoration: BoxDecoration(
//           //       color: Colors.blue,
//           //       borderRadius: BorderRadius.circular(5.0),
//           //     ),
//           //     formatButtonTextStyle: TextStyle(
//           //       color: Colors.white,
//           //     ),
//           //   ),
//           // ),
//           // ListView.builder(
//           //   itemCount: event.data.length,
//           //   shrinkWrap: true,
//           //   itemBuilder: (context, index) {
//           //     var eventData = event.data[index];
//           //     return GestureDetector(
//           //       onTap: (){},
//           //       child: Column(
//           //         children: [
//           //          ListTile(
//           //            title: Text(eventData.eventName),
//           //          )
//           //         ],
//           //       ),
//           //     );
//           //   },
//           // )

//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text("Add Schedule"),
//             content: TextFormField(
//               controller: _eventController,
//             ),
//             actions: [
//               TextButton(
//                 child: Text("Cancel"),
//                 onPressed: () => Navigator.pop(context),
//               ),
//               TextButton(
//                 child: Text("Ok"),
//                 onPressed: () {
                 
//                 },
//               ),
//             ],
//           ),
//         ),
//         label: Text("Add Schedule"),
//         icon: Icon(Icons.add),
//       ),
//     );
//   }
// }

