import 'package:flutter/material.dart';
import '../../../services/api_service.dart';

class AccountsPayableScreen extends StatelessWidget {
  const AccountsPayableScreen({super.key});

  Future<List<dynamic>> fetchPayables() async {
    return ApiService.fetchData('Accounts Payable');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accounts Payable')),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPayables(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No payables found.'));
          } else {
            final payables = snapshot.data!;
            return ListView.builder(
              itemCount: payables.length,
              itemBuilder: (context, index) {
                final payable = payables[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Supplier: ${payable['supplier']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Outstanding: ${payable['outstanding_amount']}'),
                        Text('Due Date: ${payable['due_date']}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
