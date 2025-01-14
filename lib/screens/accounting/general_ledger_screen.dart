import 'package:flutter/material.dart';
import '../../services/accounting_service.dart';

class GeneralLedgerScreen extends StatefulWidget {
  const GeneralLedgerScreen({super.key});

  @override
  State<GeneralLedgerScreen> createState() => _GeneralLedgerScreenState();
}

class _GeneralLedgerScreenState extends State<GeneralLedgerScreen> {
  late Future<List<dynamic>> _ledgerFuture;

  @override
  void initState() {
    super.initState();
    _ledgerFuture = AccountingService.fetchAccountingData('General Ledger');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Ledger'),
        backgroundColor: const Color(0xFF5B33FF),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _ledgerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No ledger entries found.'));
          } else {
            final ledgerEntries = snapshot.data!;
            return ListView.builder(
              itemCount: ledgerEntries.length,
              itemBuilder: (context, index) {
                final entry = ledgerEntries[index];
                return ListTile(
                  title: Text(entry['account'] ?? 'No Account'),
                  subtitle: Text('Balance: ${entry['balance'] ?? 'N/A'}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
