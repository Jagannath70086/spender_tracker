import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/presentation/bloc/app_info_bloc.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/presentation/widgets/legal_document_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  static const String route = '/about-us';

  @override
  Widget build(BuildContext context) {
    final appInfo = context.select(
      (AppInfoBloc bloc) => bloc.state.appInfoModel,
    );
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('About Us', style: theme.textTheme.headlineMedium),
        backgroundColor: const Color(0xFF9b87f5),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF9b87f5), theme.colorScheme.onPrimary],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet,
                            size: 50,
                            color: Color(0xFF9b87f5),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          appInfo?.name ?? 'Spender',
                          style: theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          appInfo?.description ??
                              'Manage your finances with ease',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: theme.colorScheme.surface,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'App Version',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'v${appInfo?.currentVersion} (Build ${appInfo?.buildNumber})',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.textTheme.bodyMedium?.color
                                      ?.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              appInfo?.currentVersion == appInfo?.latestVersion
                                  ? 'Latest'
                                  : 'Older',
                              style: TextStyle(
                                color:
                                    appInfo?.currentVersion ==
                                            appInfo?.latestVersion
                                        ? theme.colorScheme.primary
                                        : theme.colorScheme.error,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text('Our Story', style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Text(
                      '${appInfo?.name ?? 'Our App'} was founded in 2023 with a simple mission: to make personal finance management accessible to everyone. We believe that understanding your spending habits is the first step toward financial freedom.\n\nOur team of finance experts and software engineers have worked tirelessly to create an intuitive, powerful tool that helps you track expenses, set budgets, and achieve your financial goals.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text('Key Features', style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 16),

                  _buildFeatureItem(
                    icon: Icons.track_changes,
                    title: 'Expense Tracking',
                    description:
                        'Keep track of every penny with our easy-to-use expense logger.',
                    color: Colors.blue,
                  ),

                  _buildFeatureItem(
                    icon: Icons.insert_chart_outlined,
                    title: 'Visual Analytics',
                    description:
                        'Gain insights with beautiful charts and detailed reports.',
                    color: const Color(0xFF7E69AB),
                  ),

                  _buildFeatureItem(
                    icon: Icons.notifications_active,
                    title: 'Budget Alerts',
                    description:
                        'Set budget limits and receive notifications to stay on track.',
                    color: Colors.orange,
                  ),

                  _buildFeatureItem(
                    icon: Icons.security,
                    title: 'Data Security',
                    description:
                        'Your financial data is encrypted and secure at all times.',
                    color: Colors.green,
                  ),

                  const SizedBox(height: 30),

                  Text('Our Team', style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  Text(
                    'We\'re a passionate team of developers, designers, and finance enthusiasts dedicated to transforming how people manage their money.',
                    style: theme.textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Get In Touch',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Color(0xFF1A1F2C),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildContactItem(
                          icon: Icons.email_outlined,
                          text: 'support@spendtracker.com',
                        ),
                        _buildContactItem(
                          icon: Icons.language,
                          text: 'coming soon',
                        ),
                        _buildContactItem(
                          icon: Icons.location_on_outlined,
                          text: 'Unknown',
                        ),

                        const SizedBox(height: 24),
                        Row(
                          children: [
                            _buildLegalButton(
                              context,
                              title: 'Privacy Policy',
                              icon: Icons.privacy_tip_outlined,
                              text: appInfo?.privacyPolicy ?? '',
                            ),
                            const SizedBox(width: 5),
                            _buildLegalButton(
                              context,
                              title: 'Terms of Service',
                              icon: Icons.gavel_outlined,
                              text: appInfo?.termsOfService ?? '',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(
                        Icons.facebook,
                        Colors.blue,
                        'https://facebook.com',
                      ),
                      _buildSocialButton(
                        Icons.telegram,
                        Colors.blue.shade700,
                        'https://telegram.org',
                      ),
                      _buildSocialButton(
                        Icons.discord,
                        Colors.deepPurple,
                        'https://discord.com',
                      ),
                      _buildSocialButton(
                        Icons.android,
                        Colors.green,
                        'https://play.google.com/store/apps/details?id=com.example.spender_tracker',
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      '© 2025 ${appInfo?.name ?? 'Spend Tracker'}. All rights reserved.',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF9b87f5), size: 20),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String text,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () {
          _showDialog(context, text);
        },
        icon: Icon(icon, size: 18),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9b87f5).withValues(alpha: 0.1),
          foregroundColor: const Color(0xFF9b87f5),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color, String url) {
    return GestureDetector(
      onTap:
          () => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }

  void _showDialog(BuildContext context, String? text) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder:
          (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return LegalDocumentSheet(
            content: text ?? '',
            scrollController: scrollController,
          );
        },
      ),
    );
  }
}
