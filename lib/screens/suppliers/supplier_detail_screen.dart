import 'package:flutter/material.dart';

class SupplierDetailScreen extends StatelessWidget {
  final dynamic supplier;

  const SupplierDetailScreen({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(supplier['supplier_name'] ?? 'Supplier Details'),
        backgroundColor: const Color(0xFF5B33FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Supplier Name
              Text(
                'Name: ${supplier['supplier_name'] ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Supplier Type
              Row(
                children: [
                  const Icon(Icons.category, color: Color(0xFF5B33FF)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      supplier['supplier_type'] ?? 'N/A',
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Email
              Row(
                children: [
                  const Icon(Icons.email, color: Color(0xFF5B33FF)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      supplier['supplier_group'] ?? 'N/A',
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Phone
              Row(
                children: [
                  const Icon(Icons.phone, color: Color(0xFF5B33FF)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      supplier['phone'] ?? 'N/A',
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Address
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, color: Color(0xFF5B33FF)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      supplier['address'] ?? 'N/A',
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Additional Details Section
              const Text(
                'Additional Details:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Status: ${supplier['status'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
