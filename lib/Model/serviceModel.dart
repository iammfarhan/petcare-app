class ServiceModel {
  static int index = 0;
  String? id;
  String fullName;
  String profession;
  String price;
  String clinicName;
  String clinicLocation;
  String about;
  String fromTime;
  String toTime;

  ServiceModel(
      {
        required this.id,
        required this.fullName,
      required this.profession,
      required this.price,
      required this.clinicName,
      required this.clinicLocation,
      required this.about,
      required this.fromTime,
      required this.toTime});

  Map<String, dynamic> toJson() => {
    "id" : id,
        "fullName": fullName,
        "profession": profession,
        "price": price,
        "clinicName": clinicName,
        "clinicLocation": clinicLocation,
        "about": about,
        "fromTime": fromTime,
        "toTime": toTime
      };

  static ServiceModel fromJson(Map<String, dynamic> json) =>
      ServiceModel(
          id: json["id"],
          fullName: json["fullName"],
          profession: json["profession"],
          price: json["price"],
          clinicName: json["clinicName"],
          clinicLocation: json["clinicLocation"],
          about: json["about"],
          fromTime: json["fromTime"],
          toTime: json["toTime"]);
}
