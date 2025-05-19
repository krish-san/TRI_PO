import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CriminalFormPage extends StatelessWidget {
  const CriminalFormPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accused Entry Form"),
        elevation: 2,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(context),
          ),
        ],
      ),
      body: AccusedFormStepper(),
    );
  }
  
  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.help_outline, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            const Text("Help"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Accused Entry Form Instructions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "• Complete all sections of the form",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "• Upload clear photos for identification",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "• Be as detailed as possible in descriptions",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              "• Fields marked with * are mandatory",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}

class AccusedFormStepper extends StatefulWidget {
  const AccusedFormStepper({Key? key}) : super(key: key);

  @override
  _AccusedFormStepperState createState() => _AccusedFormStepperState();
}

class _AccusedFormStepperState extends State<AccusedFormStepper> {
  int _currentStep = 0;
  bool _isCompleted = false;
  
  // Personal Details
  final nameController = TextEditingController();
  final fatherController = TextEditingController();
  final casteController = TextEditingController();
  final professionController = TextEditingController();
  final nativePlaceController = TextEditingController();
  final witnessesController = TextEditingController();
  final residenceController = TextEditingController();
  final visitedController = TextEditingController();
  final offenderClassController = TextEditingController();

  // Physical Description
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final hairColorController = TextEditingController();
  final cutController = TextEditingController();
  final irisController = TextEditingController();
  final appearanceController = TextEditingController();
  final walkController = TextEditingController();
  final talkController = TextEditingController();

  // Facial Features
  final beardController = TextEditingController();
  final moustacheDetailController = TextEditingController();
  final otherDescriptionController = TextEditingController();

  // Marks and Mannerisms
  final List<TextEditingController> marksControllers = List.generate(9, (_) => TextEditingController());
  final List<String> marksLabels = [
    'Marks on Hands', 'Marks on Face', 'Marks on Knees', 'Marks on Feet',
    'Peculiarities of Manner', 'Appearance', 'Deformities', 'Accomplishments', 'Habits'
  ];

  // Social & Crime History
  final List<TextEditingController> historyControllers = List.generate(9, (_) => TextEditingController());
  final List<String> historyLabels = [
    'Relatives', 'Associates', 'Property Disposal Info', 'Past Arrests', 'Crime Localities',
    'Criminal History', 'Suspicion Cases', 'Convictions', 'Current Doings'
  ];

  // Dropdown values
  final buildOptions = ['Thin', 'Stout', 'Erect', 'Stooping'];
  final eyebrowOptions = ['Thick', 'Thin', 'Arched', 'Straight', 'Meeting'];
  final foreheadOptions = ['High', 'Low', 'Upright', 'Sloping', 'Broad', 'Narrow'];
  final eyeOptions = ['Large', 'Small', 'Wide-Set', 'Close-Set'];
  final sightOptions = ['Long', 'Short', 'Wears Glasses'];
  final yesNo = ['Yes', 'No'];
  final dropdownFields = [
    'Nose', 'Mouth', 'Lips', 'Teeth', 'Finger', 'Chin', 'Ears', 'Face', 'Complexion', 'Moustache Style'
  ];
  final Map<String, List<String>> options = {
    'Nose': ['Roman', 'Straight', 'Snub', 'Hooked', 'Flat'],
    'Mouth': ['Large', 'Small', 'Protruding'],
    'Lips': ['Thick', 'Thin', 'Even', 'Protruding'],
    'Teeth': ['Regular', 'Irregular', 'Broken', 'Missing'],
    'Finger': ['Large', 'Small', 'Missing', 'Extra'],
    'Chin': ['Round', 'Square', 'Pointed', 'Double', 'Receding', 'Protruding'],
    'Ears': ['Large', 'Small', 'Flat', 'Protruding', 'Round', 'Pointed'],
    'Face': ['Round', 'Oval', 'Square', 'Thin'],
    'Complexion': ['Fair', 'Wheatish', 'Brown', 'Dark'],
    'Moustache Style': ['Long', 'Chipped', 'Turned-Up', 'Drooping'],
  };

