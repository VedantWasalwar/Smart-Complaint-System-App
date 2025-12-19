import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'add_complaint.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List complaints = [];
  bool isLoading = false;

  // =========================
  // LOAD COMPLAINTS FROM API
  // =========================
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
      complaints = []; // 🔥 CLEAR OLD DATA (IMPORTANT FIX)
    });

    try {
      final data = await ApiService.getComplaints();
      setState(() {
        complaints = data; // ✅ always fresh backend data
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        complaints = []; // 🔥 ensure no stale data
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to load complaints. Backend may be waking up."),
        ),
      );
    }
  }

  // =========================
  // RESOLVE COMPLAINT
  // =========================
  Future<void> resolveComplaint(int id) async {
    final success = await ApiService.updateStatus(id, 'resolved');
    if (success) {
      await loadData(); // 🔥 reload list after update
    }
  }

  @override
  void initState() {
    super.initState();
    loadData(); // 🔥 always load from backend
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case "resolved":
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  Icon statusIcon(String status) {
    return Icon(
      status.toLowerCase() == "resolved"
          ? Icons.check_circle
          : Icons.hourglass_top,
      color: statusColor(status),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complaints Dashboard")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddComplaint()),
          );
          if (result == true) {
            await loadData(); // 🔥 refresh after add
          }
        },
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : complaints.isEmpty
              ? const Center(child: Text("No complaints found"))
              : RefreshIndicator(
                  onRefresh: loadData,
                  child: ListView.builder(
                    itemCount: complaints.length,
                    itemBuilder: (context, index) {
                      final complaint = complaints[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading:
                              statusIcon(complaint['status'] ?? "pending"),
                          title: Text(
                            complaint['title'] ?? "No Title",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            complaint['description'] ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: complaint['status'] == "pending"
                              ? ElevatedButton(
                                  onPressed: () {
                                    resolveComplaint(complaint['id']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 227, 11, 7),
                                  ),
                                  child: const Text("pending"),
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
