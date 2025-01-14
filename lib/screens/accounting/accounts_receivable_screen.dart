import 'package:flutter/material.dart';
import '../../../services/api_service.dart';

class AccountsReceivableScreen extends StatelessWidget {
  const AccountsReceivableScreen({super.key});

  Future<List<dynamic>> fetchReceivables() async {
    return ApiService.fetchData('Accounts Receivable');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accounts Receivable')),
      body: FutureBuilder<List<dynamic>>(
        future: fetchReceivables(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No receivables found.'));
          } else {
            final receivables = snapshot.data!;
            return ListView.builder(
              itemCount: receivables.length,
              itemBuilder: (context, index) {
                final receivable = receivables[index];
                return ListTile(
                  title: Text('Customer: ${receivable['customer']}'),
                  subtitle: Text('Outstanding: ${receivable['outstanding_amount']}'),
                  trailing: Text(receivable['due_date']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
