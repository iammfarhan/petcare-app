class WalkingModel{
  String payment;
  String date;
  String walk;
  String address;
  String message;
  String fees;
  String documentId;
  String request;
  String? userId;
  String? id;

  WalkingModel({required this.fees,
    required this.documentId,
    required this.request,
    required this.userId,
    required this.id,required this.payment, required this.date, required this.walk, required this.address, required this.message});

  Map<String, dynamic> toJson() => {
    'date' : date,
    'walk' : walk,
    "address" : address,
    'message' : message,
    'payment' : payment,
    'fees' : fees,
    'documentId': documentId,
    'request': request,
    'userId': userId,
    'id': id,
  };

  static WalkingModel fromJson(Map<String, dynamic> json) => WalkingModel(
    payment: json['payment'],
      date: json['date'],
      walk: json['walk'],
    address: json['address'],
    message: json['message'],
      fees: json["fees"],
      documentId: json["documentId"],
      id: json["id"],
      userId: json["userId"],
      request: json["request"]
  );
}