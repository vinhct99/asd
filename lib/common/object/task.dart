import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:taskmanagement/common/object/fieldchangeaction.dart';

part 'task.g.dart';

enum TaskState { init, normal, expired, done, deleted }

String taskStateToString(TaskState state) {
  switch (state) {
    case TaskState.init:
      return 'Khởi tạo';
    case TaskState.normal:
      return 'Thực hiện';
    case TaskState.expired:
      return 'Quá hạn';
    case TaskState.done:
      return 'Hoàn thành';
    case TaskState.deleted:
      return 'Đã xóa';
  }
}

Color taskStatetoColor(TaskState state) {
  switch (state) {
    case TaskState.init:
      return const Color(0xff9999cc);
    case TaskState.normal:
      return const Color.fromARGB(255, 109, 162, 255);
    case TaskState.done:
      return const Color(0xff00bb00);
    case TaskState.expired:
      return const Color(0xffff4444);
    case TaskState.deleted:
      return const Color(0xffcccccc);
  }
}

enum TaskType { undefined, ork, task, subtask }

String taskTypeToString(TaskType type) {
  switch (type) {
    case TaskType.undefined:
      return 'None';
    case TaskType.ork:
      return 'ORK';
    case TaskType.task:
      return 'Task';
    case TaskType.subtask:
      return 'Subtask';
  }
}

/// Mô tả lại đánh giá của một cá nhân đối với công việc (có thể là tự đánh giá hoặc chi huy đánh giá)
@JsonSerializable()
class Evaluation {
  Evaluation();

  /// Người đánh giá
  String author = ' ';

  /// Tiêu chí key đạt được
  String keyResult = '';

  /// Điểm nỗ lực
  double effortScore = 0;

  /// Tính điểm chung
  double score = 0;

  factory Evaluation.fromJson(Map<String, dynamic> json) =>
      _$EvaluationFromJson(json);
  Map<String, dynamic> toJson() => _$EvaluationToJson(this);
}

@JsonSerializable()
class Task {
  Task();

  /// Loại công việc được giao, có thể là một trong số: OKR (milestone), Task, subtask, subtask 2
  TaskType type = TaskType.task;

  /// Được tạo tự động và không trùng trong toàn hệ thống
  String id = '';

  /// Được thêm tự động khi user nhấn vào một OKR hoặc Task nhất định,
  /// chọn “Thêm subtask”, khi đó ID của OKR sẽ trở thành parent ID của subtask.
  /// Đầu mối chỉ huy có thể điều chỉnh Parent ID này thủ công để chuyển subtask
  /// sang OKR khác nếu cần.
  String parentId = '';

  /// Thông tin ID dự án được fixed ở mức Task, subtask, subtask2. Chỉ điền khi
  /// tạo OKR, các task luôn có ID dự án giống hệt parent task.
  /// Trường ID dự án dùng để lọc thông tin & báo cáo.
  String projectId = '';

  /// Sử dụng theo tên email, khi chọn sẽ mở hộp thoại có phép tìm kiếm nhanh
  String assignee = '';

  /// Sử dụng tên theo email (ví dụ: khainv9). Khi tạo việc trường này sẽ được
  /// mặc định là user người nhập (trường hợp là chỉ huy), tuy nhiên vẫn có thể chỉnh sửa
  String author = '';

  /// ID người tạo task
  String creator = '';

  /// Thời gian tạo task
  int timeCreated = 0;

  /// Trường thông tin để lọc & báo cáo. Mặc định sẽ là lĩnh vực của người thực hiện.
  List<String> expertises = [];

  // Nội dung chi tiết của task
  String name = '';

// Mục tiêu của task
  String content = '';

  /// Mục tiêu của task
  String target = '';

  /// Tiêu chí key task cần đạt được
  String keyResult = '';

  /// Số giờ đối với người thực hiện
  int manhour = 0;

  /// Số giờ tiêu chuẩn (đối với nhân sự manhour bậc 13)
  int standardManhour = 0;

  /// Thời gian bắt đầu của task
  int startDate = 0;

