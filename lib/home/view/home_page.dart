import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_store/category/repository/category_repository.dart';
import 'package:food_store/components/background/top_left_background.dart';
import 'package:food_store/components/navigation_bar/rounded_navigation_bar.dart';
import 'package:food_store/restaurant/components/restaurant_card.dart';
import 'package:food_store/restaurant/repository/restaurant_repository.dart';
import 'package:food_store/home/bloc/home_bloc.dart';
import 'package:food_store/home/components/category_card.dart';
import 'package:food_store/l10n/l10n.dart';
import 'package:food_store/routes/route_transition.dart';
import 'package:food_store/utilities/helpers/gap.dart';
import 'package:icons_plus/icons_plus.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  static Route<dynamic> route() {
    return RouteTransition.pageRouteBuilder(
      BlocProvider(
        create: (context) => HomeBloc(
          featuredRepository: context.read<RestaurantRepository>(),
          categoryRepository: context.read<CategoryRepository>(),
        )..add(HomeLoad()),
        child: const Homepage(),
      ),
    );
  }

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: TopLeftBackground(
        // bottonNavigation: Container(
        //   margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        //   height: 80.h,
        //   alignment: Alignment.center,
        //   // padding: EdgeInsets.symmetric(horizontal: 20.w),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(35.r),
        //     // color: Colors.black,
        //     border: Border.all(
        //       color: Colors.white24,
        //     ),
        //     gradient: const LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [
        //         Color(0xFF1d102d),
        //         Colors.transparent,
        //       ],
        //     ),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black.withOpacity(0.1),
        //         blurRadius: 10,
        //         spreadRadius: 5,
        //       ),
        //     ],
        //   ),
        //   child: Theme(
        //     data: ThemeData(
        //         // splashColor: Colors.transparent,
        //         // highlightColor: Colors.transparent,
        //         ),
        //     child: NavigationBar(
        //       // backgroundColor: Colors.transparent,
        //       // items: [
        //       //   BottomNavigationBarItem(
        //       //     icon: Icon(EvaIcons.home_outline),
        //       //     label: 'Home',
        //       //   ),
        //       //   BottomNavigationBarItem(
        //       //     icon: Icon(EvaIcons.search_outline),
        //       //     label: 'Browse',
        //       //   ),
        //       // ],
        //       destinations: const <NavigationDestination>[
        //         NavigationDestination(
        //           icon: Icon(EvaIcons.home_outline),
        //           label: 'Home',
        //         ),
        //         NavigationDestination(
        //           icon: Icon(EvaIcons.search_outline),
        //           label: 'Browse',
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        bottonNavigation: RoundedNavigationBar(
          destinations: const [
            NavigationDestination(
              icon: Icon(EvaIcons.home_outline),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(EvaIcons.search_outline),
              label: 'Browse',
            ),
            NavigationDestination(
              icon: Icon(EvaIcons.shopping_cart_outline),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(HeroIcons.document_text),
              label: 'Browse',
            ),
            NavigationDestination(
              icon: Icon(EvaIcons.person),
              label: 'Account',
            ),
          ],
          onTap: (index) {
            setState(() {});
          },
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              // return Container();
              return CustomScrollView(
                slivers: [
                  _sliverAppBar(),
                  _categoriesSection(l10n, state),
                  _featuredImageSection(state),
                  _fastestNearYouRestaurantHeading(l10n),
                  _fastestNearYouRestaurantList(state)
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  SliverList _fastestNearYouRestaurantList(HomeState state) {
    return SliverList.separated(
      itemCount: state.nearYouRestaurant.length,
      itemBuilder: (context, index) {
        final restaurant = state.nearYouRestaurant[index];
        return RestaurantCard(restaurant: restaurant);
      },
      separatorBuilder: (context, index) {
        return vGap(15);
      },
    );
  }

  SliverPadding _fastestNearYouRestaurantHeading(AppLocalizations l10n) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      sliver: SliverToBoxAdapter(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            l10n.fastestNearYou,
            style: TextStyle(fontSize: 21.sp),
          ),
        ),
      ),
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(EvaIcons.menu),
      ),
      title: Text(
        'Location',
        style: TextStyle(
          fontSize: 21.sp,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(EvaIcons.shopping_cart),
          onPressed: () {},
        ),
      ],
      // collapsedHeight: 50.h,
      expandedHeight: 120.h,
      // toolbarHeight: 80.h,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFF291eae),
                          Colors.transparent,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'What food are you looking for?',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    prefixIcon: const Icon(EvaIcons.search),
                    filled: true,
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(
                        color: Colors.white24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverPadding _featuredImageSection(HomeState state) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 200.h,
          // width: 1.sw,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              autoPlay: true,
              pageSnapping: true,
              aspectRatio: 0.75,
              viewportFraction: 0.95,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 15),
            ),
            items: state.featuredRestaurant.map((featuredRestaurant) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(0),
                    child: Image.asset(
                      featuredRestaurant.featuredImage!,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  SliverPadding _categoriesSection(AppLocalizations l10n, HomeState state) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      sliver: SliverToBoxAdapter(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.categories,
                style: TextStyle(fontSize: 21.sp),
              ),
            ),
            vGap(10),
            SizedBox(
              height: 100.h,
              child: ListView.builder(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return CategoryCard(
                    image: Image.asset(category.image),
                    categoryName: category.name,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
