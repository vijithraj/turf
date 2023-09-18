
class TurfModel{

  String? Name;
  String? Place;
  String? Contact;
  String? Image;
  String? Id;

  TurfModel({this.Name, this.Place, this.Contact, this.Image, this.Id});

  factory TurfModel.fromJson(Map<String,dynamic>json){
    return TurfModel(
        Name: json['Name'],
        Place: json['Place'],
        Contact: json['Contact'],
        Image: json['Image'],
        Id: json['_id']
    );
  }
}