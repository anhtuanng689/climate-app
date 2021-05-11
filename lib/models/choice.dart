import 'package:flutter/cupertino.dart';

class Choice with ChangeNotifier {
  int id;
  int tempChoice;
  int windSpeedChoice;
  int distanceChoice;
  int pressureChoice;
  int notificationChoice;

  Choice(
      {this.id,
      this.tempChoice,
      this.windSpeedChoice,
      this.distanceChoice,
      this.pressureChoice,
      this.notificationChoice});

  factory Choice.fromMap(Map<String, dynamic> json) => new Choice(
        id: json["id"],
        tempChoice: json["temperature"],
        windSpeedChoice: json["windspeed"],
        distanceChoice: json["distance"],
        pressureChoice: json["pressure"],
        notificationChoice: json["notification"],
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "temperature": tempChoice,
      "windspeed": windSpeedChoice,
      "distance": distanceChoice,
      "pressure": pressureChoice,
      "notification": notificationChoice,
    };
  }
}
