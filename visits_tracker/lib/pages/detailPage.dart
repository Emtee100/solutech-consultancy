import 'package:flutter/material.dart';
import 'package:visits_tracker/models/visit.dart';

class Detailpage extends StatelessWidget {
  const Detailpage({super.key, required this.visitItem});
  final Visit visitItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Visit details'),
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        spacing: 20,
        children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              maxRadius: 50,
              child: Icon(Icons.person, size: 80),
            ),
          ),
          Text(visitItem.customerName),
          Text(visitItem.location),
          Text("Visit date: ${visitItem.visitDate}",textAlign: TextAlign.center,),
          Text("created at: ${visitItem.createdAt}",textAlign: TextAlign.center,),
          Text("notes: ${visitItem.notes}",textAlign: TextAlign.center,),
          Text("status ${visitItem.status}"),
          Text("Activities done: ${visitItem.activitiesDone.join(', ')}")
        ],
      ),
    );
  }
}
