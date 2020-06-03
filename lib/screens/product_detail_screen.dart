import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  //final String title;
  static const routeName = '/product-detail';

  //ProductDetailScreen(this.title);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String; // is the id
    final loadedProduct = Provider.of<Products>(
        context,
      listen: false,    // This ensures that this widget will not rebuild even if notify listener is called
    ).findId(productId);
    return Scaffold(
        //appBar: AppBar(
          //title: Text(loadedProduct.title),
        //),
      body: CustomScrollView(
        slivers: <Widget>[    // scrollable lists
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title),
              background: Hero(
                tag: loadedProduct.id,    // should be same as previous, i.e in productItem widget
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(width: 10),
              Text('\u20B9${loadedProduct.price}', style: TextStyle(color: Colors.grey, fontSize: 20), textAlign: TextAlign.center,),
              SizedBox(width: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  '${loadedProduct.description}',
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(height: 800,)
            ]
            ),
          ),
        ],
      ),
    );
  }
}
