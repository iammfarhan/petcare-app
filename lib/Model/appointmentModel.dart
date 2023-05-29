class AppointmentModel {
  String request;
  String? id;
  String? userId;
  String type;
  String purpose;
  String availability;
  String time;
  String pet;
  String documentId;
  String fees;
  String payment;

  AppointmentModel(
      {
        required this.payment,
        required this.fees,
        required this.documentId,
        required this.request,
      required this.userId,
      required this.id,
      required this.type,
      required this.purpose,
      required this.availability,
      required this.time,
      required this.pet});

  Map<String, dynamic> toJson() => {
        'payment' : payment,
        'fees' : fees,
        'documentId': documentId,
        'request': request,
        'userId': userId,
        'id': id,
        'purpose': purpose,
        'type': type,
        'availability': availability,
        'time': time,
        'pet': pet
      };
  static AppointmentModel fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        payment: json["payment"],
        fees: json["fees"],
        documentId: json["documentId"],
          type: json["type"],
          purpose: json["purpose"],
          availability: json["availability"],
          time: json["time"],
          id: json["id"],
          userId: json["userId"],
          pet: json["pet"],
          request: json["request"]);
}
