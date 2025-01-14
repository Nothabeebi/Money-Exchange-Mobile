import 'dart:convert';
import 'api_service.dart';

class SuppliersService {
  /// Fetch supplier list with specific fields
  static Future<List<dynamic>> fetchSuppliers() async {
    try {
      final response = await ApiService.fetchData(
        'Supplier',
        queryParams: {
          'fields': jsonEncode([
            'name', // Fetch the supplier's name
            'supplier_name', // Supplier name
            'supplier_group', // Group the supplier belongs to
            'supplier_type', // Type of supplier
            'country', // Country of the supplier
          ]),
          'limit_page_length': '1000', // Fetch up to 1000 suppliers
          'filters': jsonEncode([
            ['docstatus', '=', 0], // Exclude cancelled or draft suppliers
          ]),
        },
      );
      print('Fetched Suppliers: $response');
      return response;
    } catch (e) {
      print('Error fetching suppliers: $e');
      throw Exception('Error fetching Supplier: $e');
    }
  }

  /// Fetch a single supplier detail by name
  static Future<dynamic> fetchSupplierDetails(String supplierName) async {
    try {
      final response = await ApiService.fetchData(
        'Supplier',
        queryParams: {
          'filters': jsonEncode([
            ['name', '=', supplierName],
          ]),
        },
      );
      print('Fetched Supplier Details: $response');
      return response.isNotEmpty ? response[0] : null;
    } catch (e) {
      print('Error fetching supplier details: $e');
      throw Exception('Error fetching Supplier Details: $e');
    }
  }
}
