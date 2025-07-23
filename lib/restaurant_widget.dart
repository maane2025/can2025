import 'package:flutter/material.dart';
import 'base_page.dart';

class RestaurantWidget extends StatelessWidget {
  const RestaurantWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Restaurants CAN 2025',
      child: const Center(
        child: Text('La fonctionnalité restaurants est temporairement désactivée.'),
      ),
    );
  }
} 