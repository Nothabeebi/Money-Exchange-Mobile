import 'dart:convert';
import 'api_service.dart';

class AgentsService {
  /// Fetch agents with specific fields and additional query parameters
  static Future<List<dynamic>> fetchAgents() async {
    // Define the fields you want to fetch
    final fields = [
      'customer_name',
      'customer_group',
      'territory',
      'customer_type',
      'docstatus',
      'email_id', // Add any additional fields as required
    ];

    // Define query parameters
    final queryParams = {
      'fields': jsonEncode(fields),
      'limit_page_length': '1000', // Adjust this to fetch more records if needed
      'limit_start': '0', // Optional: Specify start index for pagination
    };

    try {
      // Fetch data using the API service
      return await ApiService.fetchData(
        'Customer',
        queryParams: queryParams,
      );
    } catch (e) {
      throw Exception('Error fetching agents: $e');
    }
  }
}
