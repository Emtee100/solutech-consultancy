import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:visits_tracker/models/activity.dart';
import 'package:visits_tracker/models/customer.dart';
import 'dart:convert';

import 'package:visits_tracker/models/visit.dart';

class AppLogic extends ChangeNotifier {
  // Create a private list to hold filter parameters
  // This list can be used to filter visits based on status
  final List<String> _filterList = ["Completed"];

  // Getter for filterList
  List<String> get filterList => _filterList;

  // Method to add or remove a filter value
  void setFilterList(String value) {
    if (_filterList.contains(value)) {
      _filterList.remove(value);
    } else {
      _filterList.add(value);
    }
    notifyListeners(); // Notify listeners to update the UI
  }

  Future<List<DropdownMenuEntry<Customer>>> getCustomers() async {
    // create an empty list to hold customers
    final List<DropdownMenuEntry<Customer>> _customers = [];

    // fetch customers from the API
    try {
      final response = await http.get(
        Uri.parse('https://kqgbftwsodpttpqgqnbh.supabase.co/rest/v1/customers'),
        headers: {
          'apikey':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtxZ2JmdHdzb2RwdHRwcWdxbmJoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU5ODk5OTksImV4cCI6MjA2MTU2NTk5OX0.rwJSY4bJaNdB8jDn3YJJu_gKtznzm-dUKQb4OvRtP6c',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> _customerList = jsonDecode(response.body);
        print(_customerList);

        // create a list of Customer objects
        for (var customer in _customerList) {
          final Customer newCustomer = Customer(
            id: customer["id"].toString(),
            name: customer["name"],
            createdAt: customer["created_at"],
          );
          // add new customer to customer list
          _customers.add(
            DropdownMenuEntry(value: newCustomer, label: newCustomer.name),
          );
        }
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    return _customers;
  }

  Future<List<String>> getActivityDescriptions(
    List<dynamic> acitivityId,
  ) async {
    // create  empty list to hold activity descriptions
    List<String> _activityDescriptions = [];
    // join the activity ids into a string for the query
    final String idList = acitivityId.join(',');

    try {
      final response = await http.get(
        Uri.parse(
          "https://kqgbftwsodpttpqgqnbh.supabase.co/rest/v1/activities?id=in.($idList)",
        ),
        headers: {
          'apikey':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtxZ2JmdHdzb2RwdHRwcWdxbmJoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU5ODk5OTksImV4cCI6MjA2MTU2NTk5OX0.rwJSY4bJaNdB8jDn3YJJu_gKtznzm-dUKQb4OvRtP6c',
        },
      );

      if (response.statusCode == 200) {
        // decode response
        final List<dynamic> _activityList = jsonDecode(response.body);

        for (var activity in _activityList) {
          _activityDescriptions.add(activity['description']);
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    print(_activityDescriptions);
    return _activityDescriptions;
  }

  Future<List<Visit>> getAllVisits() async {
    List<Visit> _visitList = [];
    try {
      final response = await http.get(
        Uri.parse(
          'https://kqgbftwsodpttpqgqnbh.supabase.co/rest/v1/visits?select=*,customers(name)',
        ),
        headers: {
          'apikey':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtxZ2JmdHdzb2RwdHRwcWdxbmJoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU5ODk5OTksImV4cCI6MjA2MTU2NTk5OX0.rwJSY4bJaNdB8jDn3YJJu_gKtznzm-dUKQb4OvRtP6c',
        },
      );
      if (response.statusCode == 200) {
        //decode response
        final List<dynamic> responseList = jsonDecode(response.body);

        //create a list of visit objects
        for (var visit in responseList) {
          //print(visit);
          // // get descriptions of activities
          final List<String> activityDescriptions =
              await getActivityDescriptions(visit['activities_done']);

          // create a Visit object
          final Visit visitItem = Visit(
            id: visit['id'],
            customerId: visit['customer_id'],
            customerName: visit['customers']['name'],
            visitDate: visit['visit_date'],
            status: visit['status'],
            notes: visit['notes'],
            location: visit['location'],
            activitiesDone: activityDescriptions,
            createdAt: visit['created_at'],
          );

          _visitList.add(visitItem); // add Visit to _visitList
        }
      } else {
        // print(response.statusCode);
        // print(response.body);
      }
    } catch (e) {
      //print(e);
    }

    return _visitList;
  }

  Future<List<DropdownMenuEntry<Activity>>> getActivities() async {
    // create an empty Activity list
    final List<DropdownMenuEntry<Activity>> _activities = [];
    try {
      final response = await http.get(
        Uri.parse(
          'https://kqgbftwsodpttpqgqnbh.supabase.co/rest/v1/activities',
        ),
        headers: {
          'apikey':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtxZ2JmdHdzb2RwdHRwcWdxbmJoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU5ODk5OTksImV4cCI6MjA2MTU2NTk5OX0.rwJSY4bJaNdB8jDn3YJJu_gKtznzm-dUKQb4OvRtP6c',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> _activityList = jsonDecode(response.body);
        print(_activityList);

        // create Activity objects from response
        for (var activityItem in _activityList) {
          final Activity activity = Activity(
            id: activityItem["id"].toString(),
            description: activityItem["description"],
            createdAt: activityItem["created_at"],
          );

          // add activity to activities list
          _activities.add(
            DropdownMenuEntry(value: activity, label: activity.description),
          );
        }
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    return _activities;
  }

  Future<int> addNewVisit({
    required int customerId,
    required String visitDate,
    required String status,
    required String location,
    required String notes,
    required List<String> activitiesDone,
    required String createdAt,
  }) async {
    int responseCode = 0;

    final body = jsonEncode({
      "customer_id": customerId,
      "visit_date": visitDate,
      "status": status,
      "location": location,
      "notes": notes,
      "activities_done": activitiesDone,
      "created_at": createdAt,
    });
    try {
      final response = await http.post(
        Uri.parse("https://kqgbftwsodpttpqgqnbh.supabase.co/rest/v1/visits"),
        headers: {
          'Content-Type': 'application/json',
          'apikey':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtxZ2JmdHdzb2RwdHRwcWdxbmJoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU5ODk5OTksImV4cCI6MjA2MTU2NTk5OX0.rwJSY4bJaNdB8jDn3YJJu_gKtznzm-dUKQb4OvRtP6c',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        print("Visit added successfully");
        responseCode = response.statusCode;
      } else {
        print("Error adding visit: ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    return responseCode;
  }
}
