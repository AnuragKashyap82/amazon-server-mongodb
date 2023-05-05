import 'package:flutter/material.dart';

class AccountButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const AccountButton({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  State<AccountButton> createState() => _AccountButtonState();
}

class _AccountButtonState extends State<AccountButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        width: MediaQuery.of(context).size.width/2 - 20,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.0),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: OutlinedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.black12.withOpacity(0.03),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))
            ),
            onPressed: () {
              widget.onTap;
            },
            child: Text(
              widget.text,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
            )));
  }
}
