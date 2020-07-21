/// 请求结果
class ResponseEntity{
  /// code
  int code;
  /// result data
  var data;
  /// status message
  String status;


  ResponseEntity({this.code, this.data, this.status});

  ResponseEntity.fromJson(Map<String, dynamic> json, {String dataName}) {
    code = json['code'];
    data = json['data'] != null ? json['data'] : null;
    status = json['status'];
  }

  @override
  String toString() {
    return 'ResponseEntity{code: $code, data: $data, status: $status}';
  }


}
