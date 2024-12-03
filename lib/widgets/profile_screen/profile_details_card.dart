import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icragee_mobile/controllers/user_controller.dart';
import 'package:icragee_mobile/models/user_details.dart';
import 'package:icragee_mobile/shared/colors.dart';

class ProfileDetailsCard extends StatelessWidget {
  final UserDetails user;
  final bool admin;

  const ProfileDetailsCard({
    super.key,
    required this.user,
    this.admin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailTile("Email ID", user.email),
          if (!admin) ...[
            _buildDetailTile("Food Preference", user.foodPreference!),
            _buildDetailTile("Contact", user.contact!),
            _buildDetailTile("Designation", user.designation!),
            _buildDetailTile("Institution", user.institution!),
            _buildDetailTile(
                "Registration Category", user.registrationCategory!,
                isLast: true),
          ],
          if (admin)
            Consumer(
              builder: (context, ref, child) {
                final user = ref.read(userProvider)!;
                return _buildDetailTile(
                  "Role",
                  user.role.displayString,
                  isLast: true,
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildDetailTile(String title, String value, {bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[500],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff1C1C1C),
            ),
          ),
        ],
      ),
    );
  }
}
