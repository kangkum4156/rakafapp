import 'package:flutter/material.dart';
import 'package:rokafirst/body/product/productdetail.dart';
import 'package:rokafirst/data/product_data.dart';

class ProductBody extends StatelessWidget {
  const ProductBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 가로 2칸
          crossAxisSpacing: 5.0, // 가로 간격
          mainAxisSpacing: 5.0, // 세로 간격
          childAspectRatio: 0.75, // 아이템 비율 조정
        ),
        itemCount: productList.length, // 상품 개수 동적 설정
        itemBuilder: (context, index) {
          return ProductCard(
            index: index,
            productName: productList[index]["name"] ?? "상품 ${index + 1}",
            productPrice: productList[index]["price"] ?? "0",
            imagePath: productList[index]["image"] ?? "assets/wine/default.png",
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
