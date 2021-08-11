



class SyncModel {

  String title;
  int total;
  String date;

  SyncModel({required this.title, required this.total, required this.date});

  factory SyncModel.fromMap(Map<String,dynamic> json) => SyncModel(
      title: json["title"],
      total: json["total"],
      date: json["date"]
  );


  Map<String, dynamic> toMap() => {
    "title": title,
    "total": total,
    "date" : date
  };


}
