import 'package:flutter/material.dart';

void main() => runApp(PasswordComparisonApp());

class PasswordComparisonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Password Comparison')),
        body: PassComparisonScreen(),
      ),
    );
  }
}

class PassComparisonScreen extends StatefulWidget {
  @override
  _PassComparisonScreenState createState() => _PassComparisonScreenState();
}

class _PassComparisonScreenState extends State<PassComparisonScreen> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _secondController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 50,),
          TextField(
            controller: _firstController,
            decoration: InputDecoration(
              labelText: 'Enter Your Password',
              hintText: 'Password',
              prefixIcon: Icon(Icons.edit, color: Colors.deepPurple),
              suffixIcon: _firstController.text.isNotEmpty
                  ? IconButton(
                icon: Icon(Icons.add_circle_outline, color: Colors.deepPurple),
                onPressed: () {
                  _firstController.clear();
                  setState(() {});
                },
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.purple, width: 3.0),
              ),
              filled: true,
              fillColor: Colors.deepPurple.withOpacity(0.1),
              contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              labelStyle: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.topLeft,
            child: RichText(
              text: TextSpan(
                children: _getColoredTextSpans(
                  _firstController.text,
                  _secondController.text,
                ),
                style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: _secondController,
            decoration: InputDecoration(
              labelText: 'Reenter Your Password',
              hintText: 'Reenter Password',
              prefixIcon: Icon(Icons.edit, color: Colors.deepPurple),
              suffixIcon: _secondController.text.isNotEmpty
                  ? IconButton(
                icon: Icon(Icons.clear, color: Colors.deepPurple),
                onPressed: () {
                  _secondController.clear();
                  setState(() {});
                },
              )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.purple, width: 3.0),
              ),
              filled: true,
              fillColor: Colors.deepPurple.withOpacity(0.1),
              contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              labelStyle: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
            maxLines: null, // Allow multi-line input
            style: TextStyle(color: Colors.deepPurple),
            cursorColor: Colors.black,
            showCursor: true,
            autofocus: true,
            // Hides actual text to only show colored version in RichText above
          ),
        ],
      ),
    );
  }

  List<TextSpan> _getColoredTextSpans(String firstText, String secondText) {
    List<TextSpan> spans = [];
    int minLength = firstText.length < secondText.length
        ? firstText.length
        : secondText.length;

    // Compare each character and colorize
    for (int i = 0; i < secondText.length; i++) {
      Color color;
      if (i < minLength && firstText[i] == secondText[i]) {
        color = Colors.green; // Characters match
      } else if (i < firstText.length) {
        color = Colors.red; // Mismatch
      } else {
        color = Colors.black; // Extra characters in second text
      }
      spans.add(TextSpan(
        text: secondText[i],
        style: TextStyle(color: color),
      ));
    }

    return spans;
  }
}
