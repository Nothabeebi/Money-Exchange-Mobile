import 'package:flutter/material.dart';
import '../../../services/api_service.dart';

class PaymentEntriesScreen extends StatelessWidget {
  const PaymentEntriesScreen({super.key});

  Future<List<dynamic>> fetchPaymentEntries() async {
    return ApiService.fetchData('Payment Entry');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Entries')),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPaymentEntries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No payment entries found.'));
          } else {
            final payments = snapshot.data!;
            return ListView.builder(
              itemCount: payments.length,
              itemBuilder: (context, index) {
                final payment = payments[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Reference: ${payment['reference_name']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount: ${payment['paid_amount']}'),
                        Text('Date: ${payment['posting_date']}'),
                        Text('Mode of Payment: ${payment['mode_of_payment']}'),
                      ],
                    ),
                    trailing: Text(
                      payment['status'] ?? 'Unknown',
                      style: TextStyle(
                        color: payment['status'] == 'Completed'
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
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
