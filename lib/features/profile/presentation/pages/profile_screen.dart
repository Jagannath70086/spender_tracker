import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_bloc.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_event.dart';
import 'package:spender_tracker/features/auth/presentation/bloc/user_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    final bool swipeEnabled = true;

    return Scaffold(
      body: CustomScrollView(
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
                            userState.userModel?.photoUrl ?? 'https://i.pravatar.cc/300',
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
                        ),const SizedBox(height: 4),
                        if(userState.userModel?.phoneNo?.length != 0)
                        Text(
                          userState.userModel?.phoneNo ?? '',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.push('/profile-update');
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
                  icon: Icons.account_balance,
                  label: "Add Bank",
                  onTap: () {},
                ),
                _ProfileActionTile(
                  icon: Icons.credit_card,
                  label: "Add Card",
                  onTap: () {},
                ),
                _ProfileActionTile(
                  icon: Icons.money_off,
                  label: "Add Transaction",
                  onTap: () {},
                ),
                _ProfileSwitchTile(
                  icon: Icons.swipe,
                  label: "Enable Swipe Actions",
                  value: swipeEnabled,
                  onChanged: (val) {

                  },
                ),
                _ProfileActionTile(
                  icon: Icons.help_outline,
                  label: "Help & Support",
                  onTap: () {},
                ),
                _ProfileActionTile(
                  icon: Icons.info_outline,
                  label: "About Us",
                  onTap: () {

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
      ),
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
        secondary: Icon(
          icon,
          color: theme.iconTheme.color,
        ),
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
