class Aria2Error {
  final int code;
  final String message;

  const Aria2Error({required this.code, required this.message});

  Aria2Error.fromJson(Map<String, dynamic> json)
    : this(code: json['code'], message: json['message']);

  @override
  String toString() {
    return (StringBuffer('Aria2Error(')
          ..writeAll(['code: $code', 'message: $message'], ', ')
          ..write(')'))
        .toString();
  }
}
