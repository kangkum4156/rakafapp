import 'package:flutter/material.dart';
import 'package:rokafirst/data/product_data.dart'; // productByRegion 가져오기
import 'package:rokafirst/body/product/productdetail.dart'; // 상품 상세 화면

class ProductBody extends StatelessWidget {
  const ProductBody({super.key});

  @override
  Widget build(BuildContext context) {
    // 선택된 지역에 맞는 상품 목록을 불러오기
    List<Map<String, String>>? products = productByRegion[selectedRegion];

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: products == null || products.isEmpty
          ? const Center(
        child: Text('선택된 지역에 해당하는 상품이 없습니다.'),
      )
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 가로 2칸
          crossAxisSpacing: 5.0, // 가로 간격
          mainAxisSpacing: 5.0, // 세로 간격
          childAspectRatio: 0.75, // 아이템 비율 조정
        ),
        itemCount: products.length, // 상품 개수
        itemBuilder: (context, index) {
          var product = products[index];
          return ProductCard(
            index: index,
            productName: product["name"] ?? "상품 ${index + 1}",
            productPrice: product["price"] ?? "0",
            imagePath: product["image"] ?? "assets/wine/default.png",
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final int index;
  final String productName;
  final String productPrice;
  final String imagePath;

  const ProductCard({
    super.key,
    required this.index,
    required this.productName,
    required this.productPrice,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( ///터치 가능 카드
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute( ///페이지 이동
            builder: (context) => ProductDetailScreen(productName: productName),
          ),
        );
      },
      borderRadius: BorderRadius.circular(5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  fit: BoxFit.contain, /// 이미지 안짤리게
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    productName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$productPrice원',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
