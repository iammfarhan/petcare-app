class WalkingServiceModel{
  static int index = 0;
  String? id;
  String fullName;
  String profession;
  String price;
  String city;
  String street;
  String about;
  String fromTime;
  String toTime;

  WalkingServiceModel(
      {
        required this.id,
        required this.fullName,
        required this.profession,
        required this.price,
        required this.city,
        required this.street,
        required this.about,
        required this.fromTime,
        required this.toTime});

  Map<String, dynamic> toJson() => {
    "id" : id,
    "fullName" : fullName,
    "profession" : profession,
    "price" : price,
    "city" : city,
    "street" : street,
    "about" : about,
    "fromTime" : fromTime,
    "toTime" : toTime
  };

  static WalkingServiceModel fromJson(Map<String, dynamic> json) =>
      WalkingServiceModel(
        id: json["id"],
          fullName: json["fullName"],
          profession: json["profession"],
          price: json["price"],
          city: json["city"],
          street: json["street"],
          about: json["about"],
          fromTime: json["fromTime"],
          toTime: json["toTime"]);
}