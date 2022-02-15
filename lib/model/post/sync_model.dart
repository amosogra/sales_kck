

class SyncModel {

  String title;
  String totalCount;
  String lastSyncedDate;
  String slug;

  SyncModel({required this.title, required this.totalCount, required this.lastSyncedDate, required this.slug});

  factory SyncModel.fromMap(Map<String, dynamic> json) => SyncModel(
      title: json['title'],
      totalCount: json['total_count'],
      lastSyncedDate: json['last_synced_date'],
      slug: json['slug']);

  Map<String, dynamic> toMap() =>{
    'title':title,
    'total_count':totalCount,
    'last_synced_date':lastSyncedDate,
    'slug':slug
  };


}