import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _inputTextController;

  @override
  void initState() {
    super.initState();
    _inputTextController = TextEditingController();
  }

  @override
  void dispose() {
    _inputTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Users')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // input id user
              SizedBox(
                width: 80,
                child: TextField(
                  controller: _inputTextController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: 'id',
                  ),
                  onSubmitted: (_) {
                    _inputTextController.clear();
                  },
                ),
              ),
              const SizedBox(width: 16),

              // get user button
              TextButton(
                onPressed: () {},
                child: const Text('Get User'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
