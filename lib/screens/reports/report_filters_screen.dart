import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReportFiltersScreen extends StatefulWidget {
  final String reportName;

  const ReportFiltersScreen({Key? key, required this.reportName}) : super(key: key);

  @override
  State<ReportFiltersScreen> createState() => _ReportFiltersScreenState();
}

class _ReportFiltersScreenState extends State<ReportFiltersScreen> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  String? _selectedAgent;
  List<String> _agents = [];
  Future<List<dynamic>>? _reportData;

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchAgents();
  }

  Future<void> _fetchAgents() async {
    try {
      final response = await http.get(
        Uri.parse('https://zaithoon.zoserp.com/api/resource/Customer'), // Replace with correct DocType
        headers: {
          'Authorization': 'token 7215c1ee4894886:a08c42677dd30c5',
          'Content-Type': 'application/json',
        },
      );

      print('Agents API Response: ${response.body}'); // Debug agent data

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _agents = (data['data'] as List<dynamic>)
              .map((agent) => agent['name'].toString())
              .toList();
        });
      } else {
        throw Exception('Failed to fetch agents: ${response.body}');
      }
    } catch (e) {
      print('Error fetching agents: $e');
    }
  }

  Future<List<dynamic>> _fetchReportData(Map<String, String> filters) async {
    try {
      final response = await http.post(
        Uri.parse('https://zaithoon.zoserp.com/api/method/frappe.desk.query_report.run'),
        headers: {
          'Authorization': 'token 7215c1ee4894886:a08c42677dd30c5',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'report_name': widget.reportName,
          'filters': filters,
        }),
      );

      print('Report API Response: ${response.body}'); // Debug API response

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['message']['result'];
        return data;
      } else {
        throw Exception('Failed to fetch report: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching report: $e');
    }
  }

  void _getReport() {
    final filters = {
      'from_date': _fromDateController.text.isNotEmpty
          ? _fromDateController.text
          : '2023-01-01', // Default date for testing
      'to_date': _toDateController.text.isNotEmpty
          ? _toDateController.text
          : '2023-12-31', // Default date for testing
      'agent': _selectedAgent ?? '',
    };

    print('Filters applied: $filters'); // Debug filters

    setState(() {
      _reportData = _fetchReportData(filters);
    });
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters - ${widget.reportName}'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fromDateController,
              readOnly: true,
              onTap: () => _selectDate(context, _fromDateController),
              decoration: InputDecoration(
                labelText: 'From Date',
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _toDateController,
              readOnly: true,
              onTap: () => _selectDate(context, _toDateController),
              decoration: InputDecoration(
                labelText: 'To Date',
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedAgent,
              items: _agents
                  .map((agent) => DropdownMenuItem(
                        value: agent,
                        child: Text(agent),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAgent = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Agent',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _getReport,
                child: const Text('Get Report'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _reportData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available.'));
                  } else if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: data.first.keys
                            .map((key) => DataColumn(label: Text(key.toString())))
                            .toList(),
                        rows: data
                            .map((row) => DataRow(
                                  cells: row.values
                                      .map((value) => DataCell(Text(value.toString())))
                                      .toList(),
                                ))
                            .toList(),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
