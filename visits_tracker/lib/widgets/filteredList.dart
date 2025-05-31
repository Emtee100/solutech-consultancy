import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visits_tracker/pages/detailPage.dart';
import 'package:visits_tracker/provider/app_logic.dart';
import 'package:visits_tracker/themes/theme.dart';

class Filteredlist extends StatelessWidget {
  const Filteredlist({super.key, required this.visits});
  final List<dynamic> visits;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppLogic>(
      builder: (context, value, child) => SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: visits.length,
          (context, index) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme().pagePadding,
              vertical: 10,
            ),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Detailpage(visitItem: visits[index]);
                    },
                  ),
                );
              },
              leading: Icon(Icons.person, size: 50),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    visits[index].customerName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    visits[index].location,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              subtitle: Text(visits[index].visitDate),
              tileColor: Theme.of(context).colorScheme.surfaceContainerHigh,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
