import 'package:flutter/material.dart';

class AgentDetailScreen extends StatelessWidget {
  final dynamic agent;

  const AgentDetailScreen({super.key, required this.agent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(agent['customer_name'] ?? 'Agent Details'),
        backgroundColor: const Color(0xFF5B33FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${agent['customer_name'] ?? 'N/A'}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('Customer Group: ${agent['customer_group'] ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Customer Type: ${agent['customer_type'] ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text('Territory: ${agent['territory'] ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
