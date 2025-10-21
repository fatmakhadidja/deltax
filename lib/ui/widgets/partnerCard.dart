import 'package:deltax/core/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PartnerCard extends StatelessWidget {
  final String name;
  final String wilaya;
  final String description;
  final String imageUrl;
  final String? facebook;
  final String? instagram;
  final String? tiktok;
  final String? website;

  const PartnerCard({
    super.key,
    required this.name,
    required this.wilaya,
    required this.description,
    required this.imageUrl,
    this.facebook,
    this.instagram,
    this.tiktok,
    this.website,
  });

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  Widget _buildSocialIcon(IconData icon, String url, Color color) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FaIcon(icon, color: color, size: 22),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imageUrl,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                wilaya,
                style: const TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (facebook != null && facebook!.isNotEmpty)
                  _buildSocialIcon(
                    FontAwesomeIcons.facebook,
                    facebook!,
                    Colors.blueAccent,
                  ),
                if (instagram != null && instagram!.isNotEmpty)
                  _buildSocialIcon(
                    FontAwesomeIcons.instagram,
                    instagram!,
                    Colors.pinkAccent,
                  ),
                if (tiktok != null && tiktok!.isNotEmpty)
                  _buildSocialIcon(
                    FontAwesomeIcons.tiktok,
                    tiktok!,
                    Colors.black87,
                  ),
                if (website != null && website!.isNotEmpty)
                  _buildSocialIcon(
                    FontAwesomeIcons.globe,
                    website!,
                    Colors.green,
                  ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
