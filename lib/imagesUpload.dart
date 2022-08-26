
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class ImagesUpload extends StatefulWidget {
  const ImagesUpload({Key? key}) : super(key: key);

  @override
  _ImagesUploadState createState() => _ImagesUploadState();
}

class _ImagesUploadState extends State<ImagesUpload> {

  File? image;
  final _picker = ImagePicker();
  bool showspinner = false;
  
  // create function to get image...

  Future getImage()async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if(pickedFile!= null){
      image = File(pickedFile.path);
      setState(() {

      });
    }else{
     print('no image selected');
    }
  }
  
  // create function to upload a image...
  
  Future<void> uploadImage()async{
    
    setState(() {
      showspinner = true;
    });
    
    // now upload image on server with the help of stream...
    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    
    // now give length to stream variable
    var length = await image!.length();
    
    // provide url for upload image...
    var uri = Uri.parse('https://fakestoreapi.com/products');

    // now send a request to a server...
    var request = new http.MultipartRequest('POST', uri);
    request.fields['title'] = 'Static title';

    // now asign a image...
    var multipart = new http.MultipartFile(
        'image',
        stream,
        length);

    request.files.add(multipart);

    // now wait a request response...
    var response = await request.send();
    print(response.stream.toString());
     if(response.statusCode == 200){
       setState(() {
         showspinner = false;
       });
       print('image uploaded');
     }else{
       print('failed');
       setState(() {
         showspinner = false;
       });
     }
  }
  
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Upload Image'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                child: image == null ? Center(child:Text('Pick Image'),):
                    Container(
                      child: Center(
                        child: Image.file(
                          File(image!.path).absolute,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover ,
                        ),
                      ),
                    ),
              ),
            ),
            SizedBox(height: 150,),

            GestureDetector(
              onTap: (){
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 200,
                color: Colors.green,
                child: Center(child: Text('Upload')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
