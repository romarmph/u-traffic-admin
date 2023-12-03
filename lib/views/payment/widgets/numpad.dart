import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:u_traffic_admin/config/exports/exports.dart';

class NumPad extends ConsumerStatefulWidget {
  const NumPad({
    super.key,
    required this.ticket,
    required this.constraints,
  });

  final Ticket ticket;
  final BoxConstraints constraints;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NumPadState();
}

class _NumPadState extends ConsumerState<NumPad> {
  final _numPadScreenController = TextEditingController();
  double _change = 0;
  Color _changeColor = UColors.red500;

  @override
  void initState() {
    _numPadScreenController.text = "0";
    _numPadScreenController.addListener(() {
      _getChange();
      _getChangeColor();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: widget.constraints.maxHeight - 32,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Total Fine",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Php ${widget.ticket.totalFine.toString()}",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.end,
          ),
          const SizedBox(
            height: USpace.space16,
          ),
          const Text(
            "Amount Tendered",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d+\.?\d{0,2}'),
              ),
            ],
            controller: _numPadScreenController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(USpace.space8),
              ),
              prefixText: 'Php',
            ),
            readOnly: true,
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w600,
              color: UColors.gray600,
            ),
            textAlign: TextAlign.end,
          ),
          SizedBox(
            height: 72,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NumPadButton(
                  onPressed: _clearScreen,
                  child: const Text('C'),
                ),
                NumPadButton(
                  onPressed: _backspace,
                  child: const Icon(Icons.backspace_rounded),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 72,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NumPadButton(
                  child: const Text('7'),
                  onPressed: () => _updateScreen('7'),
                ),
                NumPadButton(
                  child: const Text('8'),
                  onPressed: () => _updateScreen('8'),
                ),
                NumPadButton(
                  child: const Text('9'),
                  onPressed: () => _updateScreen('9'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 72,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NumPadButton(
                  child: const Text('4'),
                  onPressed: () => _updateScreen('4'),
                ),
                NumPadButton(
                  child: const Text('5'),
                  onPressed: () => _updateScreen('5'),
                ),
                NumPadButton(
                  child: const Text('6'),
                  onPressed: () => _updateScreen('6'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 72,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NumPadButton(
                  child: const Text('1'),
                  onPressed: () => _updateScreen('1'),
                ),
                NumPadButton(
                  child: const Text('2'),
                  onPressed: () => _updateScreen('2'),
                ),
                NumPadButton(
                  child: const Text('3'),
                  onPressed: () => _updateScreen('3'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 72,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NumPadButton(
                  child: const Text('0'),
                  onPressed: () => _updateScreen('0'),
                ),
                NumPadButton(
                  child: const Text('00'),
                  onPressed: () => _updateScreen('00'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Change Total",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Php $_change",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: _changeColor,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: USpace.space16,
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.all(USpace.space20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(USpace.space8),
              ),
              backgroundColor: UColors.green500,
              foregroundColor: UColors.white,
            ),
            onPressed: () async {
              if (_change < 0 || _numPadScreenController.text == "0") {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'Invalid Amount',
                  text: 'The amount tendered is less than the total fine.',
                );
                return;
              }

              final value = await _confirmPayment();

              if (value != true) {
                return;
              }

              final orNumber = await getOrNumber();

              if (orNumber == null) {
                await QuickAlert.show(
                    context: navigatorKey.currentContext!,
                    type: QuickAlertType.error,
                    title: 'Missing OR Number',
                    text:
                        'After filling up the Official Receipt, please use the OR Number to confirm the payment.');
                Navigator.of(navigatorKey.currentContext!).pop();
                return;
              }

              _showLoading();
              try {
                final admin = ref.watch(currentAdminProvider);
                await PaymentDatabase.instance.payTicket(
                  ticket: widget.ticket,
                  orNumber: orNumber,
                  amountTendered: double.parse(_numPadScreenController.text),
                  change: _change,
                  cashierName: '${admin.firstName} ${admin.lastName}',
                );

                await TicketDatabase.instance.updateTicketStatus(
                  id: widget.ticket.id!,
                  status: TicketStatus.paid,
                );
                _pop();
                _showPaymentSuccess();
              } catch (e) {
                _showPaymentFailed();
                return;
              }
            },
            child: const Text(
              'Done',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: USpace.space16,
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.all(USpace.space20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(USpace.space8),
              ),
              backgroundColor: UColors.gray300,
              foregroundColor: UColors.gray600,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _confirmPayment() async {
    return await QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Confirm Payment',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: USpace.space16,
          ),
          Text(
            'Tendered Amount: Php ${_numPadScreenController.text}',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: USpace.space16,
          ),
          Text(
            'Total Fine: Php ${widget.ticket.totalFine}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: UColors.red400,
            ),
          ),
          const SizedBox(
            height: USpace.space16,
          ),
          Text(
            'Change: Php $_change',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: UColors.green400,
            ),
          ),
        ],
      ),
      showConfirmBtn: true,
      showCancelBtn: true,
      confirmBtnText: 'Confirm',
      cancelBtnText: 'Cancel',
      onConfirmBtnTap: () {
        Navigator.of(context).pop(true);
      },
      onCancelBtnTap: () {
        Navigator.of(context).pop(false);
      },
    );
  }

  void _pop() {
    Navigator.of(context).pop();
  }

  void _showLoading() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Processing Payment',
      text: 'Please wait while we process the payment.',
    );
  }

  void _showPaymentSuccess() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Payment Successful',
      text:
          "The payment has been successfully processed.\n Please check the Admin Mobile to print the receipt.",
      onConfirmBtnTap: () {
        ref.invalidate(getTicketByIdFutureProvider(widget.ticket.id!));
        Navigator.of(context).pushReplacementNamed(
          Routes.payment,
        );
      },
    );
  }

  void _showPaymentFailed() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Payment Failed',
      text: 'The payment has failed to process.',
    );
  }

  void _updateScreen(String value) {
    if (_numPadScreenController.text == "0") {
      _numPadScreenController.text = value;
      return;
    }

    if (_numPadScreenController.text.length >= 6) {
      return;
    }

    if (_numPadScreenController.text.length == 5 && value == "00") {
      _numPadScreenController.text += "0";
      return;
    }

    _numPadScreenController.text += value;
  }

  void _clearScreen() {
    _numPadScreenController.text = "0";
  }

  void _backspace() {
    if (_numPadScreenController.text.length == 1) {
      _clearScreen();
      return;
    }

    _numPadScreenController.text = _numPadScreenController.text
        .substring(0, _numPadScreenController.text.length - 1);
  }

  void _getChange() {
    setState(() {
      _change =
          double.parse(_numPadScreenController.text) - widget.ticket.totalFine;
    });
  }

  void _getChangeColor() {
    if (_change < 0) {
      setState(() {
        _changeColor = UColors.red500;
      });
      return;
    }

    setState(() {
      _changeColor = UColors.green500;
    });
  }

  Future<String?> getOrNumber() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
          insetPadding: EdgeInsets.all(16),
          child: ORNumberForm(),
        );
      },
    );
  }
}

