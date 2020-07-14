import 'package:flutter/material.dart';

class NewTransactions extends StatefulWidget {
  final Function newTx;
  NewTransactions(this.newTx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final amountController = TextEditingController();

  final textController = TextEditingController();

  void submitData() {
    final submittedTitle = textController.text;
    final submittedAmount = double.parse(amountController.text);

    if (submittedTitle.isEmpty || submittedAmount <= 0) return;
    widget.newTx(submittedTitle, submittedAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: textController,
              onSubmitted: (_) => submitData,
              // onChanged: (val) {
              // titleInput = val;
              //},
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount "),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
              //onChanged: (val) {
              // amountInput = val;
              //}
            ),
            FlatButton(
              onPressed: submitData,
              child: Text("Add transaction"),
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
