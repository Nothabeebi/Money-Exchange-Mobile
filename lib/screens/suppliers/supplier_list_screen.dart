import 'package:flutter/material.dart';
import '../../services/supplier_service.dart';
import 'supplier_detail_screen.dart';

class SupplierListScreen extends StatefulWidget {
  const SupplierListScreen({super.key});

  @override
  State<SupplierListScreen> createState() => _SupplierListScreenState();
}

class _SupplierListScreenState extends State<SupplierListScreen> {
  late Future<List<dynamic>> _suppliersFuture;
  List<dynamic> _suppliers = [];
  List<dynamic> _filteredSuppliers = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _suppliersFuture = _fetchSuppliers();
    _searchController.addListener(_filterSuppliers);
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose of the controller
    super.dispose();
  }

  Future<List<dynamic>> _fetchSuppliers() async {
    try {
      final suppliers = await SuppliersService.fetchSuppliers();
      setState(() {
        _suppliers = suppliers;
        _filteredSuppliers = suppliers;
      });
      return suppliers;
    } catch (e) {
      rethrow; // Allow error to be displayed in FutureBuilder
    }
  }

  void _filterSuppliers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSuppliers = _suppliers.where((supplier) {
        final name = supplier['supplier_name']?.toLowerCase() ?? '';
        return name.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier List'),
        backgroundColor: const Color(0xFF4CAF50), // Match Dashboard theme
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _suppliersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No suppliers found.'));
          } else {
            return Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search Suppliers',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0), // Match Dashboard style
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),

                // Total Count
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Suppliers: ${_filteredSuppliers.length}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Supplier List
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredSuppliers.length,
                    itemBuilder: (context, index) {
                      final supplier = _filteredSuppliers[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Match Dashboard style
                        ),
                        elevation: 4,
                        child: ListTile(
                          title: Text(supplier['supplier_name'] ?? 'Unnamed Supplier'),
                          subtitle: Text(supplier['supplier_group'] ?? 'No Group'),
                          trailing: Text(supplier['country'] ?? 'No Country'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SupplierDetailScreen(supplier: supplier),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
