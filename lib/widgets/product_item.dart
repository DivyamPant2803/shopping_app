import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/auth.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  //final String id;
  //final String title;
  //final String imageUrl;

  //ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false); // will run only once
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
         child: GestureDetector(
           onTap: (){
             Navigator.of(context).pushNamed(
               ProductDetailScreen.routeName,
               arguments: product.id,
             );
           },
           child: Hero(
             tag: product.id,   // should be unique for each image
             child: FadeInImage(
               placeholder: AssetImage('assets/images/placeholder_image.png'),
               image: NetworkImage(product.imageUrl),
               fit: BoxFit.cover,
             ),
           )
         ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(          // Similar to Provider.of, but it can be used if we want only a particular part of widget to be re-built and not run the whole build function
            builder: (ctx, product, child) => IconButton(   // Here child is used if we don't want a part inside Consumer doesn't change, so we place that item inside the child of Consumer
              icon: Icon(product.isFavourite ? Icons.favorite : Icons.favorite_border),
              onPressed: (){
                product.favouriteToggle(authData.token, authData.userId);
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: (){
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context)                                              // It will establish a connection with the nearest Scaffold item. (In this case, product overview screen)
                  .showSnackBar(SnackBar(content: Text('Added to the cart!',),
                duration: Duration(seconds: 2),
                action: SnackBarAction(label: 'Undo', onPressed: (){ cart.removeSingleItem(product.id);},),
              ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(product.title,
            textAlign: TextAlign.center,),
      ),
      ),
    );
  }
}
