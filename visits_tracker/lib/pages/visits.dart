import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:visits_tracker/provider/app_logic.dart';

import 'package:visits_tracker/widgets/filterWidget.dart';
import 'package:visits_tracker/widgets/filteredList.dart';
import 'package:visits_tracker/widgets/visitForm.dart';

class Visits extends StatefulWidget {
  const Visits({super.key});

  @override
  State<Visits> createState() => _VisitsState();
}

class _VisitsState extends State<Visits> {
  late Future<List<dynamic>> visits;
  final appLogic = AppLogic();

  @override
  void initState() {
    super.initState();
    // Fetch visits once when widget initializes
    final provider = Provider.of<AppLogic>(context, listen: true);
    visits = provider.getAllVisits();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: visits,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                "An error occurred while fetching data, please try again later",
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.data!.isEmpty) {
          return Scaffold(body: Center(child: Text("No visits found")));
        } else {
          final allVisits = snapshot.data!;

          return Consumer<AppLogic>(
            builder: (context, value, child) {
              // filter visits locally based on filters activated
              final filteredVisits = value.filterList.isEmpty
                  ? allVisits
                  : allVisits
                        .where(
                          (visit) => value.filterList.contains(visit.status),
                        )
                        .toList();
              return Scaffold(
                backgroundColor: Theme.of(context).colorScheme.surface,
                body: SafeArea(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      // Filter chips
                      Filterwidget(),
                      // visits list
                      Filteredlist(visits: filteredVisits),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context){
                      return const VisitFormDialog();
                    }));
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return VisitFormDialog();
                    //   },
                    // );
                  },
                  label: Text("Add Visit"),
                  icon: Icon(Icons.add),
                ),
              );
            },
          );
        }
      },
    );
  }
}
