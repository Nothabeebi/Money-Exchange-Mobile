import 'package:flutter/material.dart';
import 'general_ledger_screen.dart';
import 'accounts_receivable_screen.dart';
import 'accounts_payable_screen.dart';
import 'payment_entries_screen.dart';

class AccountingDashboard extends StatelessWidget {
  const AccountingDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> modules = [
      {
        'icon': Icons.book,
        'label': 'General Ledger',
        'onTap': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const GeneralLedgerScreen()));
        },
      },
      {
        'icon': Icons.receipt_long,
        'label': 'Accounts Receivable',
        'onTap': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountsReceivableScreen()));
        },
      },
      {
        'icon': Icons.payments,
        'label': 'Accounts Payable',
        'onTap': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountsPayableScreen()));
        },
      },
      {
        'icon': Icons.credit_card,
        'label': 'Payment Entries',
        'onTap': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentEntriesScreen()));
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounting Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Add refresh functionality here
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: modules.length,
          itemBuilder: (context, index) {
            final module = modules[index];
            return ModuleShortcut(
              icon: module['icon'],
              label: module['label'],
              onTap: module['onTap'],
            );
          },
        ),
      ),
    );
  }
}

class ModuleShortcut extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ModuleShortcut({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );
        onTap();
      },
      child: Card(
        color: Colors.blue[50],
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 10),
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
