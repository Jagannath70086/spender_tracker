import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_bloc.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_event.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_state.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/widgets/navbar_item.dart';
import 'package:spender_tracker/features/theme/domain/entity/theme_entity.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_state.dart';

class CustomFloatingNavBar extends StatelessWidget {
  const CustomFloatingNavBar({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeEntity?.themeType == ThemeType.dark;

        return BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            if (state is NavigationLoaded) {
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withValues(alpha: 0.3)
                          : Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: state.items.map((item) {
                      final isSelected = item.id == state.selectedItemId;
                      return NavbarItem(
                        icon: item.icon,
                        label: item.label,
                        isSelected: isSelected,
                        isDark: isDark,
                        onTap: () {
                          context.read<NavigationBloc>().add(NavigationItemSelected(item.id));
                        },
                      );
                    }).toList(),
                  ),
                ),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}