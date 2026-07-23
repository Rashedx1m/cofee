import '../../../core/models/enum/state_value.dart';
import '../../item_details/models/item_details_model.dart';

class HomeScreenState {

  /// enum
  final StateValue coffeeBeansState;

  final String coffeeBeansStateErrorMessage;

  final List<ItemDetailsModel> coffeeBeans;



  HomeScreenState({
    this.coffeeBeansState = StateValue.init,
    this.coffeeBeansStateErrorMessage = "",
    this.coffeeBeans = const[],

  });

  HomeScreenState copyWith({
    StateValue? coffeeBeansState,
    String? coffeeBeansStateErrorMessage,
    List<ItemDetailsModel>? coffeeBeans,
  }) {
    return HomeScreenState(
      coffeeBeansState: coffeeBeansState ?? this.coffeeBeansState,
      coffeeBeansStateErrorMessage:
          coffeeBeansStateErrorMessage ?? this.coffeeBeansStateErrorMessage,
      coffeeBeans: coffeeBeans ?? this.coffeeBeans,
    );
  }
}







