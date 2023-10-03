
class TurfModel{

  final String Name;
  final String Place;
  final String Contact;
  final String Image;
  final String Id;

  TurfModel( {required this.Name,required this.Place,required this.Contact,required this.Image,required this.Id});

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