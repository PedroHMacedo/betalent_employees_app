import 'package:betalent_employees_app/domain/entities/employee_entity.dart';
import 'package:betalent_employees_app/domain/services/formatter_service.dart';
import 'package:betalent_employees_app/presentation/widgets/profile_info_card.dart';
import 'package:betalent_employees_app/theme/text_styles.dart';
import 'package:flutter/material.dart';

class EmployeeListItem extends StatelessWidget {
  final EmployeeEntity employee;
  final VoidCallback onTap;
  final bool isLastItem;

  const EmployeeListItem({
    required this.employee,
    required this.onTap,
    required this.isLastItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Theme.of(context).colorScheme.outline),
              left: BorderSide(color: Theme.of(context).colorScheme.outline),
              right: BorderSide(color: Theme.of(context).colorScheme.outline),
              bottom:
                  (isLastItem && !employee.isExpanded)
                      ? BorderSide(color: Theme.of(context).colorScheme.outline)
                      : BorderSide.none,
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(employee.image),
            ),
            title: Text(
              employee.name,
              style: AppTextStyles.h3.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            trailing: Icon(
              employee.isExpanded ? Icons.expand_less : Icons.expand_more,
              color: Theme.of(context).colorScheme.primary,
            ),
            onTap: onTap,
          ),
        ),
        if (employee.isExpanded)
          ProfileInfoCard(
            name: employee.name,
            role: employee.job,
            admissionDate: FormatterService.formatDate(employee.admissionDate),
            phone: FormatterService.formatPhoneNumber(employee.phone),
          ),
      ],
    );
  }
}
