import 'package:erpnext_flutter_app/services/agent_service.dart';
import 'package:flutter/material.dart';
import 'agent_detail_screen.dart';

class AgentListScreen extends StatefulWidget {
  const AgentListScreen({super.key});

  @override
  State<AgentListScreen> createState() => _AgentListScreenState();
}

class _AgentListScreenState extends State<AgentListScreen> {
  late Future<List<dynamic>> _agentsFuture;
  List<dynamic> _filteredAgents = [];
  String _searchQuery = '';
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _agentsFuture = AgentsService.fetchAgents();
  }

  void _filterAgents(String query, List<dynamic> agents) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredAgents = agents;
      } else {
        _filteredAgents = agents
            .where((agent) =>
                agent['customer_name']
                    ?.toLowerCase()
                    .contains(query.toLowerCase()) ??
                false)
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent List'),
        backgroundColor: const Color(0xFF5B33FF),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _agentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No agents found.'));
          } else {
            final agents = snapshot.data!;
            _totalCount = agents.length;
            if (_searchQuery.isEmpty) {
              _filteredAgents = agents;
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search Agents',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (query) => _filterAgents(query, agents),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Total Count: $_totalCount',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredAgents.length,
                    itemBuilder: (context, index) {
                      final agent = _filteredAgents[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(agent['customer_name'] ?? 'Unnamed Agent'),
                          subtitle: Text(agent['customer_group'] ?? 'No Group'),
                          trailing: Text(agent['customer_type'] ?? 'No Type'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AgentDetailScreen(agent: agent),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
