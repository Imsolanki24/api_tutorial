class Images {
  Images({
      required this.id,
      required this.filename,
      required this.url,});

  Images.fromJson(dynamic json) {
    id = json['_id'];
    filename = json['filename'];
    url = json['url'];
  }
 late String id;
 late String filename;
 late String url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['filename'] = filename;
    map['url'] = url;
    return map;
  }

}