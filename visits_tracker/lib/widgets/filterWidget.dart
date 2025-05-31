import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visits_tracker/provider/app_logic.dart';
import 'package:visits_tracker/themes/theme.dart';

class Filterwidget extends StatefulWidget {
  const Filterwidget({super.key});

  @override
  State<Filterwidget> createState() => _FilterwidgetState();
}

class _FilterwidgetState extends State<Filterwidget> {
  bool _completed = true;
  bool _pending = false;
  bool _cancelled = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppLogic>(context, listen: false);
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme().pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            SizedBox(height: 0),
            // title
            Text(
              "Visits",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),

            //filter capability
            Wrap(
              spacing: 10,
              children: [
                FilterChip(
                  label: Text("Completed"),
                  onSelected: (_) {
                    setState(() {
                      _completed = !_completed;
                    });
                    // Update the filter list in the provider
                    provider.setFilterList("Completed");
                  },
                  selected: _completed,
                ),
                FilterChip(
                  label: Text("Pending"),
                  onSelected: (_) {
                    setState(() {
                      _pending = !_pending;
                    });
                    // Update the filter list in the provider
                    provider.setFilterList("Pending");
                  },
                  selected: _pending,
                ),
                FilterChip(
                  label: Text("Cancelled"),
                  onSelected: (_) {
                    setState(() {
                      _cancelled = !_cancelled;
                    });
                    // Update the filter list in the provider
                    provider.setFilterList("Cancelled");
                  },
                  selected: _cancelled,
                ),
              ],
            ),
            //SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
