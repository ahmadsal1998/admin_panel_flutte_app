// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:admin_panel/constants/constants.dart';
import 'package:admin_panel/helpers/firebase_storage_helper/firebase_storage_helper.dart';
import 'package:admin_panel/models/category_model/category_model.dart';
import 'package:admin_panel/models/user_model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_provider.dart';


class EditCategory extends StatefulWidget {
  final CategoryModel categoryModel;
  final int index;
  const EditCategory({super.key,required this.index, required this.categoryModel});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {


  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Category Edit",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: const CircleAvatar(
                      radius: 55, child: Icon(Icons.camera_alt)),
                )
              : CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 55,
                  ),
                ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: name,
            decoration: InputDecoration(
              hintText: widget.categoryModel.name,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ElevatedButton(
            child: const Text("Update"),
            onPressed: () async {
              if(image == null && name.text.isEmpty){
                Navigator.of(context).pop();

              }else if(image != null){
               String imageUrl = await FirebaseStorageHelper.instance.uploadUserImage(widget.categoryModel.id,image!);
              CategoryModel categoryModel =widget.categoryModel.copyWith(
                image: imageUrl,
                name: name.text.isEmpty?null:name.text,
              );
              appProvider.updateCategoryList(widget.index,categoryModel);
              showMessage("Update Successfuly");
              }else{
              CategoryModel categoryModel =widget.categoryModel.copyWith(
                name: name.text.isEmpty?null:name.text,
              );
              appProvider.updateCategoryList(widget.index,categoryModel);
              showMessage("Update Successfuly");
              
              }
       //       Navigator.of(context).pop();
            
         //     appProvider.updateUserInfoFirebase(context, userModel, image);
            
            },
          ),
        ],
      ),
    );
  }
}
