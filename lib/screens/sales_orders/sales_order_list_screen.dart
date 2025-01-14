import 'package:flutter/material.dart';
import '../../services/sales_orders_service.dart';

class SalesOrderListScreen extends StatefulWidget {
  const SalesOrderListScreen({super.key});

  @override
  State<SalesOrderListScreen> createState() => _SalesOrderListScreenState();
}

class _SalesOrderListScreenState extends State<SalesOrderListScreen> {
  late Future<List<dynamic>> _salesOrdersFuture;

  @override
  void initState() {
    super.initState();
    _salesOrdersFuture = SalesOrdersService.fetchSalesOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Orders'),
        backgroundColor: const Color(0xFF5B33FF),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _salesOrdersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No sales orders found.'));
          } else {
            final salesOrders = snapshot.data!;
            return ListView.builder(
              itemCount: salesOrders.length,
              itemBuilder: (context, index) {
                final order = salesOrders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(order['name']),
                    subtitle: Text('Customer: ${order['customer'] ?? 'N/A'}'),
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
