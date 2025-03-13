// ignore: avoid_relative_lib_imports
import '../lib/shopping_mall.dart';

void main(List<String> arguments) {
  //  window 인코딩 이슈로 인해 상품 목록을 영어로 작성했습니다.
  var shop = ShoppingMall();
  shop.init();
}
