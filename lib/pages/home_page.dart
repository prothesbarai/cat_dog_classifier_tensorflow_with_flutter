import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tensorflow_lite/flutter_tensorflow_lite.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List? _output;
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    loadModel().then((value){
      setState(() {});
    });
  }



  /// >>> Image Pick Compressed And Action Start Here ==========================
  File? images;
  final _imagePicker = ImagePicker();
  Future<void> _pickImage(ImageSource source) async{
    final originalImg = await _imagePicker.pickImage(source: source);
    if(originalImg == null) return;
    // Now Cropped Image Here
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: originalImg.path,
      compressFormat: ImageCompressFormat.jpg,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(toolbarTitle: "Crop Image",toolbarColor: Colors.blue,toolbarWidgetColor: Colors.white,lockAspectRatio: true,hideBottomControls: false,initAspectRatio: CropAspectRatioPreset.square),
        IOSUiSettings(title: "Crop Image",aspectRatioLockEnabled: true,hidesNavigationBar: false,aspectRatioPickerButtonHidden: false,minimumAspectRatio: 1.0)
      ]
    );
    if(croppedImage == null) return;

    setState(() {images = File(croppedImage.path);});
    detectImage(images!);
  }
  /// <<< Image Pick Compressed And Action End Here ============================



  /// >>> Detected Image =======================================================
  Future<void> detectImage(File images) async {
    var output = await Tflite.runModelOnImage(path: images.path,numResults: 2,threshold: 0.6,imageMean: 127.5,imageStd: 127.5);
    if(!mounted) return;
    setState(() {_output = output;isLoading = false;});
  }
  /// <<< Detected Image =======================================================


  /// >>> Load Model ===========================================================
  Future<void> loadModel() async{
    await Tflite.loadModel(model: "assets/models/model_unquant.tflite",labels: "assets/models/labels.txt");
  }
  /// <<< Load Model ===========================================================



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xff004242),
      appBar: AppBar(title: const Text("Cat & Dog Classification"), backgroundColor: const Color(0xff004242),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 50),
              const Text("Tensorflow", style: TextStyle(color: Color(0xff7d9e9e), fontSize: 20),),
              const SizedBox(height: 5),
              const Text("Cats & dogs detector app", style: TextStyle(color: Color(0xff7d9e9e), fontSize: 30, fontWeight: FontWeight.w500,),),
              const SizedBox(height: 40),

              // Image Section
              isLoading?
              Expanded(child: Center(child: Image.asset("assets/logo/catdog_innner_logo.png", width: double.infinity, height: 250, fit: BoxFit.contain,),),):
              Expanded(child: Center(child: ClipRRect(borderRadius : BorderRadius.circular(20),child: Image.file(images!, width: double.infinity, height: 250, fit: BoxFit.cover,)),),),

              // ${_output?[0]['label']}\n${_output?[0]['confidence']}
              _output != null ? Center(child: Text("This is a ${_output?[0]['label']}",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)) : SizedBox.shrink(),
              SizedBox(height: 20,),
              // Bottom Buttons
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: ()=>_pickImage(ImageSource.camera),
                        icon: const Icon(Icons.camera_alt),
                        label: const Text("Camera"),
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15),),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: ()=>_pickImage(ImageSource.gallery),
                        icon: const Icon(Icons.photo_library),
                        label: const Text("Gallery"),
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
