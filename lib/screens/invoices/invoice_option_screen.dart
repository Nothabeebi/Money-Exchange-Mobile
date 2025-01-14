import 'package:flutter/material.dart';
import 'invoice_list_screen.dart';

class InvoiceOptionsScreen extends StatelessWidget {
  const InvoiceOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Options'),
        backgroundColor: const Color(0xFF5B33FF), // Primary app color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildOptionCard(
              icon: Icons.receipt_long,
              label: 'Sales Invoice',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const InvoiceListScreen(invoiceType: 'Sales Invoice'),
                  ),
                );
              },
            ),
            _buildOptionCard(
              icon: Icons.shopping_basket,
              label: 'Purchase Invoice',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const InvoiceListScreen(invoiceType: 'Purchase Invoice'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF5B33FF).withOpacity(0.1), // Light purple background
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFF5B33FF)), // Icon color matches the theme
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5B33FF), // Text color matches the theme
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
