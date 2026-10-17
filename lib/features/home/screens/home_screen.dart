import 'package:ecommerce_app_huma_volve/features/home/cubit/home_cubit.dart';
import 'package:ecommerce_app_huma_volve/features/home/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/dummy_data.dart';
import '../../../core/theme.dart';
import '../widgets/product_card.dart';
import '../widgets/category_chip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ─── Header ──────────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.menu,
                            color: AppTheme.primary,
                          ),
                        ),
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            dummyUser.profilePictureUrl,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Explore',
                      style: Theme.of(
                        context,
                      ).textTheme.displayLarge?.copyWith(fontSize: 36),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Best trendy collection!',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 32),

                    // ─── Search Bar ─────────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search clothes...',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ─── Categories ─────────────────────────────────────────
                    // ✅ buildWhen: يتحدث فقط لما الـ state يتعلق بالـ categories
                    BlocBuilder<HomeCubit, HomeStates>(
                      buildWhen: (previous, current) =>
                          current is CategoriesLoading ||
                          current is CategoriesSuccess ||
                          current is CategoriesError,
                      builder: (context, state) {
                        if (state is CategoriesLoading) {
                          return const SizedBox(
                            height: 40,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        } else if (state is CategoriesError) {
                          return Center(
                            child: Text(
                              state.errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (state is CategoriesSuccess) {
                          return SizedBox(
                            height: 40,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.categories.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final category = state.categories[index];
                                return CategoryChip(
                                  label: category.name ?? '',
                                  isSelected: _selectedCategoryIndex == index,
                                  onTap: () {
                                    setState(() {
                                      _selectedCategoryIndex = index;
                                    });
                                    context.read<HomeCubit>().loadProducts(
                                      category.id,
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),

            // ─── Products Grid ────────────────────────────────────────────
            // ✅ buildWhen: يتحدث فقط لما الـ state يتعلق بالـ products
            BlocBuilder<HomeCubit, HomeStates>(
              buildWhen: (previous, current) =>
                  current is ProductLoading ||
                  current is ProductSuccess ||
                  current is ProductError,
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (state is ProductError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state.errorMessage,
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is ProductSuccess) {
                  if (state.products.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(child: Text('No products found.')),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final p = state.products[index];
                          // تحويل ProductModel → Product عشان ProductCard
                          final imageUrl = (p.images != null &&
                                  p.images!.isNotEmpty)
                              ? p.images!.first
                              : 'https://picsum.photos/seed/${p.id}/300/300';
                          return ProductCard(
                            product: Product(
                              id: p.id?.toString() ?? '$index',
                              name: p.title ?? 'No Name',
                              description: p.description ?? '',
                              price: (p.price ?? 0).toDouble(),
                              imageUrl: imageUrl,
                              colors: const [Color(0xFF1A1A2E)],
                              sizes: const ['S', 'M', 'L', 'XL'],
                            ),
                          );
                        },
                        childCount: state.products.length,
                      ),
                    ),
                  );
                }
                // Initial state — عرض dummy products ريثما يحمّل
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          ProductCard(product: dummyProducts[index]),
                      childCount: dummyProducts.length,
                    ),
                  ),
                );
              },
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}
