import 'package:betalent_employees_app/domain/entities/employee_entity.dart';
import 'package:betalent_employees_app/presentation/controllers/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/profile_info_card.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: Text(
                'CG',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Spacer(),
            Badge(label: Text('02'), child: Icon(Icons.notifications_outlined)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Funcionários',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Search Bar
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                hintText: 'Pesquisar',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(153),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Table Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    'Foto',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(width: 32),
                  Text(
                    'Nome',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.circle,
                    size: 12,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(153),
                  ),
                ],
              ),
            ),

            ValueListenableBuilder<bool>(
              valueListenable: widget.controller.isLoading,
              builder: (context, isLoading, _) {
                if (isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.amberAccent),
                  );
                }

                return ValueListenableBuilder<String?>(
                  valueListenable: widget.controller.error,
                  builder: (context, error, _) {
                    if (error != null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              error,
                              style: const TextStyle(color: Colors.red),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: widget.controller.loadEmployees,
                              child: const Text('Try Again'),
                            ),
                          ],
                        ),
                      );
                    }

                    return ValueListenableBuilder<List<EmployeeEntity>>(
                      valueListenable: widget.controller.employees,
                      builder: (context, employees, _) {
                        if (employees.isEmpty) {
                          return const Center(
                            child: Text('No employees found'),
                          );
                        }

                        return Expanded(
                          child: ListView.separated(
                            itemCount: employees.length,
                            separatorBuilder:
                                (context, index) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final employee = employees[index];
                              return Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        employee.image,
                                      ),
                                    ),
                                    title: Text(employee.name),
                                    trailing: Icon(
                                      employee.isExpanded
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    onTap: () {
                                      setState(() {
                                        employee.isExpanded =
                                            !employee.isExpanded;
                                      });
                                    },
                                  ),
                                  if (employee.isExpanded)
                                    ProfileInfoCard(
                                      name: employee.name,
                                      role: employee.job,
                                      admissionDate: formatDate(
                                        employee.admissionDate,
                                      ),
                                      phone: formatPhoneNumber(employee.phone),
                                    ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),

            // Employees List
          ],
        ),
      ),
    );
  }

  String formatDate(String isoDate) {
    try {
      DateTime parsedDate = DateTime.parse(
        isoDate,
      ); // Converte a string em DateTime
      return DateFormat(
        'dd/MM/yyyy',
      ).format(parsedDate); // Formata para "02/12/2019"
    } catch (e) {
      return 'Data inválida'; // Retorna um fallback caso a conversão falhe
    }
  }

  String formatPhoneNumber(String phone) {
    // Verifica se o número contém apenas dígitos
    if (!RegExp(r'^\d+$').hasMatch(phone)) return 'Número inválido';

    // Certifica-se de que o número tem pelo menos 11 caracteres (Brasil)
    if (phone.length < 10 || phone.length > 13) return 'Número inválido';

    // Extrai o DDI, DDD e número principal
    String countryCode =
        phone.length > 11 ? '+${phone.substring(0, 2)} ' : '+55 ';
    String ddd = '(${phone.substring(phone.length - 11, phone.length - 9)}) ';
    String firstPart;
    String secondPart;

    if (phone.length == 12 || phone.length == 13) {
      // Exemplo: 551234567890 -> +55 (12) 3456-7890
      firstPart = phone.substring(phone.length - 9, phone.length - 5);
      secondPart = phone.substring(phone.length - 5);
    } else {
      // Exemplo: 5512987654321 -> +55 (12) 98765-4321 (Celular)
      firstPart = phone.substring(phone.length - 9, phone.length - 4);
      secondPart = phone.substring(phone.length - 4);
    }

    return '$countryCode$ddd$firstPart-$secondPart';
  }
}
