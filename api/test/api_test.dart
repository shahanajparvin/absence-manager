import 'package:api/api.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('every member has key', () {
    ['id', 'name', 'userId', 'image'].forEach((key) {
      test(key, () async {
        List<dynamic>? memberData = await members();
        if(memberData!=null)
        memberData.forEach((member) {
          expect(member.containsKey(key), isTrue);
        });
      });
    });
  });

  group('every absence has key', () {
    [
      'admitterNote',
      'confirmedAt',
      'createdAt',
      'crewId',
      'endDate',
      'id',
      'memberNote',
      'rejectedAt',
      'startDate',
      'type',
      'userId',
    ].forEach((key) {
      test(key, () async {
        List<dynamic>? absenceData = await absences();
        if(absenceData!=null)
        absenceData.forEach((absence) {
          expect(absence.containsKey(key), isTrue);
        });
      });
    });
  });
}
