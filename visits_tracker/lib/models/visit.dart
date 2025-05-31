class Visit{
  final int id;
  final int customerId;
  final String visitDate;
  final String status;
  final String customerName;
  final String notes;
  final String location;
  final List<dynamic> activitiesDone;
  final String createdAt;

  Visit({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.visitDate,
    required this.status,
    required this.notes,
    required this.location,
    required this.activitiesDone,
    required this.createdAt,
  });
}