class ORNumberForm extends ConsumerStatefulWidget {
  const ORNumberForm({super.key});

  @override
  ConsumerState<ORNumberForm> createState() => _ORNumberFormState();
}

class _ORNumberFormState extends ConsumerState<ORNumberForm> {
  final _formKey = GlobalKey<FormState>();
  final _orNumberController = TextEditingController();
  final _confirmOrNumberController = TextEditingController();

  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: UColors.white,
        borderRadius: BorderRadius.circular(USpace.space12),
      ),
      child: ref.watch(paymentStreamProvider).when(data: (data) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'OR Number',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: USpace.space16,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _orNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(USpace.space8),
                      ),
                      labelText: 'OR Number',
                    ),
                    onChanged: (value) {
                      if (data.any((element) => element.orNumber == value)) {
                        setState(() {
                          _errorText = 'OR Number is already used';
                        });
                      } else {
                        setState(() {
                          _errorText = null;
                        });
                      }
                      _formKey.currentState!.validate();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the OR Number';
                      }

                      if (data.any((element) => element.orNumber == value)) {
                        return 'OR Number is already used';
                      } else {
                        _errorText = null;
                      }

                      return _errorText;
                    },
                  ),
                  const SizedBox(
                    height: USpace.space16,
                  ),
                  TextFormField(
                    controller: _confirmOrNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(USpace.space8),
                      ),
                      labelText: 'Confirm OR Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the OR Number';
                      }

                      if (value != _orNumberController.text) {
                        return 'The OR Number does not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: USpace.space16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(
                        width: USpace.space16,
                      ),
                      FilledButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pop(_orNumberController.text);
                          }
                        },
                        child: const Text('Confirm'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      }, error: (error, stackTrace) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'OR Number',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: USpace.space16,
            ),
            const Text(
              'Failed to load OR Number',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: USpace.space16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  width: USpace.space16,
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Confirm'),
                ),
              ],
            )
          ],
        );
      }, loading: () {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'OR Number',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: USpace.space16,
            ),
            const Text(
              'Loading OR Number',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: USpace.space16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  width: USpace.space16,
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Confirm'),
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}
