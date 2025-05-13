
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
void main() => runApp(CriminalFormPage());

class CriminalFormPage extends StatelessWidget {
  const CriminalFormPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Criminal Form Entry',
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
      home: Page1(),
    );
  }
}

class Page1 extends StatelessWidget {
  final nameController = TextEditingController();
  final fatherController = TextEditingController();
  final casteController = TextEditingController();
  final professionController = TextEditingController();
  final nativePlaceController = TextEditingController();
  final witnessesController = TextEditingController();
  final residenceController = TextEditingController();
  final visitedController = TextEditingController();
  final offenderClassController = TextEditingController();

  Page1({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Page 1: Personal Details")),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              field("Name and Aliases", nameController),
              field("Father's/Husband's Name", fatherController),
              field("Caste", casteController),
              field("Trade or Profession", professionController),
              field("Native Place (District & PS)", nativePlaceController),
              field("Certifying Witnesses (Names, Fathers' Names, Addresses)", witnessesController),
              field("Residence with Dates", residenceController),
              field("Places Visited with Dates", visitedController),
              field("Class of Offenders & M.O.", offenderClassController),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Next"),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Page2())),
              )
            ],
          ),
        ),
      );

  Widget field(String label, TextEditingController controller) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: controller, decoration: InputDecoration(border: OutlineInputBorder())),
          ],
        ),
      );
}


class Page2 extends StatelessWidget {
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final hairColorController = TextEditingController();
  final cutController = TextEditingController();
  final irisController = TextEditingController();
  final appearanceController = TextEditingController();
  final walkController = TextEditingController();
  final talkController = TextEditingController();

  final buildOptions = ['Thin', 'Stout', 'Erect', 'Stooping'];
  final eyebrowOptions = ['Thick', 'Thin', 'Arched', 'Straight', 'Meeting'];
  final foreheadOptions = ['High', 'Low', 'Upright', 'Sloping', 'Broad', 'Narrow'];
  final eyeOptions = ['Large', 'Small', 'Wide-Set', 'Close-Set'];
  final sightOptions = ['Long', 'Short', 'Wears Glasses'];
  final yesNo = ['Yes', 'No'];

  String? selectedBuild;
  String? selectedEyebrows;
  String? selectedForehead;
  String? selectedEyes;
  String? selectedSight;
  String? isBald;

  Page2({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Page 2: Physical Description")),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              field("Age", ageController),
              field("Height", heightController),
              dropdownField("Build", buildOptions, (val) => selectedBuild = val),
              field("Hair Color", hairColorController),
              dropdownField("Bald?", yesNo, (val) => isBald = val),
              field("Hair Cut Style", cutController),
              dropdownField("Eyebrows", eyebrowOptions, (val) => selectedEyebrows = val),
              dropdownField("Forehead", foreheadOptions, (val) => selectedForehead = val),
              dropdownField("Eyes", eyeOptions, (val) => selectedEyes = val),
              field("Color of Iris", irisController),
              dropdownField("Sight", sightOptions, (val) => selectedSight = val),
              field("Appearance (Upright/Slovenly)", appearanceController),
              field("Walk (Fast/Slow)", walkController),
              field("Talk (Fast/Slow, Loud/Harsh)", talkController),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Next"),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Page3())),
              )
            ],
          ),
        ),
      );

  Widget field(String label, TextEditingController controller) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: controller, decoration: InputDecoration(border: OutlineInputBorder())),
          ],
        ),
      );

  Widget dropdownField(String label, List<String> options, Function(String?) onChanged) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(border: OutlineInputBorder()),
              items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: onChanged,
            )
          ],
        ),
      );
}

class Page3 extends StatelessWidget {
  final TextEditingController beardController = TextEditingController();
  final TextEditingController moustacheDetailController = TextEditingController();
  final TextEditingController otherDescriptionController = TextEditingController();

