import 'package:bloc/bloc.dart';

class ScannerCubit extends Cubit<String> {
  ScannerCubit() : super('');

  void setBarCodeResult(String result) => emit(result);
}
