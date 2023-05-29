class RemainderModel{
  String title;
  String body;
  String dateTime;
  String time;
  String docId;

  RemainderModel({required this.docId,required this.title, required this.body, required this.dateTime, required this.time});

  Map<String, dynamic> toJson() => {
    'docId' : docId,
    'title' : title,
    'body' : body,
    'date' : dateTime,
    'time' : time
  };

  static RemainderModel fromJson(Map<String, dynamic> json) => RemainderModel(docId: json["docId"], time: json["time"], body: json["body"], dateTime: json["date"], title: json["title"]
      );
}