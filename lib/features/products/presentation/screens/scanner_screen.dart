import 'dart:io' show Platform;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flux_pos/features/auth/presentation/widgets/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _scannerController = MobileScannerController();
  final TextEditingController _manualCodeController = TextEditingController();

  bool _loading = true;
  bool _useManualInput = false;
  bool _handled = false;

  @override
  void initState() {
    super.initState();
    _detectEnvironment();
  }

  Future<void> _detectEnvironment() async {
    bool manualInput = false;

    try {
      if (!kIsWeb && Platform.isIOS) {
        final deviceInfo = DeviceInfoPlugin();
        final iosInfo = await deviceInfo.iosInfo;

        // En simulador isPhysicalDevice suele ser false.
        manualInput = !iosInfo.isPhysicalDevice;
      }
    } catch (_) {
      // Fallback seguro: si falla la detección, no bloqueamos la cámara.
      manualInput = false;
    }

    if (!mounted) return;

    setState(() {
      _useManualInput = manualInput;
      _loading = false;
    });
  }

  void _handleCode(String code) {
    if (code.trim().isEmpty) return;
    if (_handled) return;

    _handled = true;

    debugPrint('Código detectado/manual: $code');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Código: $code')),
    );

    // Acá podés navegar, buscar en API, etc.
    // Navigator.pop(context, code);
  }

  @override
  void dispose() {
    _scannerController.dispose();
    _manualCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_useManualInput ? 'Ingresar código' : 'Escanear código'),
      ),
      body: _useManualInput ? _buildManualInput() : _buildScanner(),
    );
  }

  Widget _buildManualInput() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Estás en iOS Simulator.\nIngresá el código manualmente:',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _manualCodeController,
            decoration: const InputDecoration(
              labelText: 'Código de barras',
              border: OutlineInputBorder(),
            ),
            onSubmitted: _handleCode,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: CustomFilledButton(
              onPressed: () => _handleCode(_manualCodeController.text),
             text: 'Confirmar',
             buttonColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanner() {
    return MobileScanner(
      controller: _scannerController,
      onDetect: (capture) {
        final code = capture.barcodes.firstOrNull?.rawValue;
        if (code != null) {
          _handleCode(code);
        }
      },
    );
  }
}