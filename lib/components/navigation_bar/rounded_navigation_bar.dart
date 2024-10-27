import 'package:flutter/material.dart';
import 'package:food_store/utilities/helpers/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedNavigationBar extends StatelessWidget {
  const RoundedNavigationBar({
    super.key,
    this.margin,
    this.padding,
    required this.onTap,
    required this.destinations,
  });

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Function(int index) onTap;
  final List<NavigationDestination> destinations;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        margin: margin ??
            EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 15.w,
            ),
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
        height: 80.h,
        // alignment: Alignment.center,
        // padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35.r),
          // color: Colors.black,
          border: Border.all(
            color: Colors.white24,
          ),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1d102d),
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
        child: NavigationBar(
          onTap: onTap,
          destinations: destinations,
        ),
      ),
    );
  }
}

class NavigationBar extends StatefulWidget {
  const NavigationBar({
    super.key,
    this.backgroundColor = Colors.transparent,
    required this.onTap,
    this.selectedColor = Colors.white10,
    required this.destinations,
  });

  final Color backgroundColor;
  final Function(int index) onTap;
  final Color selectedColor;
  final List<NavigationDestination> destinations;

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      clipBehavior: Clip.none,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.destinations.asMap().entries.map((entry) {
          final destination = entry.value;
          final index = entry.key;
          var isCurrentSelected = _selectedIndex == index;
          return GestureDetector(
            // splashColor: Colors.transparent,
            // highlightColor: Colors.transparent,
            // hoverColor: Colors.transparent,
            // focusColor: Colors.transparent,
            // overlayColor: WidgetStatePropertyAll(Colors.transparent),
            onTap: () {
              _selectedIndex = widget.destinations.indexOf(destination);
              widget.onTap(_selectedIndex);
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                if (isCurrentSelected)
                  Positioned(
                    top: 10,
                    child: Container(
                      clipBehavior: Clip.none,
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        // color: Colors.white.withOpacity(0.1),
                        gradient: RadialGradient(
                          radius: 0.8.r,
                          colors: [
                            Color(0xFF224069),
                            Colors.transparent,
                          ],
                        ),
                        // borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 5.h,
                      ),
                      // decoration: BoxDecoration(
                      //   color: isCurrentSelected
                      //       ? widget.selectedColor
                      //       : Colors.transparent,
                      //   borderRadius: BorderRadius.circular(25.r),
                      // ),
                      child: isCurrentSelected
                          ? destination.selectedIcon ?? destination.icon
                          : destination.icon,
                    ),
                    vGap(2),
                    Text(
                      destination.label,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
