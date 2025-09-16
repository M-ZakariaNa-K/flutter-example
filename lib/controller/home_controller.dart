
import 'package:dio/dio.dart';
import 'package:example/model/model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final Dio dio = Dio();
  var carts = <CartModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      final response = await dio.get('https://dummyjson.com/carts');
      final data = response.data;
//عملية تحويل الداتا من شكل جسون الى اوجيكتس
      if (data['carts'] != null) {
        carts.value = List<CartModel>.from(
          data['carts'].map((cart) => CartModel.fromMap(cart)),
        );
      }
    } catch (e) {
      print('Error fetching data: $e');
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading(false);
    }
  }
}
