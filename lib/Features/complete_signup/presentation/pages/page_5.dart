import 'package:chronos/Features/complete_signup/presentation/pages/page_6.dart';
import 'package:flutter/material.dart';

import '../../../home/presentation/pages/home.dart';

class CreatePinPage extends StatefulWidget {
  @override
  _CreatePinPageState createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  final List<int> _pin = [];

  void _addDigit(int digit) {
    if (_pin.length < 4) {
      setState(() => _pin.add(digit));
      if (_pin.length == 4) {
        final newPin = _pin.join();
        Future.delayed(Duration(milliseconds: 300), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ConfirmPinPage(originalPin: newPin),
            ),
          );
        });
      }
    }
  }

  void _deleteDigit() {
    if (_pin.isNotEmpty) {
      setState(() => _pin.removeLast());
    }
  }

  Widget _buildPinBox(int index) {
    final isFilled = index < _pin.length;
    final isActive = index == _pin.length;
    return Container(
      width: 60,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: isActive ? Colors.blue : Colors.grey.shade400,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: isFilled ? Icon(Icons.circle, size: 16) : SizedBox.shrink(),
    );
  }

  Widget _buildKey(String number, String letters) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(48),
        onTap: () => _addDigit(int.parse(number)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(number, style: TextStyle(fontSize: 28)),
              if (letters.isNotEmpty) SizedBox(height: 4),
              if (letters.isNotEmpty)
                Text(letters, style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackspace() {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(48),
        onTap: _deleteDigit,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Icon(
            Icons.backspace_outlined,
            size: 28,
            color: _pin.isEmpty ? Colors.grey.shade300 : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 32),
            Text('Create PIN',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Type your new 4-digit PIN',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, _buildPinBox),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Row(children: [
                    _buildKey('1', ''),
                    _buildKey('2', 'ABC'),
                    _buildKey('3', 'DEF'),
                  ]),
                  Row(children: [
                    _buildKey('4', 'GHI'),
                    _buildKey('5', 'JKL'),
                    _buildKey('6', 'MNO'),
                  ]),
                  Row(children: [
                    _buildKey('7', 'PQRS'),
                    _buildKey('8', 'TUV'),
                    _buildKey('9', 'WXYZ'),
                  ]),
                  Row(children: [
                    Expanded(child: SizedBox()),
                    _buildKey('0', ''),
                    _buildBackspace(),
                  ]),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ConfirmPinPage extends StatefulWidget {
  final String originalPin;
  ConfirmPinPage({required this.originalPin});

  @override
  _ConfirmPinPageState createState() => _ConfirmPinPageState();
}

class _ConfirmPinPageState extends State<ConfirmPinPage>
    with SingleTickerProviderStateMixin {
  final List<int> _pin = [];
  bool _isError = false;
  bool _isSuccess = false;

  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() {
      setState(() {});
    })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => ConfirmDeliveryAddressPage()),
          );
        }
      });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _addDigit(int digit) {
    if (_isError) setState(() => _isError = false);
    if (_pin.length < 4 && !_isSuccess) {
      setState(() => _pin.add(digit));
      if (_pin.length == 4) {
        _validatePin();
      }
    }
  }

  void _deleteDigit() {
    if (_pin.isNotEmpty && !_isSuccess) {
      setState(() => _pin.removeLast());
    }
  }

  void _validatePin() {
    final entered = _pin.join();
    if (entered == widget.originalPin) {
      setState(() => _isSuccess = true);
      _animController.forward();
    } else {
      setState(() {
        _isError = true;
        _pin.clear();
      });
    }
  }

  Widget _buildPinBox(int index) {
    // Determine border/icon color
    Color borderColor;
    if (_isError) {
      borderColor = Colors.red;
    } else if (_isSuccess) {
      // animate threshold by box index
      final threshold = (index + 1) / 4.0;
      borderColor =
      (_animController.value >= threshold) ? Colors.green : Colors.grey.shade400;
    } else {
      borderColor = index == _pin.length
          ? Colors.blue
          : Colors.grey.shade400;
    }

    final isFilled = index < _pin.length;

    return Container(
      width: 60,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: isFilled
          ? Icon(Icons.circle, size: 16, color: borderColor)
          : null,
    );
  }

  Widget _buildKey(String number, String letters) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(48),
        onTap: () => _addDigit(int.parse(number)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(number, style: TextStyle(fontSize: 28)),
              if (letters.isNotEmpty) SizedBox(height: 4),
              if (letters.isNotEmpty)
                Text(letters, style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackspace() {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(48),
        onTap: _deleteDigit,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Icon(
            Icons.backspace_outlined,
            size: 28,
            color: _pin.isEmpty ? Colors.grey.shade300 : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 32),
            Text(
              'Confirm PIN',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Re-enter your PIN to confirm',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, _buildPinBox),
            ),
            if (_isError) ...[
              SizedBox(height: 12),
              Text(
                'PIN codes do not match',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Row(children: [
                    _buildKey('1', ''),
                    _buildKey('2', 'ABC'),
                    _buildKey('3', 'DEF'),
                  ]),
                  Row(children: [
                    _buildKey('4', 'GHI'),
                    _buildKey('5', 'JKL'),
                    _buildKey('6', 'MNO'),
                  ]),
                  Row(children: [
                    _buildKey('7', 'PQRS'),
                    _buildKey('8', 'TUV'),
                    _buildKey('9', 'WXYZ'),
                  ]),
                  Row(children: [
                    Expanded(child: SizedBox()),
                    _buildKey('0', ''),
                    _buildBackspace(),
                  ]),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
