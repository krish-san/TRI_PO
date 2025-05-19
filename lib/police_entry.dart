import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'utils/dashed_border.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PoliceFormPage extends StatelessWidget {
  const PoliceFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Police Personnel Entry"),
        centerTitle: true,
        elevation: 2,
      ),
      body: const PoliceDetailsForm(),
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
  final _pageController = PageController();
  int _currentPage = 0;
  bool _isSubmitting = false;

  // Personal Information
  final nameController = TextEditingController();
  final gNumberController = TextEditingController();
  final cpsController = TextEditingController();
  final ifhrmsController = TextEditingController();
  final contactController = TextEditingController();
  final fatherController = TextEditingController();
  final spouseController = TextEditingController();
  DateTime? dob;

  // Professional Information
  final stationController = TextEditingController();
  final presentStationController = TextEditingController();
  final previousStationController = TextEditingController();
  DateTime? enlistmentDate, promotionDate, presentJoinDate, prevJoinDate, prevEndDate;

  // Address & Banking Information
  final permanentAddressController = TextEditingController();
  final presentAddressController = TextEditingController();
  final bankController = TextEditingController();
  final accountController = TextEditingController();
  final ifscController = TextEditingController();
  final branchController = TextEditingController();

  // Other Information
  final aadharController = TextEditingController();
  final panController = TextEditingController();
  final casteController = TextEditingController();
  final educationController = TextEditingController();

  final ranks = ['The Superintendent of Police', 'Additional Superintendent of Police', 
                'Deputy Superintendent of Police', 'Constable', 'Inspector', 'SI', 
                'Head Constable', 'GR I Constable', 'GR II Constable'];
  final maritalStatuses = ['Single', 'Married', 'Divorced', 'Widowed'];
  final religions = ['Hindu', 'Muslim', 'Christian', 'Other'];
  final communities = ['SC', 'ST', 'OBC', 'General'];
  final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  final photoTypes = ['Passport Size', 'Full Size'];

  String? selectedRank, maritalStatus, religion, community, bloodGroup, photoType;
  String? photoPath;
  
  List<String> _formSectionTitles = [
    "Personal Information",
    "Professional Details",
    "Address & Banking",
    "Additional Information"
  ];

  @override
  void dispose() {
    _pageController.dispose();
    
    // Dispose all controllers
    nameController.dispose();
    gNumberController.dispose();
    stationController.dispose();
    cpsController.dispose();
    ifhrmsController.dispose();
    contactController.dispose();
    fatherController.dispose();
    spouseController.dispose();
    permanentAddressController.dispose();
    presentAddressController.dispose();
    bankController.dispose();
    accountController.dispose();
    ifscController.dispose();
    branchController.dispose();
    aadharController.dispose();
    panController.dispose();
    casteController.dispose();
    educationController.dispose();
    presentStationController.dispose();
    previousStationController.dispose();
    
    super.dispose();
  }

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
    
    setState(() => _isSubmitting = true);
    
    try {
      final data = {
        "name": nameController.text,
        "rank": selectedRank,
        "g_number": gNumberController.text,
        "station": stationController.text,
        "enlistment_date": enlistmentDate?.toIso8601String(),
        "promotion_date": promotionDate?.toIso8601String(),
        "dob": dob?.toIso8601String(),
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
        "present_join_date": presentJoinDate?.toIso8601String(),
        "previous_station_name": previousStationController.text,
        "previous_join_date": prevJoinDate?.toIso8601String(),
        "previous_end_date": prevEndDate?.toIso8601String(),
        "photo_type": photoType,
      };

      // Mock successful submission
      await Future.delayed(const Duration(seconds: 2));
      
      // Show success dialog
      _showSuccessDialog();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error submitting form: $e")),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }
  
  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      submitForm();
    }
  }
  
  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 10),
            Text("Success"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personnel information saved successfully!",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Name: ${nameController.text}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              "Rank: ${selectedRank ?? 'Not specified'}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              "ID: ${gNumberController.text}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget field(String label, TextEditingController controller, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label + (isRequired ? " *" : ""),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.blueGrey[800]
                  : Colors.blueGrey[200],
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            validator: isRequired
                ? (v) => (v == null || v.isEmpty) ? 'This field is required' : null
                : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade50
                  : Colors.grey.shade900,
            ),
          )
        ],
      ),
    );
  }

  Widget dropdown(String label, List<String> items, String? value, Function(String?) onChanged, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label + (isRequired ? " *" : ""),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.blueGrey[800]
                  : Colors.blueGrey[200],
            ),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade50
                  : Colors.grey.shade900,
            ),
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: onChanged,
            validator: isRequired
                ? (v) => (v == null || v.isEmpty) ? 'Please select an option' : null
                : null,
            icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.primary),
            isExpanded: true,
            hint: Text("Select ${label.toLowerCase()}"),
            dropdownColor: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.grey.shade800,
          )
        ],
      ),
    );
  }

  Widget datePicker(String label, DateTime? value, Function(DateTime) onPicked, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label + (isRequired ? " *" : ""),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.blueGrey[800]
                  : Colors.blueGrey[200],
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: value ?? DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime.now(),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: Theme.of(context).colorScheme.primary,
                        onPrimary: Colors.white,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) setState(() => onPicked(picked));
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade50
                    : Colors.grey.shade900,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value != null ? "${value.toLocal()}".split(' ')[0] : "Select Date",
                      style: TextStyle(
                        color: value != null ? null : Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
          if (isRequired && value == null)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 12),
              child: Text(
                "This field is required",
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeaderProgress(),
          Expanded(
            child: Form(
              key: _formKey,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildPersonalInfoPage(),
                  _buildProfessionalInfoPage(),
                  _buildAddressBankingPage(),
                  _buildAdditionalInfoPage(),
                ],
              ),
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }
  
  Widget _buildHeaderProgress() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formSectionTitles[_currentPage],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: (_currentPage + 1) / 4,
            backgroundColor: Colors.grey.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(10),
            minHeight: 6,
          ),
          const SizedBox(height: 8),
          Text(
            "Step ${_currentPage + 1} of 4",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPersonalInfoPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          field("Full Name", nameController, isRequired: true),
          dropdown("Rank", ranks, selectedRank, (val) => setState(() => selectedRank = val), isRequired: true),
          field("G Number", gNumberController, isRequired: true),
          field("Contact Number", contactController, isRequired: true),
          datePicker("Date of Birth", dob, (val) => dob = val, isRequired: true),
          dropdown("Marital Status", maritalStatuses, maritalStatus, 
                 (val) => setState(() => maritalStatus = val)),
          field("Father's Name", fatherController),
          field("Spouse Name", spouseController),
        ],
      ),
    );
  }
  
  Widget _buildProfessionalInfoPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          field("Current Station", stationController, isRequired: true),
          datePicker("Date of Enlistment", enlistmentDate, (val) => enlistmentDate = val, isRequired: true),
          datePicker("Date of Last Promotion", promotionDate, (val) => promotionDate = val),
          field("CPS Number", cpsController),
          field("IFHRMS Number", ifhrmsController),
          field("Present Station Name", presentStationController),
          datePicker("Present Station Join Date", presentJoinDate, (val) => presentJoinDate = val),
          field("Previous Station Name", previousStationController),
          datePicker("Previous Station Join Date", prevJoinDate, (val) => prevJoinDate = val),
          datePicker("Previous Station End Date", prevEndDate, (val) => prevEndDate = val),
        ],
      ),
    );
  }
  
  Widget _buildAddressBankingPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          field("Permanent Address", permanentAddressController, isRequired: true),
          field("Present Address", presentAddressController),
          field("Bank Name", bankController),
          field("Account Number", accountController),
          field("IFSC Code", ifscController),
          field("Branch", branchController),
        ],
      ),
    );
  }
  
  Widget _buildAdditionalInfoPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          field("Aadhar Number", aadharController),
          field("PAN Number", panController),
          dropdown("Religion", religions, religion, (val) => setState(() => religion = val)),
          dropdown("Community", communities, community, (val) => setState(() => community = val)),
          field("Caste", casteController),
          dropdown("Blood Group", bloodGroups, bloodGroup, (val) => setState(() => bloodGroup = val)),
          field("Education", educationController),
          dropdown("Photo Type", photoTypes, photoType, (val) => setState(() => photoType = val)),
          const SizedBox(height: 16),
          _buildPhotoUpload(),
        ],
      ),
    );
  }
  
  Widget _buildPhotoUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload Photo",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.blueGrey[800]
                : Colors.blueGrey[200],
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: pickFile,
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: DashedBorder.all(
                color: Colors.grey.withOpacity(0.3),
                width: 2,
                dashPattern: [6, 3],
              ),
            ),
            child: photoPath != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(photoPath!),
                      fit: BoxFit.cover,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Click to upload photo",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "JPG, PNG or JPEG (max. 5MB)",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -3),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          if (_currentPage > 0)
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _previousPage,
                icon: const Icon(Icons.arrow_back),
                label: const Text("Previous"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  foregroundColor: Colors.black87,
                ),
              ),
            ),
          if (_currentPage > 0) const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: _isSubmitting ? null : _nextPage,
              icon: _currentPage == 3
                  ? const Icon(Icons.check)
                  : const Icon(Icons.arrow_forward),
              label: _isSubmitting
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(_currentPage == 3 ? "Submitting..." : "Next"),
                      ],
                    )
                  : Text(_currentPage == 3 ? "Submit" : "Next"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
