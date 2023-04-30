import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Owner details',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Owner Details'),
        ),
        body: Center(
          child: QRGenerator(),
        ),
      ),
    );
  }
}

class QRGenerator extends StatefulWidget {
  @override
  _QRGeneratorState createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  final _formKey = GlobalKey<FormState>();
  final _textController1 = TextEditingController();
  final _textController2 = TextEditingController();
  final _textController3 = TextEditingController();
  String _qrData = "";

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    super.dispose();
  }

  void _generateQRCode() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        // Concatenate the three text fields
        _qrData = "${_textController1.text},${_textController2.text},${_textController3.text}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _textController1,
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Enter your name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _textController2,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: 'Phone number',
              hintText: 'Enter your phone number',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
    if (value!.isEmpty) {
      return 'Please enter your phone number';
    } else if (value.length != 10 || !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid 10 digit phone number containing only decimal digits from 0 to 9';
    }
    return null;
  },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _textController3,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email address',
              hintText: 'Enter your email address',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email address';
              } else if (!value.contains('@') || !value.contains('.com')) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: _generateQRCode,
            child: Text('Generate QR Code'),
          ),
          SizedBox(height: 16),
          if (_qrData.isNotEmpty)
            QrImage(
              data: _qrData,
              version: QrVersions.auto,
              size: 200,
            ),
        ],
      ),
    );
  }
}
