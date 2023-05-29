class DietModel {
  String dog;
  String cat;
  String dietName;
  String description;

  DietModel(
      {required this.cat,
      required this.dog,
      required this.dietName,
      required this.description});

  Map<String, dynamic> toJson() => {
        'dietName': dietName,
        'dog': dog,
        'cat': cat,
        'description': description,
      };

  static DietModel fromJson(Map<String, dynamic> json) =>
      DietModel(dog: json["dog"], cat: json["cat"], description: json["description"], dietName: json["dietName"]);
}
