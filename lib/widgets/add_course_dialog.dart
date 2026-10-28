import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';
import '../providers/course_provider.dart';

class AddCourseDialog extends StatefulWidget {
  const AddCourseDialog({super.key});

  @override
  State<AddCourseDialog> createState() => _AddCourseDialogState();
}

class _AddCourseDialogState extends State<AddCourseDialog> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _titleController = TextEditingController();
  final _creditsController = TextEditingController();
  String _selectedStatus = 'planned';

  @override
  void dispose() {
    _codeController.dispose();
    _titleController.dispose();
    _creditsController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    // Simpan referensi Navigator dan ScaffoldMessenger sebelum async gap
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final provider = context.read<CourseProvider>();
    final newCourse = Course(
      code: _codeController.text.trim(),
      title: _titleController.text.trim(),
      credits: int.parse(_creditsController.text.trim()),
      status: _selectedStatus,
    );

    final success = await provider.createCourse(newCourse);

    // Guard wajib: Periksa mounted setelah await
    if (!mounted) return;

    if (success) {
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Mata kuliah berhasil ditambahkan (HTTP 201 Created)!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(provider.error ?? 'Gagal menambah data'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return AlertDialog(
      title: const Text('Tambah Course Baru'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Kode Course (misal: MOB099)',
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Kode wajib diisi' : null,
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul Course'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Judul wajib diisi' : null,
              ),
              TextFormField(
                controller: _creditsController,
                decoration: const InputDecoration(labelText: 'SKS/Credits'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'SKS wajib diisi';
                  if (int.tryParse(val) == null) {
                    return 'SKS harus berupa angka';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(labelText: 'Status'),
                items: const [
                  DropdownMenuItem(value: 'planned', child: Text('Planned')),
                  DropdownMenuItem(value: 'active', child: Text('Active')),
                  DropdownMenuItem(value: 'done', child: Text('Done')),
                ],
                onChanged: (val) {
                  if (val != null) setState(() => _selectedStatus = val);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: provider.isSaving ? null : () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: provider.isSaving ? null : _submitForm,
          child: provider.isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Simpan'),
        ),
      ],
    );
  }
}
