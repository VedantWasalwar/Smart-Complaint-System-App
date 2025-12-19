import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddComplaint extends StatefulWidget {
  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  bool isSubmitting = false;

  Future<void> submitComplaint() async {
    if (titleController.text.isEmpty || descController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Title and description required")));
      return;
    }

    setState(() => isSubmitting = true);

    final success = await ApiService.addComplaint({
      "title": titleController.text,
      "description": descController.text,
      "status": "pending", // 🔥 Always pending initially
    });

    setState(() => isSubmitting = false);

    if (success) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to submit complaint")));
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Complaint")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSubmitting ? null : submitComplaint,
                child: isSubmitting
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
