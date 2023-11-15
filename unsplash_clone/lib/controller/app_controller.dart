import 'package:get/get.dart';
import 'package:unsplash_clone/model/photo_model.dart';
import 'package:unsplash_clone/service/dio_service.dart';

class AppController extends GetxController {
  var selectedIndex = 0.obs; //observer-index
  RxList<PhotoModel> unsplashPhotos = RxList();
  RxString orderByValue = "latest".obs;
  RxBool isLoading = true.obs;

  void fetchUnsplashPhotos() async {
    isLoading.value = true;
    List<dynamic> response =
        await DioService.unsplashNetworkCall(orderByValue.value);
    List<PhotoModel> photoList = List<PhotoModel>.from(response.map(
      (dynamic e) => PhotoModel.fromJson(e),
    ));

    unsplashPhotos.value = photoList;

    isLoading.value = false;
  }

  void filterOrderBy(String currentIndexValue, int index) {
    this.orderByValue.value = currentIndexValue;
    selectedIndex.value = index;
    print('current order value ${orderByValue.value}');
    fetchUnsplashPhotos();
  }

  @override
  void onInit() {
    //this method is invoked when the widget is allocated into memory.
    fetchUnsplashPhotos();
    super.onInit();
  }
}
