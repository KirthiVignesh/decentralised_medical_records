import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:web3dart/web3dart.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}
class _BasicInfoState extends State<BasicInfo> {
  int cStep = 0;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _postCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _medicalController = TextEditingController();
  final _genderController = GroupController();

  final BasicInfo = GlobalKey<FormState>();
  final dateOfBirth = DateRangePickerController();
  final _nameValidator = RequiredValidator(errorText: "Field is required");
 

  String? uid = FirebaseAuth.instance.currentUser?.uid;
  bool isUploadedAadhar = false;
  bool isUploadedPan = false;
  bool isUploadedSign = false;

  void submitForm() async {
    Future<void> generateUserKey() async {
var cred = EthPrivateKey.createRandom(Random.secure());
    FirebaseFirestore.instance.collection('info').doc(uid).set({
      'first_name': _firstNameController.text.trim(),
      'last_name': _lastNameController.text.trim(),
      'phone_number': int.parse(_phoneController.text.toString()),
      'date_of_birth': dateOfBirth.selectedDate,
      'address': _address1Controller.text.trim(),
      'blood_group':_address2Controller.text.trim(),
      'medical_condtions':_medicalController.text.trim(),
      'secret_key': cred.privateKey
    });
    FirebaseFirestore.instance.collection('account').doc(uid).set({
      'first_name': _firstNameController.text.trim(),
      'secret_key': cred.privateKey,
      'address': cred.address,
    });
  }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Enter the basic information"),
        ),
        body: SingleChildScrollView(child: Column(
            children: [
              TextFormField(
                validator: _nameValidator,
                controller: _firstNameController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo),
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'First Name',
                    fillColor: Colors.white,
                    filled: true),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: _nameValidator,
                controller: _lastNameController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo),
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'Last Name',
                    fillColor: Colors.white,
                    filled: true),
              ),
              SizedBox(
                height: 5,
              ),
              Text("Select Date of Birth"),
              SizedBox(
                height: 5,
              ),
              SfDateRangePicker(
                minDate: DateTime(1930),
                maxDate: DateTime(DateTime.now().year),
                allowViewNavigation: true,
                controller: dateOfBirth,
                selectionMode: DateRangePickerSelectionMode.single,
                confirmText: 'Confirm Date',
                showActionButtons: true,
                cancelText: 'Reset',
                onCancel: () => setState(() => dateOfBirth.selectedDate =
                    DateTime(DateTime.now().year - 16)),
              ),
              SimpleGroupedCheckbox<String>(
                controller: _genderController,
                itemsTitle: ["Male", "Female", "Other"],
                values: ['Male', "Female", "Other"],
                groupStyle: GroupStyle(
                    itemTitleStyle: TextStyle(fontSize: 13)),
                checkFirstElement: false,
              ),
            
                TextFormField(
                  validator: _nameValidator,
                  controller: _address1Controller,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Address',
                      fillColor: Colors.white,
                      filled: true),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: _nameValidator,
                  controller: _address2Controller,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Blood Group',
                      fillColor: Colors.white,
                      filled: true),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _medicalController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Medical Complications',
                      fillColor: Colors.white,
                      filled: true),
                ),
                SizedBox(
                  height: 5,
                ),
                
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Phone number',
                      fillColor: Colors.white,
                      filled: true),
                ),
                TextButton(onPressed: submitForm, child: Text("Submit Basic Information"))
              ],
            ),)
      ),
    );
  }
}
