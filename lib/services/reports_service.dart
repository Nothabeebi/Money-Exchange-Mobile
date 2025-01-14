import 'api_service.dart';

class ReportsService {
  static Future<List<dynamic>> fetchReport(String reportName) async {
    return ApiService.fetchData(reportName);
  }
}
