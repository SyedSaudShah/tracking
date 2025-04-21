import 'exports/exports.dart';

class ExpenseHomePage extends StatefulWidget {
  const ExpenseHomePage({super.key});

  @override
  State<ExpenseHomePage> createState() => _ExpenseHomePageState();
}

class _ExpenseHomePageState extends State<ExpenseHomePage> {
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? _selectedCategory;

  final List<String> _categories = [
    'Food',
    'Transport',
    'Shopping',
    'Bills',
    'Entertainment',
    'Health',
    'Education',
    'Travel',
    'Groceries',
    'Subscriptions',
    'Gifts',
    'Insurance',
    'Investment',
    'Savings',
    'Others',
  ];

  final Map<String, IconData> _categoryIcons = {
    'Food': Icons.fastfood,
    'Transport': Icons.directions_car,
    'Shopping': Icons.shopping_bag,
    'Bills': Icons.receipt_long,
    'Entertainment': Icons.movie,
    'Health': Icons.healing,
    'Education': Icons.school,
    'Travel': Icons.flight_takeoff,
    'Groceries': Icons.local_grocery_store,
    'Subscriptions': Icons.subscriptions,
    'Gifts': Icons.card_giftcard,
    'Insurance': Icons.shield,
    'Investment': Icons.trending_up,
    'Savings': Icons.savings,
    'Others': Icons.more_horiz,
  };

  void _addExpense(ExpenseProvider provider) {
    final amount = double.tryParse(_amountController.text);
    if (amount != null && _selectedCategory != null) {
      provider.addExpense(
        Expense(
          amount: amount,
          category: _selectedCategory!,
          date: _selectedDate,
        ),
      );
      _amountController.clear();
      setState(() {
        _selectedCategory = null;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.teal,
              surface: Color(0xFF1E1E1E),
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: const Color(0xFF2D2D2D),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text('💰 Expense Tracker'),
        backgroundColor: Colors.teal[900],
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.07,
            vertical: 24.0,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1B1F32), Color(0xFF1E2A38)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.tealAccent.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Spending',
                      style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Rs. ${provider.totalSpending.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.tealAccent,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF1A1A1A),
                        labelText: 'Amount',
                        labelStyle: const TextStyle(color: Colors.tealAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      dropdownColor: Colors.grey[900],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF1A1A1A),
                        labelText: 'Category',
                        labelStyle: const TextStyle(color: Colors.tealAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      iconEnabledColor: Colors.tealAccent,
                      style: const TextStyle(color: Colors.white),
                      items:
                          _categories.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Row(
                                children: [
                                  Icon(
                                    _categoryIcons[category],
                                    color: Colors.tealAccent,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(category),
                                ],
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date: ${_selectedDate.toString().split(' ')[0]}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () => _selectDate(context),
                          child: const Text(
                            'Pick Date',
                            style: TextStyle(color: Colors.tealAccent),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () => _addExpense(provider),
                        icon: const Icon(Icons.add),
                        label: const Text('Add Expense'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.tealAccent[700],
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 14.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: min(provider.expenses.length, 50),
                itemBuilder: (context, index) {
                  final expense = provider.expenses[index];
                  return Card(
                    color: const Color(0xFF181818),
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        // ignore: duplicate_ignore
                        // ignore: deprecated_member_use
                        backgroundColor: Colors.tealAccent.withOpacity(0.1),
                        child: Icon(
                          _categoryIcons[expense.category] ?? Icons.category,
                          color: Colors.tealAccent,
                        ),
                      ),
                      title: Text(
                        expense.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        expense.date.toString().split(' ')[0],
                        style: const TextStyle(color: Colors.white60),
                      ),
                      trailing: SizedBox(
                        width: 90,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Rs ${expense.amount.toStringAsFixed(2)}',

                              style: const TextStyle(
                                color: Colors.tealAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                                onPressed: () {
                                  provider.removeExpense(expense);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
