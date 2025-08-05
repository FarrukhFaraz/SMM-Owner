import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'earn_referral_state.dart';

class EarnReferralCubit extends Cubit<EarnReferalState> {
  EarnReferralCubit() : super(EarnReferalInitial());
}
