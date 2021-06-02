class Moon {
  Moon({
    this.error,
    this.errorMsg,
    this.targetDate,
    this.moon,
    this.index,
    this.age,
    this.phase,
    this.distance,
    this.illumination,
    this.angularDiameter,
    this.distanceToSun,
    this.sunAngularDiameter,
  });

  int error;
  String errorMsg;
  String targetDate;
  List<String> moon;
  int index;
  double age;
  String phase;
  double distance;
  double illumination;
  double angularDiameter;
  double distanceToSun;
  double sunAngularDiameter;

  factory Moon.fromJson(Map<String, dynamic> json) => Moon(
        error: json["Error"],
        errorMsg: json["ErrorMsg"],
        targetDate: json["TargetDate"],
        moon: List<String>.from(json["Moon"].map((x) => x)),
        index: json["Index"],
        age: json["Age"].toDouble(),
        phase: json["Phase"],
        distance: json["Distance"].toDouble(),
        illumination: json["Illumination"].toDouble(),
        angularDiameter: json["AngularDiameter"].toDouble(),
        distanceToSun: json["DistanceToSun"].toDouble(),
        sunAngularDiameter: json["SunAngularDiameter"].toDouble(),
      );
}
