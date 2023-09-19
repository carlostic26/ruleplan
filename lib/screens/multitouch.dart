import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';
import 'dart:math';

class MultiTouch extends StatefulWidget {
  const MultiTouch({Key? key}) : super(key: key);

  @override
  _MultiTouchState createState() => _MultiTouchState();
}

class _MultiTouchState extends State<MultiTouch> {
  final Map<int, Offset> _touches = {};
  final Map<int, Color> _colors = {};
  int _contador = 5;
  bool _iniciado = false;

  void _iniciarContador() {
    setState(() {
      _iniciado = true;
      _contador = 5;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_contador > 0) {
        setState(() {
          _contador--;
        });
      } else {
        timer.cancel();
        setState(() {
          _iniciado = false;
          _elegirToque(); // elegir un toque al azar y cambiarle el color
        });
      }
    });
  }

  void _reset() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MultiTouch()),
    );
  }

  void _elegirToque() {
    if (_touches.isNotEmpty) {
      // obtener una lista de los identificadores de los toques
      List<int> keys = _touches.keys.toList();
      // elegir un índice al azar de la lista
      int index = Random().nextInt(keys.length);
      // obtener el identificador del toque elegido
      int key = keys[index];
      // cambiar el color del toque elegido a blanco
      setState(() {
        _colors[key] = Colors.white;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: !_iniciado ? _iniciarContador : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber, // color de fondo
                    onPrimary: Colors.black, // color del texto
                  ),
                  child: const Text('Play'),
                ),
                SizedBox(width: 5),
                FloatingActionButton.small(
                  onPressed: _reset,
                  child: const Icon(Icons.refresh),
                  backgroundColor: Colors.amber, // color de fondo
                  foregroundColor: Colors.black, // color del ícono
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (PointerDownEvent event) {
              setState(() {
                _touches[event.pointer] = event.position -
                    Offset(0, MediaQuery.of(context).padding.top + 40);
              });
            },
            onPointerMove: (PointerMoveEvent event) {
              setState(() {
                _touches[event.pointer] = event.position -
                    Offset(0, MediaQuery.of(context).padding.top + 40);
              });
            },
            onPointerUp: (PointerUpEvent event) {
              setState(() {
                _touches.remove(event.pointer);
                _colors.remove(
                    event.pointer); // eliminar el color asociado al toque
              });
            },
            child: CustomPaint(
              painter: TouchPainter(_touches, _colors),
              child: Container(),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '$_contador',
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: Colors.white, // Color blanco
                      ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TouchPainter extends CustomPainter {
  final Map<int, Offset> touches;
  final Map<int, Color> colors;

  TouchPainter(this.touches, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    touches.forEach((int key, Offset offset) {
      final paint = Paint()
        ..color = colors[key] ??
            Colors.amber // usar el color asociado al toque o rojo por defecto
        ..style = PaintingStyle.fill;

      canvas.drawCircle(offset, 70.0, paint);
    });
  }

  @override
  bool shouldRepaint(TouchPainter oldDelegate) => true;
}
