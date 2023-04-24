import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

// CODE FOR POST API UPLOAD IMAGE

class FifthScreen extends StatefulWidget {
  const FifthScreen({Key? key}) : super(key: key);

  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  bool showSpinner = false;

// code for uplod image by API

  Future<void> uplodImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = http.ByteStream(_image!.openRead());
    stream.cast();
    var length = await _image!.length();
    var uri = Uri.parse("https://fakestoreapi.com/products");
    var request = http.MultipartRequest("POST", uri);
    request.fields["title"] = "Static title";
    var multiport = http.MultipartFile('image', stream, length);
    request.files.add(multiport);
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print("IMAGE UPLOADED");
    } else {
      print("FAILED");
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uplod Image POST API"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _image != null
                  ? ClipOval(
                      child: Image.file(
                        _image!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipOval(
                      child: Image.network(
                        "https://t3.ftcdn.net/jpg/03/45/10/56/360_F_345105666_unijzjxqEvT04GUSjmA5WyMEIsXbrsRb.jpg",
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
              const SizedBox(height: 20),
              CustomButton(
                  title: "Pick form Gallery",
                  icon: Icons.image_outlined,
                  onClick: () {
                    getImage(ImageSource.gallery);
                  }),
              const SizedBox(height: 10),
              CustomButton(
                  title: "Pick Form Camera",
                  icon: Icons.camera,
                  onClick: () => getImage(ImageSource.camera)),
              CustomButton(
                  title: "Upload Picture",
                  icon: Icons.play_arrow,
                  onClick: () => uplodImage()),
            ],
          ),
        ),
      ),
    );
  }

  File? _image;

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      File? img = await saveFile(image.path);
      setState(() {
        _image = img;
      });
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future<File> saveFile(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File("${directory.path}/$name");
    return File(imagePath).copy(image.path);
  }

  Widget CustomButton({
    required String title,
    required IconData icon,
    required VoidCallback onClick,
  }) {
    return SizedBox(
      width: 280,
      child: ElevatedButton(
          onPressed: onClick,
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 20),
              Text(title),
            ],
          )),
    );
  }
}
