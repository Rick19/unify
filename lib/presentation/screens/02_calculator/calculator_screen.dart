import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:unify/presentation/utils.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<CalculatorScreen> {
  final TextEditingController _billController = TextEditingController();
  double _tipPercentage = 0.15; // 15% por defecto
  double tip = 0.0; //  Inicializado

  void _showResultDialog(double total) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Total').animate().fadeIn(duration: 300.ms).slideY(),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider().animate().fadeIn(delay: 100.ms, duration: 300.ms),
            SizedBox(height: 20).animate().scale(delay: 150.ms),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ).animate().flip(delay: 200.ms),
            SizedBox(height: 20),
            Divider().animate().fadeIn(delay: 250.ms, duration: 300.ms),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cuenta: ').animate().fadeIn(delay: 300.ms),
                Text(
                  '\$${_billController.text}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ).animate().fadeIn(delay: 350.ms),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Propina [${(_tipPercentage * 100).toStringAsFixed(0)}%]:')
                    .animate()
                    .fadeIn(delay: 400.ms),
                Text(
                  '\$${tip.toStringAsFixed(1)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ).animate().fadeIn(delay: 450.ms),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Aceptar'),
          ).animate().fadeIn(delay: 500.ms),
        ],
      ).animate().scale(duration: 300.ms, curve: Curves.easeOut);
    },
  );
}

  void _calculateTip() {
    double bill = double.tryParse(_billController.text) ?? 0.0;
    tip = bill * _tipPercentage;
    double total = bill + tip;

    _showResultDialog(total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Propinas'),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Espaciado entre widgets
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _billController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Total de la cuenta',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            SleekCircularSlider(
              initialValue: _tipPercentage * 100,
              min: 0,
              max: 100,
              appearance: CircularSliderAppearance(
                size: 350,
                angleRange: 270,
                startAngle: 135,
                customWidths: CustomSliderWidths(
                  trackWidth: 4,
                  progressBarWidth: 10,
                  handlerSize: 16,
                ),
                customColors: CustomSliderColors(
                  trackColor: Colors.grey[400]!, //  Listado desde utils
                  progressBarColors: trackColors,
                  dotColor: Colors.blueAccent,
                ),
                infoProperties: InfoProperties(
                  modifier: (value) => '${value.toStringAsFixed(0)}%',
                  mainLabelStyle: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onChange: (value) {
                setState(() {
                  _tipPercentage = value / 100;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateTip,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }
}