  final List<String> dropdownFields = [
    'Nose', 'Mouth', 'Lips', 'Teeth', 'Finger', 'Chin', 'Ears', 'Face', 'Complexion', 'Moustache Style'
  ];
  final Map<String, List<String>> options = {
    'Nose': ['Large', 'Small', 'Poked', 'Snubbed', 'Thick', 'Thin'],
    'Mouth': ['Close', 'Shut', 'Shows Teeth'],
    'Lips': ['Thick', 'Thin', 'Protruding', 'Hair-Left', 'Long', 'Short', 'Upper'],
    'Teeth': ['Discolored', 'Irregular', 'Missing in Front'],
    'Finger': ['Long', 'Short', 'Stubbed', 'Pointed', 'Finger-Deformed'],
    'Chin': ['Receding', 'Protruding', 'Squared', 'Pointed', 'Long', 'Short'],
    'Ears': ['Large', 'Small', 'Protruding', 'Long-Lobes', 'Pierced', 'Set-Low', 'Set-High'],
    'Face': ['Long', 'Round', 'Smiling', 'Scowling', 'Wrinkled'],
    'Complexion': ['Fair', 'Brown', 'Black', 'Sallow'],
    'Moustache Style': ['Long', 'Chipped', 'Turned-Up', 'Drooping'],
  };

  Page3({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Page 3: Facial Features")),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...dropdownFields.map((label) => dropdownField(label, options[label]!)),
              field("Beard - Color, Length, Style", beardController),
              field("Moustache - Color, Length", moustacheDetailController),
              field("Any Other Descriptive Points", otherDescriptionController),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Next"),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Page4())),
              )
            ],
          ),
        ),
      );

  Widget field(String label, TextEditingController controller) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: controller, decoration: InputDecoration(border: OutlineInputBorder())),
          ],
        ),
      );

  Widget dropdownField(String label, List<String> items) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(border: OutlineInputBorder()),
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) {},
            )
          ],
        ),
      );
}

class Page4 extends StatelessWidget {
  final controllers = List.generate(9, (_) => TextEditingController());
  final labels = [
    'Marks on Hands', 'Marks on Face', 'Marks on Knees', 'Marks on Feet',
    'Peculiarities of Manner', 'Appearance', 'Deformities', 'Accomplishments', 'Habits'
  ];

  Page4({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Page 4: Marks and Mannerisms")),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ...List.generate(labels.length, (i) => field(labels[i], controllers[i])),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Next"),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Page5())),
              )
            ],
          ),
        ),
      );

  Widget field(String label, TextEditingController controller) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: controller, decoration: InputDecoration(border: OutlineInputBorder())),
          ],
        ),
      );
}

class Page5 extends StatefulWidget {
  const Page5({super.key});

  @override
  _Page5State createState() => _Page5State();
}
class _Page5State extends State<Page5> {
  final controllers = List.generate(9, (_) => TextEditingController());
  final labels = [
    'Relatives', 'Associates', 'Property Disposal Info', 'Past Arrests', 'Crime Localities',
    'Criminal History', 'Suspicion Cases', 'Convictions', 'Current Doings'
  ];

  final List<String> photoLabels = [
    'Full Face Photo', 'Full Length Photo', 'Head and Shoulder Photo', 'Profile Left','Right Photo'
  ];

  final Map<String, File?> photoFiles = {};

  Future<void> _pickImage(String label) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        photoFiles[label] = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Page 5: Social and Crime History")),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              ...List.generate(labels.length, (i) => field(labels[i], controllers[i])),
              ...photoLabels.map((label) => photoUploadField(label)),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Submit"),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Form submitted successfully!")),
                  );
                },
              )
            ],
          ),
        ),
      );

  Widget field(String label, TextEditingController controller) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: controller, decoration: InputDecoration(border: OutlineInputBorder())),
          ],
        ),
      );

  Widget photoUploadField(String label) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () => _pickImage(label),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  image: photoFiles[label] != null
                      ? DecorationImage(image: FileImage(photoFiles[label]!), fit: BoxFit.cover)
                      : null,
                ),
                child: photoFiles[label] == null
                    ? Center(child: Icon(Icons.camera_alt, size: 40, color: Colors.grey))
                    : null,
              ),
            )
          ],
        ),
      );
}