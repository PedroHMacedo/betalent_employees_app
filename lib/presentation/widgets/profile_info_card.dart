import 'package:betalent_employees_app/theme/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileInfoCard extends StatelessWidget {
  final String name;
  final String role;
  final String admissionDate;
  final String phone;

  const ProfileInfoCard({
    super.key,
    required this.name,
    required this.role,
    required this.admissionDate,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Theme.of(context).colorScheme.outline),
          right: BorderSide(color: Theme.of(context).colorScheme.outline),
          bottom: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
      ),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoItem(context, 'Cargo', role),
              const SizedBox(height: 8),
              _buildInfoItem(context, 'Data de admissão', admissionDate),
              const SizedBox(height: 8),
              _buildInfoItem(context, 'Telefone', phone),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.h2),
        Text(value, style: AppTextStyles.h3),
      ],
    );
  }
}
