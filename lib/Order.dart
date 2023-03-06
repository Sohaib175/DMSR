class Order {
  String id;
  String paymentstatus;
  String status;
  int total;
  int table;
  bool isWillingtoPay;

  Order({
    required this.id,
    required this.paymentstatus,
    required this.status,
    required this.table,
    required this.total,
    required this.isWillingtoPay,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'paymentstatus': paymentstatus,
        'status': status,
        'table': table,
        'total': total,
        'isWillingtoPay': isWillingtoPay,
      };

  static Order fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        paymentstatus: json['paymentstatus'],
        status: json['status'],
        table: json['table'],
        total: json['total'],
        isWillingtoPay: json['isWillingtoPay'],
      );
}
