class Transaction {
  String? title;
  int? amount;
  DateTime? date;
  TransactionType? type;

  Transaction({this.title, this.amount, this.date, this.type});
}

enum TransactionType { retrait, transfert, paiement, depot }