  /// Deadline của task
  int dueDate = 0;

  /// Thời gian hoàn thành (time seconds since epocs)
  int timeComplete = 0;

  /// Trạng thái thực hiện của task
  TaskState state = TaskState.init;

  /// Mô tả trạng thái đang hoàn thiện
  String progressDescription = '';

  /// Mô tả trạng thái % đang thực hiện
  double progressPercent = 0;

  /// Mức độ ảnh hưởng của trạng thái đối với dự án & ork
  bool impactEvaluation = false;

  /// Lưu lại kết quả đạt được nếu có
  List<String> resultIds = [];

  /// Đánh giá của mọi người về task
  List<Evaluation> evaluations = [];

  /// Một số trường thông tin bổ sung
  List<String> customFields = [];

  /// Lưu lại các thay đổi
  List<FieldChangeAction> actions = [];

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

List<Task> taskListSample = [
  Task()
    ..id = '1'
    ..projectId = 'VEAC'
    ..name = 'Xây dựng'
    ..assignee = 'bvn12'
    ..author = 'AnhCT20'
    ..state = TaskState.deleted
    ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
    ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
    ..content = 'Xu ly'
    ..progressDescription = 'mo ta'
    ..progressPercent = 1
    ..type = TaskType.subtask
    ..keyResult = 'okla',
  Task()
    ..id = '2'
    ..projectId = 'VELINT18'
    ..name = 'Xây dựng'
    ..assignee = 'Dung12'
    ..author = 'AnhCT20'
    ..state = TaskState.init
    ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
    ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
    ..content = 'Xu ly'
    ..progressDescription = 'mo ta'
    ..progressPercent = 1
    ..type = TaskType.ork
    ..keyResult = 'okla',
  Task()
    ..id = '3'
    ..projectId = 'VEAC'
    ..name = 'Xây dựng adasd'
    ..assignee = 'AnhCT20'
    ..author = 'Minh12'
    ..state = TaskState.expired
    ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
    ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
    ..content = 'Xu ly'
    ..progressDescription = 'mo ta'
    ..progressPercent = 1
    ..type = TaskType.task
    ..keyResult = 'okla',
  Task()
    ..id = '4'
    ..projectId = 'WBHF'
    ..name = 'Xây dựng dasdasd'
    ..assignee = 'Minh12'
    ..author = 'AnhCT20'
    ..state = TaskState.normal
    ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
    ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
    ..content = 'Xu ly'
    ..progressDescription = 'mo ta'
    ..progressPercent = 1
    ..type = TaskType.subtask
    ..keyResult = 'okla',
  Task()
    ..id = '5'
    ..projectId = 'VSM3'
    ..name = 'Xây dựng'
    ..assignee = 'E14'
    ..author = 'Minh12'
    ..state = TaskState.done
    ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
    ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
    ..content = 'Xu ly'
    ..progressDescription = 'mo ta'
    ..progressPercent = 1
    ..type = TaskType.subtask
    ..keyResult = 'okla',
  Task()
    ..id = '6'
    ..projectId = 'VSM3'
    ..name = 'Xây dựng'
    ..assignee = 'Chien21'
    ..author = 'Minh12'
    ..state = TaskState.normal
    ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
    ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
    ..content = 'Xu ly'
    ..progressDescription = 'mo ta'
    ..progressPercent = 1
    ..type = TaskType.task
    ..keyResult = 'okla',
  Task()
    ..id = '7'
    ..projectId = 'WBHF'
    ..name = 'Xây dựng'
    ..assignee = 'KhaiNV9'
    ..author = 'Bach11'
    ..state = TaskState.deleted
    ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
    ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
    ..content = 'Xu ly'
    ..progressDescription = 'mo ta'
    ..progressPercent = 1
    ..type = TaskType.task
    ..keyResult = 'okla',
  Task()
    ..id = '8'
    ..projectId = 'VELINT18'
    ..name = 'Xây dựng'
    ..assignee = 'Bach11'
    ..author = 'KhaiNV9'
    ..state = TaskState.done
    ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
    ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
    ..content = 'Xu ly'
    ..progressDescription = 'mo ta'
    ..progressPercent = 1
    ..type = TaskType.ork
    ..keyResult = 'okla',
  Task()
    ..id = '9'
    ..projectId = 'VEAC'
    ..name = 'Xây dựng'
    ..assignee = 'Minh12'
    ..author = 'KhaiNV9'
    ..state = TaskState.normal
    ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
    ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
    ..content = 'Xu ly'
    ..progressDescription = 'mo ta'
    ..progressPercent = 1
    ..type = TaskType.subtask
    ..state = TaskState.init
    ..keyResult = 'okla',
  Task()
    ..id = '10'
    ..projectId = 'VELINT18'
    ..name = 'Xây dựng'
    ..assignee = 'KhaiNV9'
    ..author = 'Minh12'
    ..state = TaskState.normal
    ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
    ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
    ..content = 'Xu ly'
    ..progressDescription = 'mo ta'
    ..progressPercent = 1
    ..type = TaskType.subtask
    ..state = TaskState.init
    ..keyResult = 'okla',
  Task()
    ..id = '11'
    ..projectId = 'VSM3'
    ..name = 'Xây dựng'
    ..assignee = 'KhaiNV9'
    ..author = 'Minh12'
    ..state = TaskState.normal
    ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
    ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
    ..content = 'Xu ly'
    ..progressDescription = 'mo ta'
    ..progressPercent = 1
    ..type = TaskType.task
    ..state = TaskState.init
    ..keyResult = 'okla',
  Task()
    ..id = '12'
    ..projectId = 'VEAC'
    ..name = 'Xây dựng'
    ..assignee = 'Minh12'
    ..author = 'Chien21'
    ..state = TaskState.normal
    ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
    ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
    ..content = 'Xu ly'
    ..progressDescription = 'mo ta'
    ..progressPercent = 1
    ..type = TaskType.subtask
    ..state = TaskState.init
    ..keyResult = 'okla',
  // Task()
  //   ..id = 'aa'
  //   ..projectId = 'VEAC'
  //   ..name = 'Xây dựng'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.normal
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'Xu ly'
  //   ..progressDescription = 'mo ta'
  //   ..progressPercent = 1
  //   ..type = TaskType.subtask
  //   ..state = TaskState.init
  //   ..keyResult = 'okla',
  // Task()
  //   ..id = 'aa'
  //   ..projectId = 'VEAC'
  //   ..name = 'Xây dựng'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.normal
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'Xu ly'
  //   ..progressDescription = 'mo ta'
  //   ..progressPercent = 1
  //   ..type = TaskType.subtask
  //   ..state = TaskState.init
  //   ..keyResult = 'okla',
  // Task()
  //   ..id = 'aa'
  //   ..projectId = 'VEAC'
  //   ..name = 'Xây dựng'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.normal
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'Xu ly'
  //   ..progressDescription = 'mo ta'
  //   ..progressPercent = 1
  //   ..type = TaskType.subtask
  //   ..state = TaskState.init
  //   ..keyResult = 'okla',

  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng yyy'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.init
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',
  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng zz'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.deleted
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',
  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng aa'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.expired
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',
  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng aa'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.done
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',

  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng aa'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.done
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',

  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng aa'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.done
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',

  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng aa'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.done
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',

  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng aa'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.done
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',

  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng aa'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.done
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',

  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng aa'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.done
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',

  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng aa'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.done
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',

  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng aa'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.done
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',

  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng aa'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.done
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',

  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng aa'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.done
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',

  // Task()
  //   ..projectId = 'VELINT18'
  //   ..name = 'Xây dựng tính năng aa'
  //   ..assignee = 'KhaiNV9'
  //   ..state = TaskState.done
  //   ..startDate = DateTime(2023, 03, 27, 14, 22, 25).millisecondsSinceEpoch
  //   ..dueDate = DateTime(2023, 04, 29, 14, 22, 25).millisecondsSinceEpoch
  //   ..content = 'tesasfasdflkajkshfdlaksjd',
];
