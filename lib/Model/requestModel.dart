class RequestModel {
  String? id;
  String service;
  String date;
  String pet;
  String address;
  String message;
  String walk;
  String respond;
  String docId;

  RequestModel({required this.docId, required this.respond,required this.id, required this.walk, required this.service, required this.date, required this.pet, required this.address, required this.message});

  Map<String, dynamic> toJson() => {
    'docId' : docId,
    'respond' : respond,
    'id' : id,
      'walk' : walk,
      'pet' : pet,
      'service' : service,
      'date' : date,
      'address' : address,
      'message' : message,
  };

  static RequestModel fromJson(Map<String, dynamic> json) => RequestModel(
    docId: json["docId"],
    respond: json["respond"],
      id: json["id"], pet: json["pet"], message: json['message'], service: json['service'], address: json['address'], date: json['date'], walk: json['walk']);
}