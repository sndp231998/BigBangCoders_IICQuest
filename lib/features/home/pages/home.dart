import 'package:flutter/material.dart';
import 'package:hackathon/features/collaboration/collaboration.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _onItemTapped(int value) {
    if (value == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Text('ksk')));
    }
    if (value == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Collaboration()));
    }
    if (value == 2) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Collaboration()));
    }
    if (value == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Text('ksk')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('hello'),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book), label: 'Collaboration'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Consult'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
      ),
    );
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {},
    //     child: const Icon(Icons.add),
    //   ),
    //   floatingActionButtonLocation:
    //       FloatingActionButtonLocation.miniCenterFloat,
    // );
  }
}
