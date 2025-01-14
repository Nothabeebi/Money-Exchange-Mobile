import 'package:flutter/material.dart';
import 'accounting/accounting_dashboard.dart';
import 'agents/agent_list_screen.dart';
import 'invoices/invoice_option_screen.dart';
import 'sales_orders/sales_order_list_screen.dart';
import 'reports/reports_screen.dart';
import 'suppliers/supplier_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> modules = [
      {
        'icon': Icons.account_circle,
        'label': 'Agents',
        'color': Colors.blue,
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AgentListScreen()),
        ),
      },
      {
        'icon': Icons.inventory,
        'label': 'Invoices',
        'color': Colors.orange,
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InvoiceOptionsScreen()),
        ),
      },
      {
        'icon': Icons.shopping_cart,
        'label': 'Sales Orders',
        'color': Colors.green,
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SalesOrderListScreen()),
        ),
      },
      {
        'icon': Icons.account_balance,
        'label': 'Accounting',
        'color': Colors.red,
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountingDashboard()),
        ),
      },
      {
        'icon': Icons.bar_chart,
        'label': 'Reports',
        'color': Colors.purple,
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReportsScreen()),
        ),
      },
      {
        'icon': Icons.business,
        'label': 'Suppliers',
        'color': Colors.teal,
        'onTap': () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SupplierListScreen()),
        ),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Metrics Section
            Card(
              elevation: 4,
              margin: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Key Metrics',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Total Agents:',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '125',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Module Section
            Card(
              elevation: 4,
              margin: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: modules.length,
                  itemBuilder: (context, index) {
                    final module = modules[index];
                    return GestureDetector(
                      onTap: module['onTap'],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: module['color'],
                            radius: 40,
                            child: Icon(
                              module['icon'],
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            module['label'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
