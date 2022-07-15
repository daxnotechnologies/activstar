import 'package:flutter/material.dart';

class NavigationItem {

  String image;
  String enabledImage;
  String name;

  NavigationItem(this.image, this.name, this.enabledImage);

}

List<NavigationItem> getNavigationItemList(){
  return <NavigationItem>[
    NavigationItem('assets/images/product_disabled.png', 'Produkty', 'assets/images/product_enabled.png' ),
    NavigationItem('assets/images/home_disabled.png', 'Domov', 'assets/images/home_enabled.png' ),
    NavigationItem('assets/images/articles_disabled.png', 'Články', 'assets/images/articles_enabled.png' ),
  ];
}

