import 'package:bluebellapp/resources/themes/light_color.dart';
import 'package:calendar_strip/calendar_strip.dart';
//import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';

class StripedCalendarWidget extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  StripedCalendarWidget({this.onDateSelected});

  @override
  _StripedCalendarWidgetState createState() => _StripedCalendarWidgetState();
}

class _StripedCalendarWidgetState extends State<StripedCalendarWidget> {
  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 7,
        height: 10,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      ),
      Container(
        width: 7,
        height: 10,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      )
    ]);
  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(
        monthName,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          //  fontStyle: FontStyle.italic,
        ),
      ),
      padding: EdgeInsets.only(top: 8, bottom: 10),
    );
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle =
        TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white);
    TextStyle dayNameStyle =
        TextStyle(fontSize: 12, color: fontColor, fontWeight: FontWeight.bold);
    List<Widget> _children = [
      Text(dayName, style: !isSelectedDate ? dayNameStyle : selectedStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : LightColor.orange,
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // return Text('');
    return CalendarStrip(
      startDate: DateTime.now(),
      selectedDate: selectedDate,
      endDate: DateTime(2200),
      onDateSelected: (DateTime date) {
        selectedDate = date;
        widget.onDateSelected(date);
      },
      onWeekSelected: (data) {},
      containerHeight: 100,
      dateTileBuilder: dateTileBuilder,
      iconColor: Colors.black87,
      monthNameWidget: _monthNameWidget,
      // markedDates: markedDates,
      containerDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0), color: Colors.white70),
      addSwipeGesture: true,
    );
  }
}

// child: TableCalendar(
//   calendarController: _calendarController,
//   // events: _events,
//   // holidays: _holidays,
//   startDay: DateTime.now().add(Duration(days: 1)),
//   endDay: DateTime(2100),
//   rowHeight: 40,
//   startingDayOfWeek: StartingDayOfWeek.monday,
//   calendarStyle: CalendarStyle(
//     selectedColor: LightColor.orange,
//     todayColor: Colors.deepOrange[200],
//     markersColor: Colors.brown[700],
//     outsideDaysVisible: false,
//   ),
//   onDaySelected: (date,events){
//     setState(() {
//       String formatteddate =
//           DateFormat.yMMMd().format(date);
//       selectedDate = formatteddate.toString();
//       dayMap.value = date.day.toString();
//       monthMap.value = date.month.toString();
//       yearMap.value = date.year.toString();
//     });
//   },
//   headerStyle: HeaderStyle(
//     formatButtonVisible: false,
//     centerHeaderTitle: true,
//     titleTextStyle: TextConstants.H6,
//     leftChevronPadding: EdgeInsets.all(5.0),
//     rightChevronPadding: EdgeInsets.all(5.0),
//     rightChevronIcon:
//         Icon(Icons.chevron_right, color: LightColor.orange),
//     leftChevronIcon:
//         Icon(Icons.chevron_left, color: LightColor.orange),

//     // formatButtonTextStyle:
//     //     TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
//     // formatButtonDecoration: BoxDecoration(
//     //   color: Colors.deepOrange[400],
//     //   borderRadius: BorderRadius.circular(16.0),
//     // ),
//   ),
//  onDaySelected: _onDaySelected,
//  onVisibleDaysChanged: _onVisibleDaysChanged,z
//  onCalendarCreated: _onCalendarCreated,
// ),
