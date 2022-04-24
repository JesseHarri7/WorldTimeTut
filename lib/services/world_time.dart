import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime {

  late String location; // location name for the UI
  late String time; // time in that location
  late String flag; // url to asset flag icon
  late String url; // location url for api endpoint
  late bool isDay; //true or false if daytime or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {

    try {
      //Make request
      Response response = await get(
          Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String dateTime = data['utc_datetime'];
      String offset = data['utc_offset'];
      offset = offset.substring(1, 3);
      //print(dateTime);
      //print(offset);

      //create dataTime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));
      //print(now);

      //set time property
      isDay = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }catch(e) {
      print(e);
      time = 'Could not get time data';
    }
  }

}