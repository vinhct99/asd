

String toNonAccentVietnamese(String text){
  final sb = StringBuffer();
  for (var element in text.runes) {
    final c = String.fromCharCode(element);
    if ('àáạảãâầấậẩẫăằắặẳẵ'.contains(c)){
      sb.write('a');
    } else if ('AÁÀÃẠÂẤẦẪẬĂẮẰẴẶ'.contains(c)) {
      sb.write('A');
    } else if ('EÉÈẼẸÊẾỀỄỆ'.contains(c)) {
      sb.write('E');
    } else if ('èéẹẻẽêềếệểễ'.contains(c)) {
      sb.write('e');
    } else if ('IÍÌĨỊ'.contains(c)) {
      sb.write('I');
    } else if ('ìíịỉĩ'.contains(c)) {
      sb.write('i');
    } else if ('OÓÒÕỌÔỐỒỖỘƠỚỜỠỢ'.contains(c)) {
      sb.write('O');
    } else if ('òóọỏõôồốộổỗơờớợởỡ'.contains(c)) {
      sb.write('o');
    } else if ('UÚÙŨỤƯỨỪỮỰ'.contains(c)) {
      sb.write('U');
    } else if ('ùúụủũưừứựửữ'.contains(c)) {
      sb.write('u');
    } else if ('YÝỲỸỴ'.contains(c)) {
      sb.write('Y');
    } else if ('ỳýỵỷỹ'.contains(c)) {
      sb.write('y');
    } else if ('Đ'.contains(c)) {
      sb.write('D');
    } else if ('đ'.contains(c)){
      sb.write('d');
    } else {
      sb.write(c);
    }
  } 
  return sb.toString();
}

String toLowerCaseNonAccentVietnamese(String text) {
  final sb = StringBuffer();
  for (var element in text.runes) {
    final c = String.fromCharCode(element);
    if ('àáạảãâầấậẩẫăằắặẳẵAÁÀÃẠÂẤẦẪẬĂẮẰẴẶ'.contains(c)) {
      sb.write('a');
    } else if ('EÉÈẼẸÊẾỀỄỆèéẹẻẽêềếệểễ'.contains(c)) {
      sb.write('e');
    } else if ('IÍÌĨỊìíịỉĩ'.contains(c)) {
      sb.write('i');
    } else if ('OÓÒÕỌÔỐỒỖỘƠỚỜỠỢòóọỏõôồốộổỗơờớợởỡ'.contains(c)) {
      sb.write('o');
    } else if ('UÚÙŨỤƯỨỪỮỰùúụủũưừứựửữ'.contains(c)) {
      sb.write('u');
    } else if ('YÝỲỸỴỳýỵỷỹ'.contains(c)) {
      sb.write('y');
    } else if ('Đđ'.contains(c)) {
      sb.write('d');
    } else {
      sb.write(c.toLowerCase());
    }
  }
  return sb.toString();
}
