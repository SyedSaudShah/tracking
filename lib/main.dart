import 'package:tracking/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'exports/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Safe Firebase initialization
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyD4Y...your-real-api-key...",
          appId: "1:1234567890:android:abcd1234efgh5678",
          messagingSenderId: "1234567890",
          projectId: "your-project-id",
        ),
      );
    } else {
      Firebase.app(); // just get the existing instance
    }
  } catch (e) {
    print("Firebase already initialized: $e");
  }

  // Hive init
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  await Hive.openBox<Expense>('expensesBox');

  final provider = ExpenseProvider();
  await provider.init();

  runApp(ChangeNotifierProvider.value(value: provider, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      home: const SignupScreen(),
    );
  }
}
