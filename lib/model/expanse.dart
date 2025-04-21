import 'package:tracking/exports/exports.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  double amount;

  @HiveField(1)
  String category;

  @HiveField(2)
  DateTime date;

  Expense({required this.amount, required this.category, required this.date});
}

// ExpenseAdapter is automatically generated when you run the build_runner
// Manually adding it here just in case, but typically not needed
class ExpenseAdapter extends TypeAdapter<Expense> {
  @override
  final int typeId = 0;

  @override
  Expense read(BinaryReader reader) {
    return Expense(
      amount: reader.readDouble(),
      category: reader.readString(),
      date: DateTime.fromMillisecondsSinceEpoch(
        reader.readInt(),
      ), // Convert from milliseconds
    );
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer.writeDouble(obj.amount);
    writer.writeString(obj.category);
    writer.writeInt(obj.date.millisecondsSinceEpoch); // Store as milliseconds
  }
}
