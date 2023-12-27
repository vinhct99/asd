import 'package:json_annotation/json_annotation.dart';
import 'package:taskmanagement/common/object/fieldchangeaction.dart';

part 'user.g.dart';

/// Trạng thái của một nhân sự
enum UserState { intern, normal, quit, outsource }

extension UserStateExt on UserState {
  String toDisplay() {
    switch (this) {
      case UserState.intern:
        return "Thực tập";
      case UserState.normal:
        return "Chính thức";
      case UserState.quit:
        return "Đã nghỉ việc";
      case UserState.outsource:
        return "Nhân sự outsource";
    }
  }
}

enum JobPosition { staff, leader, director, pa, admin }

extension JobPositionExt on JobPosition {
  bool isAdmin() {
    return this == JobPosition.admin || this == JobPosition.director;
  }
}

/// Thông tin nhân sự
@JsonSerializable()
class User {
  User();

  /// ID email của nhân sự, ví dụ: khainv9
  String id = '';

  /// Tên đầy đủ của nhân sự
  String name = '';

  //
  String description = '';

  /// Mã nhân viên
  int number = 0;

  /// Ngày vào tập đoàn
  int timeJoin = 0;

  /// Tên chức vụ (theo cập nhật từ TTNS)
  String jobTitle = '';

  /// Nhóm mà nhân sự đang tham gia
  String teamId = '';

  /// Vị trí: nhân viên, PA, trưởng nhóm, BGĐ
  JobPosition position = JobPosition.staff;

  /// Các project nhân sự đang làm PM
  List<String> projectOwnList = [];

  /// Trạng thái
  UserState state = UserState.normal;

  /// Một số trường thông tin bổ sung
  List<String> customFields = [];

  /// Lưu vết lại các thay đổi
  List<FieldChangeAction> actions = [];

  /// Sử dụng thư viện json anotation để tạo json
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Sử dụng thư viện json anotation để tạo json
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Chữ hiển thị tương ứng với các trường
  static Map<String, String> fieldNameToTextMap() {
    return {
      'id': 'Email',
      'name': 'Tên',
      'number': 'Mã nhân viên',
      'timeJoin': 'Thời gian ',
      'jobTitle': 'Chức danh',
      'position': 'Vai trò trên trang',
      'projectOwnList': 'PM',
      'state': 'Trạng thái',
      'customFields': '',
      'actions': 'Lịch sử ',
    };
  }
}

final myUserSample = User()
  ..id = 'KhaiNV9'
  ..name = 'Nguyễn Văn Khải'
  ..jobTitle = 'Kỹ sư phần mềm nhúng'
  ..position = JobPosition.admin
  ..teamId = 'pmpc';

final userSampleList = {
  '1': User()
    ..id = 'KhaiNV9'
    ..number = 219643
    ..name = 'Nguyễn Văn Khải'
    ..jobTitle = 'Kỹ sư phần mềm nhúng',
  '2': User()
    ..id = 'AnhCT20'
    ..number = 2123
    ..name = 'Cấn Tuấn Anh'
    ..jobTitle = 'Kỹ sư phần mềm nhúng',
  '3': User()
    ..id = 'Dung12'
    ..number = 219643
    ..name = 'Hoang Van Dung'
    ..jobTitle = 'Kỹ sư phần mềm nhúng',
  '4': User()
    ..id = 'Minh12'
    ..number = 2321
    ..name = 'Nguyễn Binh Minh'
    ..jobTitle = 'Kỹ sư phần mềm nhúng',
  '5': User()
    ..id = 'E14'
    ..number = 5132
    ..name = 'Nguyễn Văn E'
    ..jobTitle = 'Kỹ sư phần mềm nhúng',
  '6': User()
    ..id = 'Chien21'
    ..number = 4232
    ..name = 'Nguyễn Văn Chien'
    ..jobTitle = 'Kỹ sư phần mềm nhúng',
  '7': User()
    ..id = 'Bach11'
    ..number = 23423
    ..name = 'Ngo Quang Bach'
    ..jobTitle = 'Kỹ sư phần mềm nhúng',
};
