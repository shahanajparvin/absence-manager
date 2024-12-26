import 'package:absence_manager/domain/entities/language.dart';
import 'package:absence_manager/presentation/feature/lanuage/bloc/language_event.dart';
import 'package:absence_manager/presentation/feature/lanuage/bloc/language_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  Language?  currentLanguage;



  LanguageBloc(this.currentLanguage)
      : super(LanguageState(selectedLanguage: currentLanguage)) {
    on<ChangeLanguage>(_onChangeLanguage);
  }

  void _onChangeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) {
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }



}
