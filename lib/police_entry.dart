import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class PoliceFormPage extends StatelessWidget {
  const PoliceFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Police Form Entry',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Police Entry Form")),
        body: PoliceDetailsForm(),
      ),
    );
  }
}

class PoliceDetailsForm extends StatefulWidget {
  const PoliceDetailsForm({super.key});

  @override
  _PoliceDetailsFormState createState() => _PoliceDetailsFormState();
}

class _PoliceDetailsFormState extends State<PoliceDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final gNumberController = TextEditingController();
  final stationController = TextEditingController();
  final cpsController = TextEditingController();
  final ifhrmsController = TextEditingController();
  final contactController = TextEditingController();
  final fatherController = TextEditingController();
  final spouseController = TextEditingController();
  final permanentAddressController = TextEditingController();
  final presentAddressController = TextEditingController();
  final bankController = TextEditingController();
  final accountController = TextEditingController();
  final ifscController = TextEditingController();
  final branchController = TextEditingController();
  final aadharController = TextEditingController();
  final panController = TextEditingController();
  final casteController = TextEditingController();
  final educationController = TextEditingController();
  final presentStationController = TextEditingController();
  final previousStationController = TextEditingController();

  DateTime? dob, enlistmentDate, promotionDate, presentJoinDate, prevJoinDate, prevEndDate;

  final ranks = ['The Superintendent of Police','Additional Superintendent of Police','Deputy Superintendent of Police','Constable','Inspector','SI','Head Constable','GR I Constable','GR II Constable'];
  final maritalStatuses = ['Single', 'Married', 'Divorced', 'Widowed'];
  final religions = ['Hindu', 'Muslim', 'Christian', 'Other'];
  final communities = ['SC', 'ST', 'OBC', 'General'];
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  final photoTypes = ['Passport Size', 'Full Size'];

  String? selectedRank, maritalStatus, religion, community, bloodGroup, photoType;
  String? photoPath;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        photoPath = result.files.single.path;
      });
    }
  }

  Future<void> submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    final data = {
      "name": nameController.text,
      "rank": selectedRank,
      "g_number": gNumberController.text,
      "station": stationController.text,
      "date_of_enlistment": enlistmentDate?.toIso8601String(),
      "date_of_promotion": promotionDate?.toIso8601String(),
      "date_of_birth": dob?.toIso8601String(),
      "cps_number": cpsController.text,
      "ifhrms_number": ifhrmsController.text,
      "contact_number": contactController.text,
      "father_name": fatherController.text,
      "marital_status": maritalStatus,
      "spouse_name": spouseController.text,
      "permanent_address": permanentAddressController.text,
      "present_address": presentAddressController.text,
      "bank_name": bankController.text,
      "account_number": accountController.text,
      "ifsc_code": ifscController.text,
      "branch": branchController.text,
      "aadhar_number": aadharController.text,
      "pan_number": panController.text,
      "religion": religion,
      "community": community,
      "caste": casteController.text,
      "education": educationController.text,
      "blood_group": bloodGroup,
      "present_station_name": presentStationController.text,
      "present_station_join_date": presentJoinDate?.toIso8601String(),
      "previous_station_name": previousStationController.text,
      "previous_station_join_date": prevJoinDate?.toIso8601String(),
      "previous_station_end_date": prevEndDate?.toIso8601String(),
      "photo_type": photoType,
      "photo_file_path": photoPath,
    };

    try {
      final response = await http.post(
        Uri.parse('http://your-api-endpoint.com/add_police'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      final msg = response.statusCode == 200 ? "Data submitted successfully" : "Submission failed";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error submitting form")));
    }
  }

  Widget field(String label, TextEditingController controller, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          TextFormField(
            controller: controller,
            validator: isRequired ? (v) => (v == null || v.isEmpty) ? 'Required' : null : null,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          )
        ],
      ),
    );
  }

  Widget dropdown(String label, List<String> items, String? value, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: onChanged,
          )
        ],
      ),
    );
  }

  Widget datePicker(String label, DateTime? value, Function(DateTime) onPicked) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: value ?? DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
              );
              if (picked != null) setState(() => onPicked(picked));
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(value != null ? "${value.toLocal()}".split(' ')[0] : "Select Date"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            field("Name", nameController, isRequired: true),
            dropdown("Rank", ranks, selectedRank, (val) => setState(() => selectedRank = val)),
            field("G Number", gNumberController),
            field("Station", stationController),
            datePicker("Date of Enlistment", enlistmentDate, (val) => enlistmentDate = val),
            datePicker("Date of Promotion", promotionDate, (val) => promotionDate = val),
            datePicker("Date of Birth", dob, (val) => dob = val),
            field("CPS Number", cpsController),
            field("IFHRMS Number", ifhrmsController),
            field("Contact Number", contactController),
            field("Father Name", fatherController),
            dropdown("Marital Status", maritalStatuses, maritalStatus, (val) => setState(() => maritalStatus = val)),
            field("Spouse Name", spouseController),
            field("Permanent Address", permanentAddressController),
            field("Present Address", presentAddressController),
            field("Bank Name", bankController),
            field("Account Number", accountController),
            field("IFSC Code", ifscController),
            field("Branch", branchController),
            field("Aadhar Number", aadharController),
            field("PAN Number", panController),
            dropdown("Religion", religions, religion, (val) => setState(() => religion = val)),
            dropdown("Community", communities, community, (val) => setState(() => community = val)),
            field("Caste", casteController),
            field("Education", educationController),
            dropdown("Blood Group", bloodGroups, bloodGroup, (val) => setState(() => bloodGroup = val)),
            field("Present Station Name", presentStationController),
            datePicker("Present Station Join Date", presentJoinDate, (val) => presentJoinDate = val),
            field("Previous Station Name", previousStationController),
            datePicker("Previous Station Join Date", prevJoinDate, (val) => prevJoinDate = val),
            datePicker("Previous Station End Date", prevEndDate, (val) => prevEndDate = val),
            dropdown("Photo Type", photoTypes, photoType, (val) => setState(() => photoType = val)),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: pickFile,
              icon: const Icon(Icons.upload_file),
              label: Text(photoPath != null ? "Change Photo" : "Upload Photo"),
            ),
            if (photoPath != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text("Selected: ${photoPath!.split('/').last}", style: const TextStyle(fontStyle: FontStyle.italic)),
              ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: submitForm,
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
