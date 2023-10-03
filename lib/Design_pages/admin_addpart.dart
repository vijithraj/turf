import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:turf_booking_app/model/turf_model.dart';
import 'package:turf_booking_app/services/turf_Services.dart';
import 'dart:io';

import '../config/constants.dart';
import '../services/apiServices.dart';

class AddPart extends StatefulWidget {
  const AddPart({Key? key}) : super(key: key);

  @override
  State<AddPart> createState() => _AddPartState();
}

class _AddPartState extends State<AddPart> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  late final _filename;
  bool _isLoading = false;

  late SharedPreferences localStorsge;
  File? imageFile;
  late String storedImage;
  String loginid = '';
  String name = '';
  String number = '';
  String location = '';
  String image = '';
  String tufid = '';
  TurfModel? turfdetails;

  Future<TurfModel?> feachdetails(String id) async {
    try {
      final details = await SingleTurf.getSingleturf(id);
      turfdetails = details;
      print("turf$turfdetails");
      setState(() {
        name = turfdetails!.Name;
        number = turfdetails!.Contact;
        location = turfdetails!.Place;
        image = turfdetails!.Image == null ? "" : turfdetails!.Image;

        _nameController.text = name;
        _numberController.text = number;
        _locationController.text = location;

        _update(tufid);
      });
    } catch (e) {
      print(e);
    }
  }

  void addTurf() async {
    /*   localStorsge=await SharedPreferences.getInstance();
      loginid=(localStorsge.getString('loginId') ?? '');*/
    setState(() {
      _isLoading = true;
    });

    var data = {
      //  "login_id":loginid,
      "Name": _nameController.text,
      "Place": _locationController.text,
      "Image": _filename,
      "Contact": _numberController.text,
    };
    print(data);

    var res = await Api().authData(data, ApiConstants.addturf);
    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      print(body);
      addTurfImage();
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
      Navigator.push(
        this.context, //add this so it uses the context of the class
        MaterialPageRoute(
          builder: (context) => AddPart(),
        ), //MaterialpageRoute
      );
      //   Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>View_Comp()));
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  void addTurfImage() async {
    setState(() {
      _isLoading = true;
    });
    final uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.uploadimage);
    final request = http.MultipartRequest('POST', uri);
    final imageStream = http.ByteStream(imageFile!.openRead());
    final imageLength = await imageFile!.length();

    final multipartFile = http.MultipartFile(
      'file',
      imageStream,
      imageLength,
      filename: _filename,
    );
    request.files.add(multipartFile);

    print("multipart${_filename}");
    final response = await request.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "success",
        backgroundColor: Colors.grey,
      );

      //   Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>View_Comp()));
    } else {
      Fluttertoast.showToast(
        msg: "Failed",
        backgroundColor: Colors.grey,
      );
    }
  }

  Future<void> _update(String id) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: this.context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(this.context).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                /* decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('images/bg.jpg')
    )
  ),*/
                child: imageFile == null
                    ? Container(
                        child: Column(
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                //    _getFromGallery();
                                _showChoiceDialog(context as BuildContext);
                              },
                              child: Text("Upload Image"),
                            ),
                            Container(
                              height: 40.0,
                            ),
                          ],
                        ),
                      )
                    : Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Image.file(
                              imageFile!,
                              width: 100,
                              height: 100,
                              //  fit: BoxFit.cover,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              //    _getFromGallery();
                              _showChoiceDialog(context as BuildContext);
                            },
                            child: Text("Upload Image"),
                          ),
                        ],
                      ),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: _numberController,
                decoration: const InputDecoration(labelText: "Number"),
              ),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: "Location"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    UpdateTurf().updateturf(
                        context as BuildContext,
                        _nameController.text,
                        _numberController.text,
                        _locationController.text,
                        tufid);
                  },
                  child: const Text("Update"))
            ],
          ),
        );
      },
    );
  }

  Future<void> _create() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: this.context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  /* decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('images/bg.jpg')
    )
  ),*/
                  child: imageFile == null
                      ? Container(
                          child: Column(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  //    _getFromGallery();
                                  _showChoiceDialog(context);
                                },
                                child: Text("Upload Image"),
                              ),
                              Container(
                                height: 40.0,
                              ),
                            ],
                          ),
                        )
                      : Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.file(
                                imageFile!,
                                width: 100,
                                height: 100,
                                //  fit: BoxFit.cover,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _showChoiceDialog(context);
                              },
                              child: Text("Upload Image"),
                            ),
                          ],
                        ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'name'),
                ),
                TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(labelText: 'Number'),
                ),
                TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        addTurf();
                        _nameController.text = '';
                        _numberController.text = '';
                        _locationController.text = '';
                      },
                      child: const Text('Add')),
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete() async {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text("You have successfully deleted ")));
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.pop(context);
                      //  _openGallery(context);
                    },
                  ),
                  SizedBox(height: 10),
                  const Padding(padding: EdgeInsets.all(0.0)),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      _getFromCamera();

                      Navigator.pop(context);
                      //   _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Get from gallery
  _getFromGallery() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          _filename = basename(imageFile!.path);
          print("file$_filename");
          final _nameWithoutExtension =
              basenameWithoutExtension(imageFile!.path);
          final _extension = extension(imageFile!.path);
          print("imageFile:${imageFile}");
          print(_filename);
          print(_nameWithoutExtension);
          print(_extension);
        });
      }
    } catch (e) {
      // Handle the exception if something goes wrong
      print("Error picking image from gallery: $e");
    }
  }

  _getFromCamera() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          _filename = basename(imageFile!.path).toString();
          final _nameWithoutExtension =
              basenameWithoutExtension(imageFile!.path);
          final _extension = extension(imageFile!.path);
        });
      }
    } catch (e) {
      // Handle the exception if something goes wrong
      print("Error picking image from camera: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.brown,
          onPressed: () {
            _create();
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: FutureBuilder<List<TurfModel>>(
            future: TurfServices.getTurf(),
            builder: (BuildContext context,
                AsyncSnapshot<List<TurfModel>> snapshot) {
              print(snapshot);
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: false,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      tufid = snapshot.data![index].Id;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("server/public/images/" +
                              snapshot.data![index].Image.toString()),
                        ),
                        /*   Container(
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("server/public/images/"+snapshot.data![index].Image.toString())
                        )
                    ),
                  ),*/
                        title: Text(
                          snapshot.data![index].Name.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          children: [
                            Text(
                              snapshot.data![index].Contact.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              snapshot.data![index].Place.toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      feachdetails(snapshot.data![index].Id);
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      _delete();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            )),
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
