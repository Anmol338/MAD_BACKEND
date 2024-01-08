import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubits/product_cubit/product_cubit.dart';
import '../../../logic/cubits/product_cubit/product_state.dart';
import '../../widgets/product_list_view.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
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

      return ProductListView(products: state.products);
    });
  }
}
