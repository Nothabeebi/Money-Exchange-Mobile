import 'dart:convert';
import 'api_service.dart';

class InvoicesService {
  /// Fetch invoices for sales or purchase
  static Future<List<dynamic>> fetchInvoices(String invoiceType) async {
    try {
      final fields = invoiceType == 'Sales Invoice'
          ? [
              'name',
              'customer',
              'posting_date',
              'status',
              'grand_total',
            ]
          : [
              'name',
              'supplier',
              'posting_date',
              'status',
              'grand_total',
            ];

      final response = await ApiService.fetchData(
        invoiceType,
        queryParams: {
          'fields': jsonEncode(fields),
          'limit_page_length': 1000,
        },
      );

      print('Fetched $invoiceType Data: $response');
      return response;
    } catch (e) {
      print('Error fetching $invoiceType: $e');
      throw Exception('Failed to fetch $invoiceType: $e');
    }
  }
}
