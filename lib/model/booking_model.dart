class bookModels {
  bookModels({
    required this.success,
    required this.error,
    required this.message,
    required this.data,
  });
  late final bool success;
  late final bool error;
  late final String message;
  late final Data data;

  bookModels.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false; // Provide a default value if 'success' is null
    error = json['error'] ?? false; // Provide a default value if 'error' is null
    message = json['message'];
    data = Data.fromJson(json['data']);
  }


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['error'] = error;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.turfid,
    required this.date,
    required this.time,
    required this.userId,
    required this.id,
    required this.name,
    required this.place,
    required this.v,
  });
  late final String turfid;
  late final String date;
  late final String time;
  late final String userId;
  late final String id;
  late final String name;
  late final String place;
  late final int v;

  Data.fromJson(Map<String, dynamic> json){
    turfid = json['turfid'];
    date = json['date'];
    time = json['time'];
    userId = json['userId'];
    id = json['_id'];
    name=json['name'];
    place=json['place'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['turfid'] = turfid;
    _data['date'] = date;
    _data['time'] = time;
    _data['userId'] = userId;
    _data['_id'] = id;
    _data['name'] = name;
    _data['place'] = place;
    _data['__v'] = v;
    return _data;
  }
}