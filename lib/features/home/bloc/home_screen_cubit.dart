import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/enum/state_value.dart';
import '../../item_details/models/item_details_model.dart';
import 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  // HomeScreenCubit(super.initialState);
  HomeScreenCubit() : super(HomeScreenState());

  void getCoffeeFromBackend() async {
    emit(state.copyWith(coffeeBeansState: StateValue.loading));

    try {
      await Future.delayed(Duration(seconds: 5));

      emit(
        state.copyWith(
          coffeeBeansState: StateValue.loaded,
          coffeeBeans: [
            ItemDetailsModel(
              name: " Robusta Beans",
              subtitle: 'From Africa',
              image: 'assets/images/pexels-photo-4109744.png',
              rating: 4.5,
              ratingCount: 6879,
              description:
                  'Arabica beans are by far the most popular type of coffee '
                  'beans, making up about 60% of the world\'s coffee. These '
                  'tasty beans originated many centuries ago in the highlands '
                  'of Ethiopia, and may even be the first coffee beans ever '
                  'consumed.',
              sizeLabels: const ['250gm', '500gm', '1000gm'],
              roastLevel: 'Medium Roasted',
              pricesBySize: {'250gm': 100, '500gm': 200, '1000gm': 400},
            ),
            ItemDetailsModel(
              name: " B1",
              subtitle: 'From Africa',
              image: 'assets/images/pexels-photo-4109744.png',
              rating: 4.5,
              ratingCount: 6879,
              description:
              'Arabica beans are by far the most popular type of coffee '
                  'beans, making up about 60% of the world\'s coffee. These '
                  'tasty beans originated many centuries ago in the highlands '
                  'of Ethiopia, and may even be the first coffee beans ever '
                  'consumed.',
              sizeLabels: const ['250gm', '500gm', '1000gm'],
              roastLevel: 'Medium Roasted',
              pricesBySize: {'250gm': 100, '500gm': 200, '1000gm': 400},
            ),
          ],
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          coffeeBeansState: StateValue.fail,
          coffeeBeansStateErrorMessage: "err",
        ),
      );
    }
  }
}
