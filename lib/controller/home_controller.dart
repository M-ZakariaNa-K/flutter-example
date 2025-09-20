
import 'package:dio/dio.dart';
import 'package:example/helper/network_util.dart';
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

  Future<void> fetchData1() async {
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
//----------------- using our network util -----------------

 Future<void> fetchData() async {
    try {
      isLoading(true);

      // استخدم الـ $ بدل Dio مباشر
      final data = await $.get('/carts');

      if (data != null && data['carts'] != null) {
        carts.value = List<CartModel>.from(
          data['carts'].map((cart) => CartModel.fromMap(cart)),
        );
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Alert.toast أو Get.snackbar حسب تفضيلك
      // Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading(false);
    }
  }

}
