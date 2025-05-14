import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_bloc.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_event.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_state.dart';
import 'package:spender_tracker/features/banks/presentation/sub_features/add_bank/presentation/pages/add_bank.dart';
import 'package:spender_tracker/features/cards/presentation/sub_features/add_card/presentation/pages/add_card.dart';
import 'package:spender_tracker/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:spender_tracker/features/profile/presentation/bloc/profile_event.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/presentation/pages/about_us.dart';
import 'package:spender_tracker/features/profile/sub_features/contact_us/presentation/pages/contact_us.dart';
import 'package:spender_tracker/features/profile/sub_features/update_profile/presentation/pages/update_profile.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:spender_tracker/features/theme/presentation/bloc/theme_events.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.05),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.only(bottom: 16),
                alignment: Alignment.center,
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, userState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            userState.userModel?.photoUrl ??
                                'https://i.pravatar.cc/300',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          userState.userModel?.name ?? 'John Doe',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userState.userModel?.email ?? 'john.doe@example.com',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (userState.userModel?.phoneNo?.isNotEmpty ?? false)
                          Text(
                            userState.userModel?.phoneNo ?? '',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.hintColor,
                            ),
                          ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.push(UpdateProfile.route);
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text("Edit Profile"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            scrolledUnderElevation: 0,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _ProfileActionTile(
                  icon: Icons.credit_card,
                  label: "Add Card",
                  onTap: () {
                    context.push(AddCard.route);
                  },
                ),
                _ProfileActionTile(
                  icon: Icons.account_balance,
                  label: "Add Bank",
                  onTap: () {
                    context.push(AddBank.route);
                  },
                ),
                _ProfileActionTile(
                  icon: Icons.money_off,
                  label: "Add Transaction",
                  onTap: () {},
                ),
                _ProfileActionTile(
                  icon: Icons.color_lens,
                  label: "Change Theme",
                  onTap: () {
                    showModernThemeSelector(context);
                  },
                ),
                _ProfileSwitchTile(
                  icon: Icons.swipe,
                  label: "Enable Swipe Actions",
                  value: context.select(
                    (ProfileBloc bloc) => bloc.state.isSwipeActionsEnabled,
                  ),
                  onChanged:
                      (val) =>
                          context.read<ProfileBloc>().add(ToggleSwipeAction()),
                ),
                _ProfileActionTile(
                  icon: Icons.help_outline,
                  label: "Help & Support",
                  onTap: () {
                    context.push(HelpSupportPage.route);
                  },
                ),
                _ProfileActionTile(
                  icon: Icons.info_outline,
                  label: "About Us",
                  onTap: () {
                    context.push(AboutUsPage.route);
                  },
                ),
                _ProfileActionTile(
                  icon: Icons.logout,
                  label: "Logout",
                  onTap: () {
                    onLogoutPressed(context);
                  },
                  isDestructive: true,
                ),
                const SizedBox(height: 20),
              ]),
            ),
          ),
        ],
      );
  }

  void onLogoutPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure want to logout'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<UserBloc>().add(LogoutEvent());
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void showModernThemeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final currentTheme = context.select(
          (ThemeBloc bloc) => bloc.state.themeEntity!.themeMode,
        );

        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: ShaderMask(
                  shaderCallback:
                      (bounds) => LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ).createShader(bounds),
                  child: Text(
                    'Choose Your Theme',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Select the perfect look for your app experience',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    children: [
                      _buildModernThemeOption(
                        context,
                        title: 'Light Mode',
                        subtitle: 'Clean & Bright',
                        themeMode: ThemeMode.light,
                        currentTheme: currentTheme,
                        icon: Icons.light_mode_rounded,
                        backgroundColors: [Colors.blue[50]!, Colors.white],
                        mockElementColors: [
                          Colors.blue[100]!,
                          Colors.grey[300]!,
                        ],
                        mockTextColor: Colors.grey[400]!,
                      ),

                      _buildModernThemeOption(
                        context,
                        title: 'Dark Mode',
                        subtitle: 'Easy on the eyes',
                        themeMode: ThemeMode.dark,
                        currentTheme: currentTheme,
                        icon: Icons.dark_mode_rounded,
                        backgroundColors: [
                          Colors.grey[900]!,
                          Colors.grey[800]!,
                        ],
                        mockElementColors: [
                          Colors.grey[700]!,
                          Colors.grey[600]!,
                        ],
                        mockTextColor: Colors.grey[500]!,
                      ),

                      _buildModernThemeOption(
                        context,
                        title: 'System',
                        subtitle: 'Match system',
                        themeMode: ThemeMode.system,
                        currentTheme: currentTheme,
                        icon: Icons.brightness_auto,
                        backgroundColors: [Colors.purple[50]!, Colors.white],
                        mockElementColors: [
                          Colors.purple[100]!,
                          Colors.grey[300]!,
                        ],
                        mockTextColor: Colors.grey[400]!,
                        isSystemTheme: true,
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildModernThemeOption(
  BuildContext context, {
  required String title,
  required String subtitle,
  required ThemeMode themeMode,
  required ThemeMode currentTheme,
  required IconData icon,
  required List<Color> backgroundColors,
  required List<Color> mockElementColors,
  required Color mockTextColor,
  bool isSystemTheme = false,
}) {
  final isSelected = themeMode == currentTheme;
  final isDarkMockup = backgroundColors[0].computeLuminance() < 0.5;

  return GestureDetector(
    onTap: () {
      context.read<ThemeBloc>().add(ToggleThemeWithValueEvent(themeMode));

      final snackBar = SnackBar(
        content: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              '$title theme applied',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      final navigator = Navigator.of(context);

      Future.delayed(const Duration(milliseconds: 200), () {
        navigator.pop();
      });
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color:
                isSelected
                    ? Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.05),
            blurRadius: isSelected ? 12 : 6,
            spreadRadius: isSelected ? 2 : 0,
            offset: isSelected ? const Offset(0, 4) : const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).dividerColor.withValues(alpha: 0.1),
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: backgroundColors,
                    ),
                  ),
                  padding:
                      isSystemTheme
                          ? const EdgeInsets.all(8)
                          : const EdgeInsets.all(16),
                  child:
                      isSystemTheme
                          ? _buildSystemThemePreview(
                            context,
                            isDarkMockup,
                            mockElementColors,
                            mockTextColor,
                          )
                          : _buildThemePreviewContent(
                            isDarkMockup,
                            mockElementColors,
                            mockTextColor,
                            icon,
                          ),
                ),
              ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(
                                  context,
                                ).textTheme.titleMedium?.color,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(
                          context,
                        ).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (isSelected)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.5),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Icon(Icons.check, size: 16, color: Colors.white),
              ),
            ),
        ],
      ),
    ),
  );
}

