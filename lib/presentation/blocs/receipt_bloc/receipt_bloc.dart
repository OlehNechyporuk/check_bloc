import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/failure.dart';
import 'package:check_bloc/domain/entity/discount_entity.dart';
import 'package:check_bloc/domain/entity/good_entity.dart';
import 'package:check_bloc/domain/entity/product_entity.dart';
import 'package:check_bloc/domain/entity/receipt_entity.dart';
import 'package:check_bloc/domain/entity/receipt_item_entity.dart';
import 'package:check_bloc/domain/entity/receipt_payment_entity.dart';
import 'package:check_bloc/domain/repository/product_repository.dart';
import 'package:check_bloc/domain/repository/receipt_repository.dart';
import 'package:equatable/equatable.dart';

part 'receipt_event.dart';
part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final ReceiptRepository _receiptRepository;
  final ProductRepository _productRepository;
  final AssetsAudioPlayer _audioPlayer;

  ReceiptBloc(
    this._receiptRepository,
    this._productRepository,
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

  _addGood(ReceiptAddGoodEvent event, emit) {
    final List<ReceiptItemEntity> items = [];

    items.addAll(state.receipt.goods);

    double? price = event.product.price;
    final double? productPrice = state.productPrice;

    if (productPrice != null) {
      price = productPrice * 100;
    }

    final newReciept = ReceiptItemEntity(
      id: null,
      good: GoodEntity(
        code: event.product.code,
        name: event.product.name,
        barcode: '${event.product.barcode}',
        exciseBarcode: '',
        exciseBarcodes: const [''],
        price: price,
        tax: const [0],
        uktzed: '',
      ),
      quantity: 1,
      discounts: const [],
    );

    int find =
        items.indexWhere((element) => element.good.code == event.product.code);

    if (find < 0) {
      items.add(newReciept);
    } else {
      final amount = items[find].quantity;

      items[find] = items[find].copyWith(quantity: amount + 1);
    }

    emit(
      state.copyWith(
        receipt: state.receipt.copyWith(goods: items),
        productPrice: null,
        status: BlocStateStatus.success,
        errorText: null,
      ),
    );
  }

  _updatePrice(ReceiptUpdateGoodPriceEvent event, emit) {
    emit(state.copyWith(productPrice: event.price));
  }

  _updateQuantity(ReceiptUpdateQuantityEvent event, emit) {
    if (state.receipt.goods.isEmpty || event.index == null) {
      return;
    }

    List<ReceiptItemEntity> items = [];
    items.addAll(state.receipt.goods);

    final item = items[event.index!];
    final current = item.quantity;

    int newAmount = 1;

    if (event.quantity == null) {
      newAmount = 0;
    } else if (event.quantity != 1 && event.quantity != -1) {
      newAmount = event.quantity ?? 1;
    } else {
      newAmount = current + event.quantity!;
    }

    if (newAmount <= 0) {
      newAmount = 1;
    }

    items[event.index!] = items[event.index!].copyWith(quantity: newAmount);

    emit(
      state.copyWith(
        receipt: state.receipt.copyWith(
          goods: items,
        ),
      ),
    );
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

  _addDiscountToProduct(ReceiptAddDiscountToProductEvent event, emit) {
    final List<ReceiptItemEntity> items = [];
    items.addAll(state.receipt.goods);

    final discount = event.discount ?? 0;

    if (discount <= 0) {
      items[event.index] = items[event.index].copyWith(discounts: []);
      emit(
        state.copyWith(
          receipt: state.receipt.copyWith(goods: items),
        ),
      );
    } else {
      if (event.type == DiscountType.percent) {
        final persentDiscount = DiscountEntity(
          type: 'DISCOUNT',
          mode: 'PERCENT',
          value: discount,
        );

        items[event.index] =
            items[event.index].copyWith(discounts: [persentDiscount]);
        emit(
          state.copyWith(
            receipt: state.receipt.copyWith(goods: items),
          ),
        );
      } else if (event.type == DiscountType.fixed) {
        if ((discount) < items[event.index].good.price) {
          final cashDiscount = DiscountEntity(
            type: 'DISCOUNT',
            mode: 'CASH',
            value: discount,
          );

          items[event.index] =
              items[event.index].copyWith(discounts: [cashDiscount]);
          emit(
            state.copyWith(
              receipt: state.receipt.copyWith(goods: items),
            ),
          );
        }
      }
    }
  }

  _addGeneralDiscount(ReceiptAddGeneralDiscountEvent event, emit) {
    final discount = event.discount ?? 0;
    if (discount <= 0) {
      emit(
        state.copyWith(
          receipt: state.receipt.copyWith(discounts: []),
        ),
      );
    } else {
      if (event.type == DiscountType.percent) {
        final persentDiscount = DiscountEntity(
          type: 'DISCOUNT',
          mode: 'PERCENT',
          value: discount,
        );

        emit(
          state.copyWith(
            receipt: state.receipt.copyWith(discounts: [persentDiscount]),
          ),
        );
      } else if (event.type == DiscountType.fixed) {
        final cashDiscount = DiscountEntity(
          type: 'DISCOUNT',
          mode: 'CASH',
          value: discount,
        );

        emit(
          state.copyWith(
            receipt: state.receipt.copyWith(discounts: [cashDiscount]),
          ),
        );
      }
    }
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

    final result = await _receiptRepository.add(state.receipt);

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
      final result = await _productRepository.getProducts(searchQuery: barcode);

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
