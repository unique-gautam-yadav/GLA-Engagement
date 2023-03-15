import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyFilterPage extends StatefulWidget {
  @override
  _MyFilterPageState createState() => _MyFilterPageState();
}

class _MyFilterPageState extends State<MyFilterPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String? _selectedBrand;
  List<String>? _selectedSizes = [];
  List<String> _brands = ['All', 'Nike', 'Adidas', 'Puma'];
  List<String> _sizes = ['All', 'Small', 'Medium', 'Large', 'X-Large'];

  late Query query;

  @override
  void initState() {
    super.initState();
    query = _db.collection('user');
  }

  @override
  Widget build(BuildContext context) {
    // Apply filters to the query
    if (_selectedBrand != null && _selectedBrand != 'All') {
      query = query.where('brand', isEqualTo: _selectedBrand);
    }
    if (_selectedSizes != null &&
        _selectedSizes!.isNotEmpty &&
        !_selectedSizes!.contains('All')) {
      query = query.where('sizes', arrayContainsAny: _selectedSizes);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Brands',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            DropdownButton<String>(
              value: _selectedBrand,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBrand = newValue;
                });
              },
              items: _brands.map((String brand) {
                return DropdownMenuItem<String>(
                  value: brand,
                  child: Text(brand),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Text(
              'Sizes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Column(
              children: _sizes.map((String size) {
                return CheckboxListTile(
                  title: Text(size),
                  value: _selectedSizes!.contains(size),
                  onChanged: (bool? selected) {
                    setState(() {
                      if (selected!) {
                        _selectedSizes!.add(size);
                      } else {
                        _selectedSizes!.remove(size);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Apply filters and fetch data from Firebase Firestore
                query.get().then((QuerySnapshot snapshot) {
                  // Process the snapshot data
                  List<DocumentSnapshot> documents = snapshot.docs;
                  // Display the data in a list view or any other widget
                  print('Found ${documents.length} matching products');
                });
              },
              child: Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }
}
