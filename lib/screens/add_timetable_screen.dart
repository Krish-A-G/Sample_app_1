import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/timetable_class.dart';

class AddTimetableScreen extends StatefulWidget {
  final TimetableClass? existingClass;

  const AddTimetableScreen({super.key, this.existingClass});

  @override
  State<AddTimetableScreen> createState() =>
      _AddTimetableScreenState();
}

class _AddTimetableScreenState
    extends State<AddTimetableScreen> {
  final _formKey = GlobalKey<FormState>();

  final _subjectController = TextEditingController();
  final _slotController = TextEditingController();
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  final _roomController = TextEditingController();

  int _selectedDay = DateTime.monday;

  @override
  void initState() {
    super.initState();

    // 🔁 Prefill if editing
    final cls = widget.existingClass;
    if (cls != null) {
      _subjectController.text = cls.subjectName;
      _slotController.text = cls.slot;
      _startController.text = cls.startTime;
      _endController.text = cls.endTime;
      _roomController.text = cls.room;
      _selectedDay = cls.day;
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _slotController.dispose();
    _startController.dispose();
    _endController.dispose();
    _roomController.dispose();
    super.dispose();
  }

  void _saveClass() {
    if (!_formKey.currentState!.validate()) return;

    final box = Hive.box<TimetableClass>('timetable');

    if (widget.existingClass == null) {
      // ➕ ADD
      box.add(
        TimetableClass(
          subjectName: _subjectController.text.trim(),
          day: _selectedDay,
          slot: _slotController.text.trim(),
          startTime: _startController.text.trim(),
          endTime: _endController.text.trim(),
          room: _roomController.text.trim(),
        ),
      );
    } else {
      // ✏️ EDIT
      final cls = widget.existingClass!;
      cls
        ..subjectName = _subjectController.text.trim()
        ..day = _selectedDay
        ..slot = _slotController.text.trim()
        ..startTime = _startController.text.trim()
        ..endTime = _endController.text.trim()
        ..room = _roomController.text.trim();
      cls.save();
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingClass != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Class' : 'Add Class'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration:
                const InputDecoration(labelText: 'Subject'),
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<int>(
                value: _selectedDay,
                decoration:
                const InputDecoration(labelText: 'Day'),
                items: const [
                  DropdownMenuItem(
                      value: DateTime.monday,
                      child: Text('Monday')),
                  DropdownMenuItem(
                      value: DateTime.tuesday,
                      child: Text('Tuesday')),
                  DropdownMenuItem(
                      value: DateTime.wednesday,
                      child: Text('Wednesday')),
                  DropdownMenuItem(
                      value: DateTime.thursday,
                      child: Text('Thursday')),
                  DropdownMenuItem(
                      value: DateTime.friday,
                      child: Text('Friday')),
                  DropdownMenuItem(
                      value: DateTime.saturday,
                      child: Text('Saturday')),
                  DropdownMenuItem(
                      value: DateTime.sunday,
                      child: Text('Sunday')),
                ],
                onChanged: (v) =>
                    setState(() => _selectedDay = v!),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _slotController,
                decoration:
                const InputDecoration(labelText: 'Slot'),
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _startController,
                      decoration:
                      const InputDecoration(labelText: 'Start'),
                      validator: (v) =>
                      v == null || v.isEmpty
                          ? 'Required'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _endController,
                      decoration:
                      const InputDecoration(labelText: 'End'),
                      validator: (v) =>
                      v == null || v.isEmpty
                          ? 'Required'
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _roomController,
                decoration:
                const InputDecoration(labelText: 'Room'),
                validator: (v) =>
                v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _saveClass,
                child: Text(isEdit ? 'Save Changes' : 'Add Class'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
