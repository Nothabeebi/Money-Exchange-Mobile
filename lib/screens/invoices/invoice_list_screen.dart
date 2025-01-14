import 'package:flutter/material.dart';
import '../../services/invoices_service.dart';
import 'invoice_detail_screen.dart';

class InvoiceListScreen extends StatefulWidget {
  final String invoiceType; // 'Sales Invoice' or 'Purchase Invoice'

  const InvoiceListScreen({super.key, required this.invoiceType});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  late Future<List<dynamic>> _invoicesFuture;
  List<dynamic> _filteredInvoices = [];
  List<dynamic> _allInvoices = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchInvoices();
  }

  Future<void> _fetchInvoices() async {
    _invoicesFuture = InvoicesService.fetchInvoices(widget.invoiceType);
    final invoices = await _invoicesFuture;
    // Exclude draft and canceled invoices
    final filtered = invoices
        .where((invoice) => invoice['status'] != 'Draft' && invoice['status'] != 'Cancelled')
        .toList();
    setState(() {
      _allInvoices = filtered;
      _filteredInvoices = filtered;
    });
  }

  void _filterInvoices(String query) {
    setState(() {
      _filteredInvoices = _allInvoices.where((invoice) {
        final name = invoice['name']?.toLowerCase() ?? '';
        final customerOrSupplier = widget.invoiceType == 'Sales Invoice'
            ? invoice['customer']?.toLowerCase() ?? ''
            : invoice['supplier']?.toLowerCase() ?? '';
        return name.contains(query.toLowerCase()) || customerOrSupplier.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.invoiceType} List'),
        backgroundColor: const Color(0xFF5B33FF),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: _filterInvoices,
                  ),
                ),
                const SizedBox(width: 10),
                // Invoice Count
                Text(
                  '${_filteredInvoices.length} Invoices',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _invoicesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error fetching ${widget.invoiceType}: ${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _fetchInvoices,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (_filteredInvoices.isEmpty) {
                  return const Center(child: Text('No invoices found.'));
                } else {
                  return ListView.builder(
                    itemCount: _filteredInvoices.length,
                    itemBuilder: (context, index) {
                      final invoice = _filteredInvoices[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(invoice['name'] ?? 'Unnamed Invoice'),
                          subtitle: Text(
                            widget.invoiceType == 'Sales Invoice'
                                ? 'Customer: ${invoice['customer'] ?? 'N/A'}'
                                : 'Supplier: ${invoice['supplier'] ?? 'N/A'}',
                          ),
                          trailing: Text('Total: ${invoice['grand_total'] ?? 'N/A'}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InvoiceDetailScreen(
                                  invoice: invoice,
                                  invoiceType: widget.invoiceType,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
