import 'package:flutter/material.dart';

class AccusedDashboard extends StatelessWidget {
  AccusedDashboard({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> accusedList = List.generate(10, (index) => {
        "firstName": "None",
        "lastName": "None",
        "gender": "None",
        "dob": "None",
        "age": "None",
        "height": "None",
        "weight": "None",
        "skinColor": "None",
        "complexion": "None",
        "eyeColor": "None",
        "hairColor": "None",
        "birthMark": "None",
        "mobileNumber": "None",
        "fatherName": "None",
        "motherName": "None",
        "guardianName": "None",
        "address": "None",
        "placeOfBirth": "None",
        "photos": {
          "fullFace": "",
          "fullLength": "",
          "headAndShoulder": "",
          "profileLeft": "",
          "profileRight": ""
        },
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accused Records'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Help'),
                    content: const Text(
                        'Accused records will be displayed once you click a particular accused.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      )
                    ],
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white24,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(
                    Icons.help_outline,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: accusedList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 cards per row
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 3 / 4,
        ),
        itemBuilder: (context, index) {
          final accused = accusedList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AccusedDetail(
                    accused: accused,
                    accusedNumber: index + 1,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 100,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.photo_camera_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Accused Number/${index + 1}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AccusedDetail extends StatelessWidget {
  final Map<String, dynamic> accused;
  final int accusedNumber;

  const AccusedDetail(
      {Key? key, required this.accused, required this.accusedNumber})
      : super(key: key);

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget buildPhoto(String label, String url) {
    return Column(
      children: [
        Container(
          width: 150,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: url.isEmpty
              ? const Icon(Icons.photo_camera_outlined, size: 60, color: Colors.grey)
              : Container(color:Colors.grey.shade300,
              child:Image.network(url,fit:BoxFit.cover),),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final photos = accused['photos'] as Map<String, String>? ?? {};

    return Scaffold(
      appBar: AppBar(title: Text('Accused Number/$accusedNumber Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Personal Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            buildInfoRow('First Name:', accused['firstName'] ?? 'None'),
            buildInfoRow('Last Name:', accused['lastName'] ?? 'None'),
            buildInfoRow('Gender:', accused['gender'] ?? 'None'),
            buildInfoRow('Date of Birth:', accused['dob'] ?? 'None'),
            buildInfoRow('Age:', accused['age'].toString()),
            buildInfoRow('Height:', accused['height'] ?? 'None'),
            buildInfoRow('Weight:', accused['weight'] ?? 'None'),
            buildInfoRow('Skin Color:', accused['skinColor'] ?? 'None'),
            buildInfoRow('Complexion:', accused['complexion'] ?? 'None'),
            buildInfoRow('Eye Color:', accused['eyeColor'] ?? 'None'),
            buildInfoRow('Hair Color:', accused['hairColor'] ?? 'None'),
            buildInfoRow('Birth Mark:', accused['birthMark'] ?? 'None'),
            const SizedBox(height: 16),
            const Text('Contact & Family Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            buildInfoRow('Mobile Number:', accused['mobileNumber'] ?? 'None'),
            buildInfoRow('Father\'s Name:', accused['fatherName'] ?? 'None'),
            buildInfoRow('Mother\'s Name:', accused['motherName'] ?? 'None'),
            buildInfoRow('Guardian\'s Name:', accused['guardianName'] ?? 'None'),
            buildInfoRow('Address:', accused['address'] ?? 'None'),
            buildInfoRow('Place of Birth:', accused['placeOfBirth'] ?? 'None'),
            const SizedBox(height: 16),
            const Text('Photographs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                buildPhoto('Full Face', photos['fullFace'] ?? ''),
                buildPhoto('Full Length', photos['fullLength'] ?? ''),
                buildPhoto('Head & Shoulders', photos['headAndShoulder'] ?? ''),
                buildPhoto('Profile Left', photos['profileLeft'] ?? ''),
                buildPhoto('Profile Right', photos['profileRight'] ?? ''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}




