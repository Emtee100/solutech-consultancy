import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visits_tracker/models/activity.dart';
import 'package:visits_tracker/models/customer.dart';
import 'package:visits_tracker/provider/app_logic.dart';
import 'package:visits_tracker/themes/theme.dart';

class VisitFormDialog extends StatefulWidget {
  const VisitFormDialog({super.key});

  @override
  State<VisitFormDialog> createState() => _VisitFormDialogState();
}

class _VisitFormDialogState extends State<VisitFormDialog> {
  late final TextEditingController _notesController;
  late final TextEditingController _locationController;
  late final TextEditingController _customerController;
  late final TextEditingController _activityController;
  late final TextEditingController _statusController;
  bool _dateSelected = false;
  String? selectedCustomerId;
  String? selectedActivityId;
  bool _isLoading = true;
  late DateTime pickedDate;
  final _formKey = GlobalKey<FormState>();
  late final List<DropdownMenuEntry<Activity>> _activities;
  late final List<DropdownMenuEntry<Customer>> _customers;

  @override
  void initState() {
    super.initState();
    _customerController = TextEditingController();
    _activityController = TextEditingController();
    _notesController = TextEditingController();
    _locationController = TextEditingController();
    _statusController = TextEditingController();
    _loadData();
  }

  void _loadData() async {
    final provider = Provider.of<AppLogic>(context, listen: false);
    // fetch customers and activities
    _customers = await provider.getCustomers();
    _activities = await provider.getActivities();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _customerController.dispose();
    _statusController.dispose();
    _activityController.dispose();
    _notesController.dispose();
    _locationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppLogic>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, size: 20),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Add New Visit",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 30,
                        //fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
        
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTheme().pagePadding,
                        ),
                        child: Column(
                          spacing: 20,
                          children: [
                            FormField<String>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a customer';
                                }
                                return null;
                              },
                              builder: (FormFieldState<String> field) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DropdownMenu<Customer>(
                                      controller: _customerController,
                                      label: const Text("Customer Name"),
                                      width:
                                          MediaQuery.of(context).size.width -
                                          (AppTheme().pagePadding *
                                              2), // Ensure it takes full available width within padding
                                      dropdownMenuEntries: _customers,
                                      onSelected: (Customer? value) {
                                        if (value != null) {
                                          selectedCustomerId = value.id;
                                          field.didChange(value.name);
                                        }
                                      },
                                    ),
                                    if (field.hasError)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12.0,
                                          top: 5.0,
                                        ),
                                        child: Text(
                                          field.errorText!,
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.error,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            FormField<String>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select an activity';
                                }
                                return null;
                              },
                              builder: (FormFieldState<String> field) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DropdownMenu<Activity>(
                                      controller: _activityController,
                                      label: const Text("Activities Done"),
                                      width:
                                          MediaQuery.of(context).size.width -
                                          (AppTheme().pagePadding *
                                              2), // Ensure it takes full available width
                                      dropdownMenuEntries: _activities,
                                      onSelected: (Activity? value) {
                                        if (value != null) {
                                          selectedActivityId = value.id;
                                          field.didChange(value.description);
                                        }
                                      },
                                    ),
                                    if (field.hasError)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12.0,
                                          top: 5.0,
                                        ),
                                        child: Text(
                                          field.errorText!,
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.error,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            FormField<String>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the status';
                                }
                                return null;
                              },
                              builder: (FormFieldState<String> field) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DropdownMenu<String>(
                                      controller: _statusController,
                                      label: const Text("Status"),
                                      width:
                                          MediaQuery.of(context).size.width -
                                          (AppTheme().pagePadding *
                                              2), // Ensure it takes full available width
                                      dropdownMenuEntries: const [
                                        DropdownMenuEntry(
                                          value: "Completed",
                                          label: "Completed",
                                        ),
                                        DropdownMenuEntry(
                                          value: "Pending",
                                          label: "Pending",
                                        ),
                                        DropdownMenuEntry(
                                          value: "Cancelled",
                                          label: "Cancelled",
                                        ),
                                      ],
                                      onSelected: (String? value) {
                                        field.didChange(value);
                                      },
                                    ),
                                    if (field.hasError)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12.0,
                                          top: 5.0,
                                        ),
                                        child: Text(
                                          field.errorText!,
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.error,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _locationController,
                              decoration: InputDecoration(
                                labelText: "Location",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a location";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: _notesController,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "Notes",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a note";
                                }
                                return null;
                              },
                            ),
                            GestureDetector(
                              onTap: () async {
                                final DateTime currentDate = DateTime.now();
                                final DateTime? selectedDate =
                                    await showDatePicker(
                                      barrierDismissible: false,
                                      initialDatePickerMode: DatePickerMode.day,
                                      context: context,
                                      firstDate: DateTime(
                                        currentDate.year,
                                        currentDate.month,
                                      ),
                                      lastDate: currentDate,
                                    );
                                if (selectedDate != null) {
                                  setState(() {
                                    _dateSelected = true;
                                  });
                                  pickedDate = selectedDate;
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 15,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: double.infinity,
                                height: 60,
                                child: _dateSelected
                                    ? Text(pickedDate.toString())
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Enter visit date"),
                                          Icon(Icons.calendar_month),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppTheme().pagePadding),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primary,
                    ),
                    minimumSize: WidgetStatePropertyAll(
                      Size(double.infinity, 50),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // add send data
                      if (_dateSelected == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Theme.of(context).colorScheme.error,
                            content: Text(
                              "Please enter the visit date",
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        );
                      }
                      print(_customerController);
                      final int responseCode = await provider.addNewVisit(
                        customerId: int.parse(selectedCustomerId ?? '1'),
                        visitDate: pickedDate.toUtc().toIso8601String(),
                        status: _statusController.value.text,
                        location: _locationController.text.trim(),
                        notes: _notesController.text.trim(),
                        activitiesDone: [selectedActivityId ?? '1'],
                        createdAt: DateTime.now().toUtc().toIso8601String(),
                      );
                      if (responseCode == 201) {
                        if (context.mounted) {
                          //remove form
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                "Visit added successfully",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: Text(
                    "Add Entry",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
