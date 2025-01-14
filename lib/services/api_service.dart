import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'https://zaithoon.zoserp.com';
const String apiKey = '7215c1ee4894886';
const String apiSecret = 'e2726ccb9be92d5';

class ApiService {
  static String? sessionCookie;

  /// Set session cookie
  static void setSessionCookie(String? cookie) {
    sessionCookie = cookie;
  }

  /// Fetch data with query parameters
  static Future<List<dynamic>> fetchData(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final query = queryParams != null
          ? queryParams.entries
              .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
              .join('&')
          : '';
      final url = Uri.parse('$baseUrl/api/resource/$endpoint${query.isNotEmpty ? '?$query' : ''}');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (sessionCookie != null) 'Cookie': sessionCookie!,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] ?? [];
      } else {
        throw Exception('Failed to load $endpoint: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching $endpoint: $e');
    }
  }

    /// Fetch all available reports with pagination
  static Future<List<String>> fetchAvailableReports() async {
    const int pageSize = 20; // ERPNext's default page size
    int offset = 0;
    List<String> reports = [];

    try {
      while (true) {
        final url = Uri.parse(
            '$baseUrl/api/resource/Report?limit_page_length=$pageSize&limit_start=$offset');
        final response = await http.get(
          url,
          headers: {
            'Content-Type': 'application/json',
            if (sessionCookie != null) 'Cookie': sessionCookie!,
          },
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final fetchedReports = (data['data'] as List<dynamic>)
              .map((report) => report['name'].toString())
              .toList();

          // Add fetched reports to the list
          reports.addAll(fetchedReports);

          // Stop if fewer results are returned than the page size
          if (fetchedReports.length < pageSize) {
            break;
          }

          // Increment offset for the next page
          offset += pageSize;
        } else {
          throw Exception('Failed to fetch reports: ${response.body}');
        }
      }
      return reports;
    } catch (e) {
      throw Exception('Error fetching reports: $e');
    }
  }
}
