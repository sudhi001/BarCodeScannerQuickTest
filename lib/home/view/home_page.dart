import 'package:barcode_scanner/home/home.dart';
import 'package:barcode_scanner/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScannerCubit(),
      child: const HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: const Center(child: MessageText()),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final scannerCubit = context.read<ScannerCubit>();
              final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                '#ff6666',
                'Cancel',
                true,
                ScanMode.BARCODE,
              );
              scannerCubit.setBarCodeResult(barcodeScanRes);
            },
            child: const Icon(Icons.barcode_reader),
          ),
        ],
      ),
    );
  }
}

class MessageText extends StatelessWidget {
  const MessageText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final result = context.select((ScannerCubit cubit) => cubit.state);
    return SingleChildScrollView(
        child: Text(result, style: theme.textTheme.displayLarge));
  }
}
