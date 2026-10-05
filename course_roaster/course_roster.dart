// Part 1
import 'dart:math';

/// @param appName
/// Prints a welcome message.
void printWelcome(String appName) {
  print('=== $appName ===');
}

String generateCode(String title) {
  return title.substring(0, 2).toUpperCase() + '101';
}

void main() {
  printWelcome('Course Roster Manager');
  //Part 2
  const int maxCapacity = 4;
  final DateTime createdAt = DateTime.now(); // this cannot be const because it is determined at runtime
  String courseTitle = 'CS201: Mobile App Development';
  int capacity = maxCapacity;
  double creditHours = 3.0;
  bool isOpen = true;
  List<String> enrolledStudents = ['Aiden', 'Maria', 'Jamal'];
  Set<String> waitlist = {'Priya', 'Noah'};
  Map<String, int> attendanceCount = {'Aiden': 3, 'Maria': 4, 'Jamal': 2};
  print('$courseTitle, $capacity, ${enrolledStudents.length}');

  //Part 3
  String? instructorEmail;
  print(instructorEmail ?? 'TBA');
  late String enrollmentCode;
  enrollmentCode = generateCode(courseTitle);
  print(enrollmentCode);
  // print(instructorEmail!.length);
  print(instructorEmail?.length); //safe version

  //Part 4
  String rawNames = 'Aiden , maria ,JAMAL , Priya';
  List<String> cleanNames = [];
  for (var name in rawNames.split(',')) {
    cleanNames.add(name.trim());
  }
  print(cleanNames);
  String courseDescription =
      '''
        Course: $courseTitle
        Capacity: $capacity
        Enrolled Students: ${enrolledStudents.length}
        Credit Hours: $creditHours
        Instructor: ${instructorEmail ?? 'TBA'}
        Created At: $createdAt
      ''';
  print(courseDescription);
  print('Seats Left: ${capacity - enrolledStudents.length}');

  //Part 5
  int fullGroups = enrolledStudents.length ~/ 3;
  int leftOver = enrolledStudents.length % 3;
  print('Full Groups: $fullGroups');
  print('Left Over: $leftOver');

  Object formInput = 'twenty-two';
  if (formInput is String) {
    print(formInput);
  }
  if (formInput is! int) {
    print('Form input is not an integer.');
  }

  final report = StringBuffer()
    ..write('$courseTitle\n')
    ..write('$capacity\n')
    ..write('${enrolledStudents.length}');
  print(report.toString());

  List<String>? extraNotes;
  extraNotes?.add('Room change pending');
  print(extraNotes);

  int? bonusSeats;
  bonusSeats ??= 0; 
  print(bonusSeats);

  //Part 6
  if(isOpen && enrolledStudents.length < capacity) {
    print('Course is open and has available seats.');
  }
  else{
    print('Course is closed or full.');
  }
  int enrollmentStatusCode=200;
  switch(enrollmentStatusCode){
    case 200:
      print('Enrolled');
      break;
    case 404:
      print('Course not found');
      break;
    default:
      print('Unknown error');
      break;
  }
  String statusTag=isOpen? 'OPEN':'FULL';
  print('$statusTag');

  //Part 7
  for (var roaster in enrolledStudents) {
    print(roaster+'\n');
  }
  attendanceCount.forEach((student, count) {
    print('$student: $count');
  });
  List<String> announcments=[
    'Welcome to $courseTitle',
    if(!isOpen) 'Course is FULL — waitlist open',
    for(var student in waitlist) 'Reminder: $student, please confirm attendance',
  ];
  for (var announcement in announcments) {
    print(announcement);
  }
}
