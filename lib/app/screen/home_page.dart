import 'package:flutter/material.dart';

import '../entity/user.dart';
import '../repository/user_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _inputTextController;

  // state
  bool _loading = false;
  User? _user;
  String? _error;

  @override
  void initState() {
    super.initState();
    _inputTextController = TextEditingController();
    _user = null;
    _error = null;
  }

  @override
  void dispose() {
    _inputTextController.dispose();
    super.dispose();
  }

  Future<void> _getUser(BuildContext ctx) async {
    setState(() => _loading = true);
    try {
      var user = await UserRepository()
          .getUser(int.tryParse(_inputTextController.text) ?? 0);
      _user = user;
      _error = null;
      setState(() {});
    } catch (e) {
      _loading = false;
      _error = e.toString();
      _user = null;
      setState(() {});
    } finally {
      _loading = false;
      _inputTextController.clear();
      if (ctx.mounted) FocusScope.of(ctx).unfocus();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Users')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // display user
          _loading
              ? const CircularProgressIndicator()
              : _user != null
                  ? Text('User: ${_user?.name ?? 'No Name'}')
                  : _error != null
                      ? Text('error: $_error', textAlign: TextAlign.center)
                      : const Text('No Data'),

          const SizedBox(height: 16),

          // input action
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
                    hintText: 'Input ID',
                  ),
                  onSubmitted: (_) async => await _getUser(context),
                ),
              ),
              const SizedBox(width: 16),

              // get user button
              TextButton(
                onPressed: () async => await _getUser(context),
                child: const Text('Get User'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
