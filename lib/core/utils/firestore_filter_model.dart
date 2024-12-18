class FirestoreFilter {
  final String field; // Field to filter on
  final dynamic value; // Value to compare
  final String
      operation; // Firestore operation (e.g., '==', '<', 'array-contains')

  FirestoreFilter({
    required this.field,
    required this.value,
    this.operation = '==', // Default to equality
  });
}
