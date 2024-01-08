import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paila_kicks/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:paila_kicks/logic/cubits/cart_cubit/cart_state.dart';
import 'package:paila_kicks/logic/cubits/user_cubit/user_cubit.dart';
import 'package:paila_kicks/logic/cubits/user_cubit/user_state.dart';
import 'package:paila_kicks/presentation/screens/cart/cart_screen.dart';
import 'package:paila_kicks/presentation/screens/dashboard/category_screen.dart';
import 'package:paila_kicks/presentation/screens/dashboard/items_screen.dart';
import 'package:paila_kicks/presentation/screens/dashboard/profile_screen.dart';
import 'package:paila_kicks/presentation/screens/dashboard/user_feed_screen.dart';
import 'package:paila_kicks/presentation/screens/splash/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "dashboard";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;
  List<Widget> screens = const [
    UserFeedScreen(),
    ItemsScreen(),
    CategoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state){
        if(state is UserLoggedOutState){
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Paila Kicks"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              icon: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return Badge(
                    label: Text("${state.items.length}"),
                      isLabelVisible: (state is CartLoadingState) ? false : true,
                      child: const Icon(CupertinoIcons.cart_fill));
                }
              ),
            ),
          ],
        ),
        body: Container(
            child: screens[currentIndex]
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.menu,
              color: Colors.white,
            ),
            Icon(
              Icons.category,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
