import 'dart:io';
import 'product.dart';

class ShoppingMall {
  int totalPrice = 0;
  List<Product> products = [];
  Map<Product, int> cart = {};

  // 쇼핑몰의 목록을 초기화하기 위한 메서드
  void init() {
    List<Map<String, Object>> lists = [
      {'name': 'shirt', 'price': 10000},
      {'name': 'suit', 'price': 80000},
      {'name': 'jeans', 'price': 30000},
      {'name': 'shoes', 'price': 40000},
      {'name': 'tie', 'price': 10000},
    ];

    for (var list in lists) {
      products.add(
        Product(name: list['name'] as String, price: list['price'] as int),
      );
    }

    start();
  }

  // 프로그램 진행 중, 항상 어떤 기능이 있는지 보여줄 메서드
  void showNotice() {
    print(
      '''-----------------------------------------------------------------------------------------------------------------------------
[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료 / [6] 장바구니 초기화
-----------------------------------------------------------------------------------------------------------------------------''',
    );
  }

  // 상품의 목록을 보여주는 메서드
  void showProducts() {
    for (var product in products) {
      // Map으로 만든 것은 []로 접근하고, 클래스로 만들어진 객체는 .으로 접근해야된다
      print('${product.name} / ${product.price}');
    }
  }

  // 상품을 장바구니에 추가하는 메서드
  void addToCart() {
    try {
      print('상품 이름을 영어로 입력해 주세요!');

      String productInput = stdin.readLineSync()!;
      Product filteredProduct = products.firstWhere(
        (product) => product.name == productInput,
      );

      print('상품 개수를 입력해 주세요!');
      int? amount = int.parse(stdin.readLineSync()!);

      if (amount <= 0) {
        print('0개보다 많은 개수의 상품만 담을 수 있어요!');
        return;
      } else {
        cart.containsKey(filteredProduct)
            ? cart[filteredProduct] = cart[filteredProduct]! + amount
            : cart[filteredProduct] = amount;

        print('${filteredProduct.name}을/를 $amount개 담았습니다.');
      }
    } catch (e) {
      // 상품 이름과 개수에 대한 입력 값이 에러일 경우 동작
      print('입력 값이 올바르지 않아요!');
    }
  }

  // 장바구니를 초기화하는 메서드
  void removeCart() {
    if (cart.isEmpty) {
      print('이미 장바구니가 비어있습니다.');
    } else {
      print('장바구니를 초기화합니다.');
      cart.clear();
      totalPrice = 0;
    }
  }

  // 장바구니에 담긴 상품의 총 가격을 보여주는 메서드
  void showTotal() {
    if (cart.isEmpty) {
      print('장바구니에 담긴 상품이 없습니다.');
    } else {
      cart.forEach((product, value) {
        totalPrice += product.price * value;
        print('${product.name}상품 $value개');
      });

      print('------------------------');
      print('총 $totalPrice원 입니다!');

      totalPrice = 0;
    }
  }

  // 프로그램을 시작, 진행하는 메서드
  // 이 메서드 내에서 다른 메서드들이 사용된다
  void start() {
    while (true) {
      try {
        showNotice();
        int? userInput = int.parse(stdin.readLineSync()!);

        // userInput이 숫자형 타입 변환이 제대로 됐거나
        // 그렇지 못해서 문자일 경우
        switch (userInput) {
          case 1:
            print('내배캠 쇼핑몰의 상품 목록입니다.');
            showProducts();
            break;
          case 2:
            addToCart();
            break;
          case 3:
            showTotal();
            break;
          case 4:
            print('정말 종료하시겠습니까? 그럼 5를 입력해 주세요.');
            int? endTrigger = int.parse(stdin.readLineSync()!);

            if (endTrigger == 5) {
              print('이용해 주셔서 감사합니다~ 안녕히 가세요!');
              return;
            } else {
              print('알맞는 숫자를 입력해주세요');
              break;
            }
          case 6:
            // 장바구니 초기화
            removeCart();
            break;
          default:
            print('알맞는 숫자를 입력해주세요.');
        }
      } catch (e) {
        // 타입 변환이 아예 되지 않는 에러가 발생하는 경우
        print('알맞는 숫자를 입력해주세요.');
      }
    }
  }
}
