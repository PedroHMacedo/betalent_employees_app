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
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar and name
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.person,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.expand_less,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Info items
            _buildInfoItem(context, 'Cargo', role),
            const SizedBox(height: 8),
            _buildInfoItem(context, 'Data de admissão', admissionDate),
            const SizedBox(height: 8),
            _buildInfoItem(context, 'Telefone', phone),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
