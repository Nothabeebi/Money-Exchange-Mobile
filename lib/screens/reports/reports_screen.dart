import 'package:flutter/material.dart';
import 'report_filters_screen.dart';

class ReportsScreen extends StatelessWidget {
  final List<String> reports = [
    'Agent Receivable Report',
    'Supplier Total Payable Report',
    'Agent Total Outstanding Report',
    'Easy Sales Invoice Report',
  ];

  void _navigateToReportFilters(BuildContext context, String reportName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportFiltersScreen(reportName: reportName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: ListView.builder(
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final reportName = reports[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(reportName),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => _navigateToReportFilters(context, reportName),
            ),
          );
        },
      ),
    );
  }
}
