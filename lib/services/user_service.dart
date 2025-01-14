import 'dart:convert';
import 'api_service.dart';

class UserService {
  static Future<Map<String, dynamic>> fetchUserDetails() async {
    return ApiService.fetchData(
      'User',
      queryParams: {
        'filters': jsonEncode([
          ['name', '=', 'current_user'], // Replace with logic to fetch the current logged-in user
        ]),
        'fields': jsonEncode(['full_name', 'email']),
      },
    ).then((data) => data.isNotEmpty ? data[0] : {});
  }
}
