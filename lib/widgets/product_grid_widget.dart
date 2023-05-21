import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viva_store_app/providers/productProvider.dart';
import 'package:viva_store_app/widgets/product_card_widget.dart';

import '../models/product.dart';

class ProductGridWidget extends StatefulWidget {
  final String category;
  final Function(Product product) onShoppingCartUpdate;

  ProductGridWidget(
      {Key? key, required this.category, required this.onShoppingCartUpdate})
      : super(key: key);

  @override
  State<ProductGridWidget> createState() => _ProductGridWidgetState();
}

class _ProductGridWidgetState extends State<ProductGridWidget> {
  final double itemWidth = 200;

  void _addProductToShoppingCart(Product product) {
    widget.onShoppingCartUpdate(product);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width; // A largura da tela.
    var crossAxisCount = (screenWidth / itemWidth)
        .floor(); // O número de itens que cabem na tela.
    return Consumer<ProductProvider>(
        builder: (context, productProvider, _) => GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: productProvider.products
                .where((product) => product.category == widget.category)
                .length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 3 / 4.7,
              crossAxisSpacing: 6,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return ProductCard(
                product: productProvider.products
                    .where((p) => p.category == widget.category)
                    .toList()[index],
                onProductAddToShoppingCart: _addProductToShoppingCart,
              );
            }));
  }
}
