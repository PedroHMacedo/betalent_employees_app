import 'package:betalent_employees_app/domain/entities/employee_entity.dart';
import 'package:betalent_employees_app/presentation/controllers/employee_controller.dart';
import 'package:betalent_employees_app/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:betalent_employees_app/presentation/widgets/employees_header.dart';
import 'package:betalent_employees_app/presentation/widgets/employee_list_item.dart';

class EmployeesPage extends StatefulWidget {
  final EmployeeController controller;

  const EmployeesPage({super.key, required this.controller});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  @override
  void initState() {
    super.initState();
    widget.controller.loadEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EmployeesHeader(onSearch: widget.controller.updateSearchQuery),
            const SizedBox(height: 16),
            _buildTableHeader(context),
            _buildEmployeesList(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            child: Text(
              'CG',
              style: AppTextStyles.h3.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          Badge(
            backgroundColor: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.all(2),
            label: const Text('02'),
            child: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          Text(
            'Foto',
            style: AppTextStyles.h2.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          SizedBox(width: 32),
          Text(
            'Nome',
            style: AppTextStyles.h2.copyWith(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.circle,
              size: 10,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeesList() {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.controller.isLoading,
      builder: (context, isLoading, _) {
        if (isLoading) {
          return _buildLoadingIndicator();
        }

        return ValueListenableBuilder<String?>(
          valueListenable: widget.controller.error,
          builder: (context, error, _) {
            if (error != null) {
              return _buildErrorState(error);
            }

            return _buildEmployeesListContent();
          },
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
          child: Text(
            error,
            textAlign: TextAlign.center,
            style: AppTextStyles.h3.copyWith(color: Colors.red),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: widget.controller.loadEmployees,
          child: const Text('Tentar Novamente'),
        ),
      ],
    );
  }

  Widget _buildEmployeesListContent() {
    return ValueListenableBuilder<List<EmployeeEntity>>(
      valueListenable: widget.controller.filteredEmployees,
      builder: (context, employees, _) {
        if (employees.isEmpty) {
          return Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Center(child: Text('Funcionário não encontrado')),
          );
        }

        return Expanded(
          child: ListView.separated(
            itemCount: employees.length,
            separatorBuilder: (_, __) => const SizedBox.shrink(),
            itemBuilder: (context, index) {
              final employee = employees[index];
              return EmployeeListItem(
                employee: employee,
                isLastItem: index == employees.length - 1,
                onTap: () {
                  setState(() {
                    employee.isExpanded = !employee.isExpanded;
                  });
                },
              );
            },
          ),
        );
      },
    );
  }
}