  // Selected values
  String? selectedBuild;
  String? selectedEyebrows;
  String? selectedForehead;
  String? selectedEyes;
  String? selectedSight;
  String? isBald;
  Map<String, String?> facialFeatureValues = {};
  
  // Photos
  final List<String> photoLabels = [
    'Full Face Photo', 'Full Length Photo', 'Head and Shoulder Photo', 'Profile Left', 'Right Photo'
  ];
  final Map<String, File?> photoFiles = {};

  @override
  void initState() {
    super.initState();
    // Initialize the dropdown fields map
    for (String field in dropdownFields) {
      facialFeatureValues[field] = null;
    }
  }
  
  @override
  void dispose() {
    // Dispose all controllers
    nameController.dispose();
    fatherController.dispose();
    casteController.dispose();
    professionController.dispose();
    nativePlaceController.dispose();
    witnessesController.dispose();
    residenceController.dispose();
    visitedController.dispose();
    offenderClassController.dispose();
    ageController.dispose();
    heightController.dispose();
    hairColorController.dispose();
    cutController.dispose();
    irisController.dispose();
    appearanceController.dispose();
    walkController.dispose();
    talkController.dispose();
    beardController.dispose();
    moustacheDetailController.dispose();
    otherDescriptionController.dispose();
    
    for (var controller in marksControllers) {
      controller.dispose();
    }
    
    for (var controller in historyControllers) {
      controller.dispose();
    }
    
    super.dispose();
  }

