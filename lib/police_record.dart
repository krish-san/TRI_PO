import 'package:flutter/material.dart';
import 'widgets/search_bar.dart';
import 'services/police_service.dart';

class PoliceDashboard extends StatefulWidget {
  const PoliceDashboard({Key? key}) : super(key: key);

  @override
  State<PoliceDashboard> createState() => _PoliceDashboardState();
}

class _PoliceDashboardState extends State<PoliceDashboard> {
  final PoliceService _policeService = PoliceService();
  final List<Map<String, dynamic>> policeList = List.generate(10, (index) => {
        "id": "POL${index + 1}",
        "firstName": "None",
        "lastName": "None",
        "rank": "None",
        "badgeNumber": "None",
        "department": "None",
        "joinDate": "None",
        "contactNumber": "None",
        "email": "None",
        "station": "None",
        "status": "Active",
        "photo": "",
      });
  List<Map<String, dynamic>> filteredList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    filteredList = policeList;
  }

  Future<void> _handleSearch(String query) async {
    setState(() => isLoading = true);
    
    try {
      if (query.isEmpty) {
        setState(() {
          filteredList = policeList;
          isLoading = false;
        });
        return;
      }

      final result = await _policeService.searchPoliceById(query);
      
      setState(() {
        if (result != null) {
          filteredList = [result];
        } else {
          filteredList = [];
        }
        isLoading = false;
      });
    } catch (e) {
      print('Error during search: $e');
      setState(() {
        filteredList = [];
        isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error searching for police record'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Police Records'),
        centerTitle: true,
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
                        'Police records will be displayed here. Use the search bar to find specific records by ID.'),
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
      body: Column(
        children: [
          CustomSearchBar(
            onSearch: _handleSearch,
            hintText: 'Search police by ID...',
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            )
          else
            Expanded(
              child: filteredList.isEmpty
                  ? const Center(
                      child: Text('No records found'),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 3 / 4,
                      ),
                      itemBuilder: (context, index) {
                        final police = filteredList[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to detail view
                          },
                          child: Card(
                            elevation: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(4),
                                      ),
                                    ),
                                    child: police['photo'].isEmpty
                                        ? const Icon(Icons.person, size: 50)
                                        : Image.network(
                                            police['photo'],
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ID: ${police['id']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text('Rank: ${police['rank']}'),
                                        Text('Station: ${police['station']}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
        ],
      ),
    );
  }
}