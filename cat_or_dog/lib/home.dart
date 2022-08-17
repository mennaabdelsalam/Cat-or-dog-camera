import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final picker = ImagePicker();
  File? _image;
  bool _loading = false;
  List? _output;

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image!);
  }

  PickGalleryimage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image!);
  }

  void initstate() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      setState(() {});
    });
  }

  void dispose() {
    Tflite.close();
    super.dispose();
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _loading = false;
      _output = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'labels.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff220901),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Text(
              'Teachable machine CNN',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xffFF9500),
                  fontSize: 40,
                  fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Detect Cat & dogs',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xffEFF1F3),
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: _loading
                  ? Container(
                      width: 300,
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/images/cat.png'),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 250,
                            child: Image.file(_image!),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _output != null
                              ? Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    '${_output![0]['label']}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 200,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                          color: Color(0xffFF9500),
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        'PREND UNE PHOTO',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      PickGalleryimage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 200,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                      decoration: BoxDecoration(
                          color: Color(0xffFF9500),
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        'TON CAMERA',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
