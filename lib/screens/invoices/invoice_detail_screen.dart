import 'package:flutter/material.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final dynamic invoice;
  final String invoiceType; // 'Sales Invoice' or 'Purchase Invoice'

  const InvoiceDetailScreen({super.key, required this.invoice, required this.invoiceType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${invoiceType} Details'),
        backgroundColor: const Color(0xFF5B33FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invoice Name: ${invoice['name'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                invoiceType == 'Sales Invoice'
                    ? 'Customer: ${invoice['customer'] ?? 'N/A'}'
                    : 'Supplier: ${invoice['supplier'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Grand Total: ${invoice['grand_total'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Posting Date: ${invoice['posting_date'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Status: ${invoice['status'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 16),
              ),
              // Add more fields if needed
            ],
          ),
        ),
      ),
    );
  }
}
