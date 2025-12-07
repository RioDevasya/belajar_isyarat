import 'package:belajar_isyarat/entitas/profil/e_log_detail.dart';

class ELog {
  List<ELogDetail> list;

  ELog({required this.list});

  factory ELog.fromJson(List<dynamic> jsonList) {
    return ELog(
      list: jsonList.map((e) => ELogDetail.fromJson(e)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return list.map((e) => e.toJson()).toList();
  }
}