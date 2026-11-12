import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../widgets/empty_state.dart';

/// Layar contoh HTTP GET (/users) dengan state loading/error/data.
class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late Future<List<Map<String, dynamic>>> _future = ApiService().fetchUsers();

  void _retry() => setState(() => _future = ApiService().fetchUsers());

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Data Pengguna (API)')),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snap.hasError) {
              return Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.error_outline, size: 56),
                  const SizedBox(height: 8),
                  Text('${snap.error}'),
                  TextButton(onPressed: _retry, child: const Text('Coba lagi')),
                ]),
              );
            }
            final users = snap.data ?? [];
            if (users.isEmpty) {
              return const EmptyState(
                  message: 'Data kosong', icon: Icons.people_outline);
            }
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, i) => ListTile(
                leading: CircleAvatar(child: Text('${users[i]['id']}')),
                title: Text('${users[i]['name']}'),
                subtitle: Text('${users[i]['email']}'),
              ),
            );
          },
        ),
      );
}
