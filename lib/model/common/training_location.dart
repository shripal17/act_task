class TrainingLocation {
  String? address;
  String city;

  TrainingLocation({this.address, required this.city});

  @override
  String toString() {
    return "$address, $city";
  }
}
