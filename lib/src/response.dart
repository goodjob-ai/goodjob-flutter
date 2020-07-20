class ResponseEntity{
  int code;
  var data;
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