Widget _buildThemePreviewContent(
  bool isDarkMockup,
  List<Color> mockElementColors,
  Color mockTextColor,
  IconData icon,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 10,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: mockElementColors[0],
          borderRadius: BorderRadius.circular(5),
        ),
      ),

      Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: mockElementColors[1],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 20,
              color: isDarkMockup ? Colors.white70 : Colors.black54,
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: mockTextColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 8,
                  width: 60,
                  decoration: BoxDecoration(
                    color: mockTextColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildSystemThemePreview(
  BuildContext context,
  bool isDarkMockup,
  List<Color> mockElementColors,
  Color mockTextColor,
) {
  return Container(
    height: 70,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey.withValues(alpha: 0.1),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.light_mode, color: Colors.amber, size: 24),
                const SizedBox(height: 8),
                Container(
                  height: 6,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 6,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
          ),
        ),

        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              color: Colors.grey[850],
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.dark_mode, color: Colors.indigo, size: 24),
                const SizedBox(height: 8),
                Container(
                  height: 6,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 6,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _ProfileActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ProfileActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: theme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red : theme.iconTheme.color,
        ),
        title: Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: isDestructive ? Colors.red : null,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _ProfileSwitchTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ProfileSwitchTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: theme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SwitchListTile(
        secondary: Icon(icon, color: theme.iconTheme.color),
        title: Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
