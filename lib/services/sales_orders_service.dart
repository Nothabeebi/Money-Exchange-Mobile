  import 'api_service.dart';

class SalesOrdersService {
  static Future<List<dynamic>> fetchSalesOrders() async {
    return ApiService.fetchData('Sales Order');
  }
}
