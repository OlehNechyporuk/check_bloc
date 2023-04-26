import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/features/cash_register/domain/entity/discount_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/product_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_item_entity.dart';
import 'package:check_bloc/features/cash_register/domain/entity/receipt_payment_entity.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/products/search_products_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/receipt/add_discount_to_product_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/receipt/add_product_quantity_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/receipt/add_product_to_receipt_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/receipt/add_receipt_discount_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/receipt/add_receipt_use_case.dart';

part 'receipt_event.dart';
part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final AddProductToReceiptUseCase _addProductToReceiptUseCase;
  final AddProductQuantityUseCase _addProductQuantityUseCase;
  final SearchProductsUseCase _searchProductsUseCase;
  final AddDiscountToProductUseCase _addDiscountToProductUseCase;
  final AddReceiptDiscountUseCase _addReceiptDiscountUseCase;
  final AddReceiptUseCase _addReceiptUseCase;
  final AssetsAudioPlayer _audioPlayer;

  ReceiptBloc(
    this._addProductToReceiptUseCase,
    this._addProductQuantityUseCase,
    this._searchProductsUseCase,
    this._addDiscountToProductUseCase,
    this._addReceiptDiscountUseCase,
    this._addReceiptUseCase,
    this._audioPlayer,
  ) : super(const ReceiptState.empty()) {
    _audioPlayer.setVolume(0.4);
    _audioPlayer.open(Audio('assets/audio/scanner-beep.mp3'), autoStart: false);

    on<ReceiptInitialEvent>(_intial);
    on<ReceiptAddGoodEvent>(_addGood);
    on<ReceiptUpdateGoodPriceEvent>(_updatePrice);
    on<ReceiptUpdateQuantityEvent>(_updateQuantity);
    on<ReceiptDeleteItemEvent>(_deleteItem);
    on<ReceiptClearItemsEvent>(_clearItems);
    on<ReceiptAddDiscountToProductEvent>(_addDiscountToProduct);
    on<ReceiptAddGeneralDiscountEvent>(_addGeneralDiscount);
    on<ReceiptChangePaymentEvent>(_changePayment);
    on<ReceiptAddEvent>(_add);
    on<ReceiptAddGoodByBarcodeEvent>(_addGoodByBarcode);
  }

  @override
  Future<void> close() async {
    _audioPlayer.dispose();
    super.close();
  }

  _intial(ReceiptInitialEvent event, emit) {
    emit(const ReceiptState.empty());
  }

  _addGood(ReceiptAddGoodEvent event, emit) async {
    final List<ReceiptItemEntity> items = [];

    items.addAll(state.receipt.goods);

    double? price = event.product.price;
    final double? productPrice = state.productPrice;

    if (productPrice != null) {
      price = productPrice * 100;
    }

    final result = await _addProductToReceiptUseCase(
      AddProductToReceiptParams(
        items: items,
        product: event.product,
        price: price,
      ),
    );

    result.fold((error) {
      emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          errorText: error.message,
        ),
      );
    }, (items) {
      emit(
        state.copyWith(
          receipt: state.receipt.copyWith(goods: items),
          productPrice: null,
          status: BlocStateStatus.success,
          errorText: null,
        ),
      );
    });
  }

  _updatePrice(ReceiptUpdateGoodPriceEvent event, emit) {
    emit(state.copyWith(productPrice: event.price));
  }

  _updateQuantity(ReceiptUpdateQuantityEvent event, emit) async {
    if (state.receipt.goods.isEmpty || event.index == null) {
      return;
    }

    List<ReceiptItemEntity> items = [];
    items.addAll(state.receipt.goods);

    final result = await _addProductQuantityUseCase(
      AddProductQuantityParams(
        items: items,
        index: event.index!,
        quantity: event.quantity,
      ),
    );

    result.fold((l) => null, (items) {
      emit(
        state.copyWith(
          receipt: state.receipt.copyWith(
            goods: items,
          ),
        ),
      );
    });
  }

  _deleteItem(ReceiptDeleteItemEvent event, emit) {
    final List<ReceiptItemEntity> items = [];

    items.addAll(state.receipt.goods);

    items.removeAt(event.index);

    emit(
      state.copyWith(
        receipt: state.receipt.copyWith(
          goods: items,
          discounts: items.isEmpty ? [] : state.receipt.discounts,
        ),
      ),
    );
  }

  _clearItems(ReceiptClearItemsEvent event, emit) {
    emit(const ReceiptState.empty());
  }

  _addDiscountToProduct(ReceiptAddDiscountToProductEvent event, emit) async {
    final List<ReceiptItemEntity> items = [];
    items.addAll(state.receipt.goods);

    final discount = event.discount ?? 0;

    final result = await _addDiscountToProductUseCase(
      AddDiscountToProductParams(
        items: items,
        index: event.index,
        type: event.type,
        discount: discount,
      ),
    );

    result.fold((error) {
      emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          errorText: error.message,
        ),
      );
    }, (items) {
      emit(state.receipt.copyWith(goods: items));
    });
  }

  _addGeneralDiscount(ReceiptAddGeneralDiscountEvent event, emit) async {
    final discount = event.discount ?? 0;
    final type = event.type ?? DiscountType.fixed;

    final result = await _addReceiptDiscountUseCase(
      AddReceiptDiscountParams(
        receipt: state.receipt,
        type: type,
        discount: discount,
      ),
    );

    result.fold((error) {
      emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          errorText: error.message,
        ),
      );
    }, (receipt) {
      emit(
        state.copyWith(
          receipt: receipt,
          status: BlocStateStatus.success,
        ),
      );
    });
  }

  _changePayment(ReceiptChangePaymentEvent event, emit) {
    if (event.type == 'CASH') {
      final sum = event.sum;
      if (sum != null) {
        final payment = ReceiptPaymentEntity(
          type: event.type,
          value: 100 * sum,
          label: 'Готівка',
        );

        emit(
          state.copyWith(
            receipt: state.receipt.copyWith(
              payments: [payment],
              rounding: true,
            ),
          ),
        );
      } else {
        final payment = ReceiptPaymentEntity(
          type: event.type,
          value: 0,
          label: 'Готівка',
        );

        emit(
          state.copyWith(
            receipt:
                state.receipt.copyWith(payments: [payment], rounding: true),
          ),
        );
      }
    } else if (event.type == 'CARD') {
      final payment = ReceiptPaymentEntity(
        type: event.type,
        value: 0,
        label: 'Картка',
      );

      emit(
        state.copyWith(
          receipt: state.receipt.copyWith(payments: [payment], rounding: false),
        ),
      );
    }
  }

  _add(ReceiptAddEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result =
        await _addReceiptUseCase(AddReceiptParams(receipt: state.receipt));

    result.fold(
      (error) => emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          errorText: error.message,
        ),
      ),
      (receipt) => emit(
        const ReceiptState.empty().copyWith(
          lastReceiptId: receipt.id,
          status: BlocStateStatus.success,
        ),
      ),
    );
  }

  _addGoodByBarcode(ReceiptAddGoodByBarcodeEvent event, emit) async {
    final barcode = event.barcode;

    if (barcode != null) {
      final result =
          await _searchProductsUseCase(SearchProductsParams(barcode));

      result.fold(
        (error) => {
          emit(
            state.copyWith(
              errorText: error.message,
              status: BlocStateStatus.failure,
            ),
          )
        },
        (products) async {
          if (products.isNotEmpty) {
            await _audioPlayer.play();
            add(ReceiptAddGoodEvent(products.first));
          } else {
            emit(
              state.copyWith(
                errorText:
                    '${FailureMessages.productNotFound} : ${event.barcode} ',
                status: BlocStateStatus.failure,
              ),
            );
          }
        },
      );
    }
  }
}
