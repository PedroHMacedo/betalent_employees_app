import 'package:betalent_employees_app/theme/text_styles.dart';
import 'package:flutter/material.dart';

class EmployeesHeader extends StatelessWidget {
  final void Function(String) onSearch;

  const EmployeesHeader({required this.onSearch, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Funcionários', style: AppTextStyles.h1),
        const SizedBox(height: 16),
        TextField(
          onChanged: onSearch,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surfaceTint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            hintText: 'Pesquisar',
            hintStyle: AppTextStyles.h3.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
