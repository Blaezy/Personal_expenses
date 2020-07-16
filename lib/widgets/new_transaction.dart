import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function newTx;
  NewTransactions(this.newTx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final amountController = TextEditingController();
  final textController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    if (amountController.text == null) {
      return;
    }
    final submittedTitle = textController.text;
    final submittedAmount = double.parse(amountController.text);

    if (submittedTitle.isEmpty || submittedAmount <= 0 || selectedDate == null)
      return;
    widget.newTx(submittedTitle, submittedAmount, selectedDate);

    Navigator.of(context).pop();
  }

  void presentdate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
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
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(selectedDate == null
                        ? 'No Date Chosen!!!!'
                        : 'Picked Date :${DateFormat.yMd().format(selectedDate)}'),
                  ),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: presentdate,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            RaisedButton(
              onPressed: submitData,
              child: Text("Add transaction"),
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
