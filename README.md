# solutech-consultancy
Visits Tracker App
Overview
Visits Tracker is a Flutter mobile application designed to help field agents track customer visits. The app allows users to add, view, and filter visits based on their status. Each visit is associated with a customer and includes details such as location, date, status, notes, and activities performed during the visit.

Key Architectural Choices
State Management
Provider Pattern: The app uses the Provider package for state management, with a central AppLogic class that handles all business logic and API calls.
ChangeNotifier: Core state is managed through a ChangeNotifier implementation, enabling components to rebuild efficiently when relevant data changes.


Project Structure
lib/
  ├── main.dart           # App entry point
  ├── models/             # Data models
  │   ├── activity.dart
  │   ├── customer.dart
  │   └── visit.dart
  ├── pages/              # Full-screen UI components
  │   ├── detailPage.dart
  │   └── visits.dart
  ├── provider/           # State management
  │   └── app_logic.dart
  ├── themes/             # App theming
  │   └── theme.dart
  └── widgets/            # Reusable UI components
      ├── filteredList.dart
      ├── filterWidget.dart
      └── visitForm.dart

API Integration
Supabase Backend: The app connects to a Supabase database for storing and retrieving visit data.
HTTP Package: Uses Dart's http package for API calls, with JSON serialization/deserialization.

UI Design
Material Design: Implements Material Design components and follows its guidelines.
Theme Support: Built with theme support, including light and dark modes.

Setup Instructions
Prerequisites
Flutter SDK (3.8.0 or higher)
Dart SDK (3.0.0 or higher)
An IDE (VS Code, Android Studio, etc.)
A connected device or emulator

Usage
The main screen displays a list of visits.
Use the filter chips to filter visits by status.
Tap on a visit to see its details.
Use the FAB (Floating Action Button) to add a new visit.

Assumptions, Trade-offs, and Limitations
Assumptions
Users have internet connectivity to access the Supabase backend.
The app is designed primarily for mobile devices
User authentication will be implemented

Trade-offs
Simplicity vs. Features: Focused on core functionality to keep the codebase clean and maintainable.
Local Filtering: Visits are filtered locally rather than via API calls to reduce network requests.
Single Provider: Used a single provider class to manage all state for simplicity.

Limitations
No offline support - the app requires an internet connection.

