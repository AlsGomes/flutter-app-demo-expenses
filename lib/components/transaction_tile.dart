import 'package:expenses/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final void Function(String) removeTransaction;

  const TransactionTile({
    required this.transaction,
    required this.mediaQuery,
    required this.removeTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
                child: Text(
              'R\$ ${transaction.value.toStringAsFixed(2)}',
            )),
          ),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(DateFormat("d MMM y").format(transaction.date)),
        trailing: mediaQuery.size.width > 480
            ? FlatButton.icon(
                onPressed: () => removeTransaction(transaction.id),
                icon: const Icon(Icons.delete),
                label: const Text("Excluir"),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                onPressed: () => removeTransaction(transaction.id),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
