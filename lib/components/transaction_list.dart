// ignore_for_file: prefer_const_constructors

import 'package:expenses/components/transaction_tile.dart';
import 'package:expenses/model/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) removeTransaction;

  const TransactionList(this.transactions, this.removeTransaction);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.1,
                    child: Text(
                      "Nenhuma transação cadastrada",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Container(
                    height: constraints.maxHeight * 0.8,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final t = transactions[index];
              return TransactionTile(
                transaction: t,
                mediaQuery: mediaQuery,
                removeTransaction: removeTransaction,
              );
            },
          );
  }
}
