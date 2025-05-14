import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_bloc.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/bloc/navigation_event.dart';
import 'package:spender_tracker/features/bottom_navbar/presentation/widgets/navbar_item.dart';

class CustomFloatingNavBar extends StatelessWidget {
  const CustomFloatingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final itemState = context.select((NavigationBloc bloc) => bloc.state);
    final items = itemState.items ?? [];

    if (items.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color:
                isDark
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
          children:
              items.map((item) {
                final isSelected = item.id == itemState.selectedItemId;
                return NavbarItem(
                  icon: item.icon,
                  label: item.label,
                  isSelected: isSelected,
                  isDark: isDark,
                  onTap: () {
                    context.read<NavigationBloc>().add(
                      NavigationItemSelectedEvent(item.id),
                    );
                  },
                );
              }).toList(),
        ),
      ),
    );
  }
}
