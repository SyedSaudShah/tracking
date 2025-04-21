import 'package:tracking/exports/exports.dart';

class ExpenseProvider with ChangeNotifier {
  late Box<Expense> _expenseBox;

  Future<void> init() async {
    _expenseBox = Hive.box<Expense>('expensesBox');
    notifyListeners(); // only if needed
  }

  List<Expense> get expenses => _expenseBox.values.toList();
  double get totalSpending =>
      _expenseBox.values.fold(0, (sum, item) => sum + item.amount);

  void addExpense(Expense expense) {
    _expenseBox.add(expense);
    notifyListeners();
  }

  void removeExpense(Expense expense) async {
    await expense.delete();
    notifyListeners();
  }
}