  Future<void> _pickImage(String label) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        photoFiles[label] = File(picked.path);
      });
    }
  }

  void _submitForm() {
    // In a real app, we would send the data to a backend server
    setState(() {
      _isCompleted = true;
    });
    
    // Show success dialog
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
              "Accused information submitted successfully!",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Name: ${nameController.text}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              "Age: ${ageController.text}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            if (photoFiles.isNotEmpty)
              Text(
                "Photos uploaded: ${photoFiles.length}",
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

  @override
  Widget build(BuildContext context) {
    return _isCompleted
        ? _buildCompletionScreen()
        : Stepper(
            type: StepperType.vertical,
            physics: ClampingScrollPhysics(),
            currentStep: _currentStep,
            onStepContinue: () {
              if (_currentStep < 4) {
                setState(() => _currentStep++);
              } else {
                _submitForm();
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() => _currentStep--);
              }
            },
            onStepTapped: (index) {
              setState(() => _currentStep = index);
            },
            controlsBuilder: (context, details) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: details.onStepContinue,
                        icon: _currentStep == 4 
                            ? Icon(Icons.check) 
                            : Icon(Icons.arrow_forward),
                        label: Text(_currentStep == 4 ? 'Submit' : 'Continue'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    if (_currentStep > 0) SizedBox(width: 12),
                    if (_currentStep > 0)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: details.onStepCancel,
                          icon: Icon(Icons.arrow_back),
                          label: Text('Back'),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
            steps: [
              _buildPersonalDetailsStep(),
              _buildPhysicalDescriptionStep(),
              _buildFacialFeaturesStep(),
              _buildMarksStep(),
              _buildSocialCrimeStep(),
            ],
          );
  }

  Step _buildPersonalDetailsStep() {
    return Step(
      isActive: _currentStep >= 0,
      title: Text('Personal Details', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        children: [
          field("Name and Aliases", nameController, required: true),
          field("Father's/Husband's Name", fatherController, required: true),
          field("Caste", casteController),
          field("Trade or Profession", professionController),
          field("Native Place (District & PS)", nativePlaceController),
          field("Certifying Witnesses", witnessesController),
          field("Residence with Dates", residenceController),
          field("Places Visited with Dates", visitedController),
          field("Class of Offenders & M.O.", offenderClassController),
        ],
      ),
    );
  }

  Step _buildPhysicalDescriptionStep() {
    return Step(
      isActive: _currentStep >= 1,
      title: Text('Physical Description', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        children: [
          field("Age", ageController, required: true),
          field("Height", heightController, required: true),
          dropdownField("Build", buildOptions, selectedBuild, (val) => setState(() => selectedBuild = val)),
          field("Hair Color", hairColorController),
          dropdownField("Bald?", yesNo, isBald, (val) => setState(() => isBald = val)),
          field("Hair Cut Style", cutController),
          dropdownField("Eyebrows", eyebrowOptions, selectedEyebrows, (val) => setState(() => selectedEyebrows = val)),
          dropdownField("Forehead", foreheadOptions, selectedForehead, (val) => setState(() => selectedForehead = val)),
          dropdownField("Eyes", eyeOptions, selectedEyes, (val) => setState(() => selectedEyes = val)),
          field("Color of Iris", irisController),
          dropdownField("Sight", sightOptions, selectedSight, (val) => setState(() => selectedSight = val)),
          field("Appearance (Upright/Slovenly)", appearanceController),
          field("Walk (Fast/Slow)", walkController),
          field("Talk (Fast/Slow, Loud/Harsh)", talkController),
        ],
      ),
    );
  }

  Step _buildFacialFeaturesStep() {
    return Step(
      isActive: _currentStep >= 2,
      title: Text('Facial Features', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        children: [
          ...dropdownFields.map(
            (field) => dropdownField(
              field, 
              options[field] ?? [], 
              facialFeatureValues[field], 
              (val) => setState(() => facialFeatureValues[field] = val)
            )
          ),
          field("Beard - Color, Length, Style", beardController),
          field("Moustache - Color, Length", moustacheDetailController),
          field("Any Other Descriptive Points", otherDescriptionController),
        ],
      ),
    );
  }

  Step _buildMarksStep() {
    return Step(
      isActive: _currentStep >= 3,
      title: Text('Marks & Mannerisms', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        children: [
          ...List.generate(
            marksLabels.length, 
            (i) => field(marksLabels[i], marksControllers[i])
          ),
        ],
      ),
    );
  }

  Step _buildSocialCrimeStep() {
    return Step(
      isActive: _currentStep >= 4,
      title: Text('Social & Crime History', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        children: [
          ...List.generate(
            historyLabels.length, 
            (i) => field(historyLabels[i], historyControllers[i])
          ),
          SizedBox(height: 16),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "Photo Identification",
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary
              ),
            ),
          ),
          ...photoLabels.map((label) => photoUploadField(label)),
        ],
      ),
    );
  }

  Widget _buildCompletionScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              size: 60,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 24),
          Text(
            "Form Submitted Successfully!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "The accused data has been recorded.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.home),
            label: Text("Return to Home"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget field(String label, TextEditingController controller, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            required ? "$label *" : label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.blueGrey[800]
                  : Colors.blueGrey[200],
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade50
                  : Colors.grey.shade900,
            ),
          ),
        ],
      ),
    );
  }

  Widget dropdownField(String label, List<String> items, String? value, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
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
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade50
                  : Colors.grey.shade900,
            ),
            items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: onChanged,
            hint: Text("Select ${label.toLowerCase()}"),
            icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.primary),
            isExpanded: true,
          ),
        ],
      ),
    );
  }

  Widget photoUploadField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.blueGrey[800]
                  : Colors.blueGrey[200],
            ),
          ),
          const SizedBox(height: 6),
          InkWell(
            onTap: () => _pickImage(label),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: photoFiles[label] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.file(photoFiles[label]!, fit: BoxFit.cover),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                        SizedBox(height: 8),
                        Text(
                          "Tap to upload",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
            ),
          ),
          if (photoFiles[label] != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => setState(() => photoFiles[label] = null),
                    icon: Icon(Icons.delete_outline, size: 16, color: Colors.red),
                    label: Text("Remove", style: TextStyle(color: Colors.red)),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}