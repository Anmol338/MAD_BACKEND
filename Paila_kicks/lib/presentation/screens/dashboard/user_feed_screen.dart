import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paila_kicks/core/ui.dart';
import 'package:paila_kicks/logic/cubits/category_cubit/category_cubit.dart';
import 'package:paila_kicks/logic/cubits/category_cubit/category_state.dart';
import 'package:paila_kicks/logic/cubits/product_cubit/product_cubit.dart';
import 'package:paila_kicks/logic/cubits/product_cubit/product_state.dart';
import 'package:paila_kicks/presentation/widgets/gap_widget.dart';

import '../product/category_product_screen.dart';
import 'items_screen.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  List imageList = [
    {"id": 1, "image_path": 'assets/img/Shoes1.png'},
    {"id": 2, "image_path": 'assets/img/Shoes2.png'},
    {"id": 3, "image_path": 'assets/img/Shoes3.png'},
    {"id": 4, "image_path": 'assets/img/Shoes4.png'},
    {"id": 5, "image_path": 'assets/img/Shoes5.png'},
  ];

  final CarouselController carouselController = CarouselController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      if (state is ProductLoadingState && state.products.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is ProductErrorState && state.products.isEmpty) {
        return Center(
          child: Text(state.message.toString()),
        );
      }

      return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: [
                  CarouselSlider(
                    items: imageList
                        .map(
                          (item) => Image.asset(
                            item['image_path'],
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        )
                        .toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        }),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                height: size.height / 2.1,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shop By Category",
                        style: TextStyles.heading3.copyWith(fontSize: 16),
                      ),
                      const GapWidget(),
                      Container(
                        height: size.height / 8,
                        width: size.width / 1,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Column(
                          children: [
                          ],
                        ),
                      ),
                      const GapWidget(size: 10),
                      Text(
                        "Recommended For You",
                        style: TextStyles.heading3.copyWith(fontSize: 16),
                      ),
                      const GapWidget(),
                      Container(
                        height: size.height / 5,
                        width: size.width / 1,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Column(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
      // return ProductListView(products: state.products);
    });
  }
}
