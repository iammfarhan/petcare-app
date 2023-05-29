class PetData {
  String pet;
  String name;
  String age;
  String breed;
  String feeding;
  String alone;
  String medication;
  String vetInfo;

  PetData(
      {
      required this.pet,
      required this.name,
      required this.age,
      required this.breed,
      required this.feeding,
      required this.alone,
      required this.medication,
      required this.vetInfo});

  Map<String, dynamic> toJson() => {
          'pet': pet,
          'name': name,
          'age': age,
          'breed': breed,
          'feeding': feeding,
          'alone': alone,
          'medication': medication,
          'vetInfo': vetInfo,
      };

  static PetData fromJson(Map<String, dynamic> json) => PetData(
      age: json["age"],
      alone: json["alone"],
      feeding: json["feeding"],
      name: json["name"],
      vetInfo: json["vetInfo"],
      medication: json["medication"],
      breed: json["breed"],
      pet: json["pet"]);
}
