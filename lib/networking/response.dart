class Response {
  final int userId;
  final int id;
  final String function;
  final String json;

  Response({this.userId, this.id, this.function, this.json});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      userId: json['userId'],
      id: json['id'],
      function: json['title'],
      json: json['body'],
    );
  }
}
