# Student Planner App 📚

A Flutter application to help students manage
- Subject attendance
- Weekly class timetable
- Daily class view
- Low attendance alerts

## Features
- Track attendance per subject
- Visual indicators (green ≥75%, red 75%)
- Local notifications when attendance drops below 75%
- Add, edit, and delete timetable entries
- View today's classes sorted by time
- Fully offline (Hive local database)

## Tech Stack
- Flutter
- Hive (local persistence)
- flutter_local_notifications

## Screens
- Attendance Screen
- Today’s Classes Screen
- AddEdit Timetable Screen

## Architecture
- Attendance and Timetable are separate data models
- Reactive UI using `ValueListenableBuilder`
- Clean separation of concerns

## How to Run
```bash
flutter pub get
flutter run
