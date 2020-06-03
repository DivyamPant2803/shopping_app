import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_item.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);      // This method will return the instance of provider class, Products(), that we used in main.dart. This ensures that this widet will act as a listener to the provider class, and if any changes occurs then only this widget is re-built
    final products = showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx,index) => ChangeNotifierProvider.value(   // .value should be used in case of Lists or Grids
        //builder: (c) => products[index],
        value: products[index],
        child: ProductItem(),
      ),
      itemCount: products.length,
    );
  }
}