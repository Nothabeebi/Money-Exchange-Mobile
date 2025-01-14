import 'api_service.dart';

class AccountingService {
  static Future<List<dynamic>> fetchAccountingData(String endpoint) async {
    return ApiService.fetchData(endpoint);
  }
}
