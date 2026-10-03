import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://vjxcfhppguforgcaahzk.supabase.co';
const supabaseAnon = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZqeGNmaHBwZ3Vmb3JnY2FhaHprIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc2ODgyMDgsImV4cCI6MjA3MzI2NDIwOH0.5k2dX-FAKE-KEY-REPLACE-IN-SUPABASE';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnon);
  runApp(const UniChatBlue());
}

class UniChatBlue extends StatelessWidget {
  const UniChatBlue({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniChat V5.1 Blue',
      theme: ThemeData(
        primaryColor: const Color(0xFF0A3D8F),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(primary: Color(0xFF0A3D8F), secondary: Color(0xFF00A3FF)),
      ),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});
  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return const LoginScreen();
    return const MainTabs();
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(width: 90, height: 90, decoration: BoxDecoration(color: const Color(0xFF0A3D8F), borderRadius: BorderRadius.circular(24)), child: const Icon(Icons.chat_bubble, color: Colors.white, size: 45)),
            const SizedBox(height: 20),
            const Text('UniChat', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const Text('V5.1 Blue Edition', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A3D8F), minimumSize: const Size(double.infinity, 52), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              onPressed: () async { await Supabase.instance.client.auth.signInWithOAuth(Provider.google); },
              child: const Text('Continue with Gmail', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 12),
            TextButton(onPressed: () async { await Supabase.instance.client.auth.signInAnonymously(); }, child: const Text('Guest Login (Dev)', style: TextStyle(color: Colors.grey))),
          ]),
        ),
      ),
    );
  }
}

class MainTabs extends StatefulWidget {
  const MainTabs({super.key});
  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  int idx = 0;
  final screens = [const ChatTab(), const FeedTab(), const BusinessTab(), const WalletTab(), const UniverseTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[idx],
      bottomNavigationBar: BottomNavigationBar(backgroundColor: Colors.black, selectedItemColor: const Color(0xFF00A3FF), unselectedItemColor: Colors.grey, type: BottomNavigationBarType.fixed, currentIndex: idx, onTap: (i) => setState(() => idx = i), items: const [
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'Chats'),
        BottomNavigationBarItem(icon: Icon(Icons.play_circle), label: 'Feed'),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Business'),
        BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Universe'),
      ]),
    );
  }
}

class ChatTab extends StatelessWidget { const ChatTab({super.key}); @override Widget build(BuildContext context) { return Scaffold(backgroundColor: const Color(0xFF0A3D8F), appBar: AppBar(backgroundColor: const Color(0xFF0A3D8F), title: const Text('Chats')), body: ListView(children: const [ListTile(leading: CircleAvatar(child: Text('G')), title: Text('General Chat', style: TextStyle(color: Colors.white)), subtitle: Text('Manual First Active', style: TextStyle(color: Colors.white70))), ListTile(leading: CircleAvatar(child: Text('P')), title: Text('Prime Twin AI', style: TextStyle(color: Colors.white)), subtitle: Text('Learning your style...', style: TextStyle(color: Colors.white70)))])); } }
class FeedTab extends StatelessWidget { const FeedTab({super.key}); @override Widget build(BuildContext context) { return Scaffold(backgroundColor: Colors.black, body: PageView.builder(scrollDirection: Axis.vertical, itemCount: 3, itemBuilder: (c,i)=>Container(color: Colors.primaries[i], child: Center(child: Text('Feed Video ${i+1} - Watch to Earn', style: const TextStyle(color: Colors.white, fontSize: 22)))))); } }
class BusinessTab extends StatelessWidget { const BusinessTab({super.key}); @override Widget build(BuildContext context) { return Scaffold(backgroundColor: Colors.white, appBar: AppBar(backgroundColor: const Color(0xFF0A3D8F), title: const Text('Business')), body: GridView.builder(padding: const EdgeInsets.all(12), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemCount: 4, itemBuilder: (c,i)=>Card(child: Center(child: Text('Product ${i+1} \n₦15,000'))))); } }
class WalletTab extends StatelessWidget { const WalletTab({super.key}); @override Widget build(BuildContext context) { return Scaffold(backgroundColor: const Color(0xFF0A1030), appBar: AppBar(backgroundColor: const Color(0xFF0A1030), title: const Text('Wallet')), body: const Center(child: Text('Balance: ₦250,450\nUSD: \$320', style: TextStyle(color: Colors.white, fontSize: 22)))); } }
class UniverseTab extends StatelessWidget { const UniverseTab({super.key}); @override Widget build(BuildContext context) { return Scaffold(backgroundColor: Colors.black, appBar: AppBar(backgroundColor: Colors.black, title: const
