// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:community_health_app/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../core/utilities/size_config.dart';

class SfDateRangePickerView extends StatefulWidget {
  SfDateRangePickerView({
    super.key,
    required this.onDidSelectedDateRange,
  });

  final void Function(String startDate, String endDate) onDidSelectedDateRange;

  @override
  State<SfDateRangePickerView> createState() => _SfDateRangePickerViewState();
}

class _SfDateRangePickerViewState extends State<SfDateRangePickerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: SfDateRangePicker(
          backgroundColor: Colors.white,
          showActionButtons: true,
          initialSelectedDate: DateTime.now(),
          headerStyle: DateRangePickerHeaderStyle(
            backgroundColor: kPrimaryColor,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: responsiveFont(13),
              fontWeight: FontWeight.w500,
            ),
          ),
          rangeSelectionColor: kPrimaryColor.withOpacity(0.3),
          onSubmit: (p0) {
            if (p0 == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Please select date range',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            } else {
              if (p0 is PickerDateRange) {
                //'yyyy-MM-dd'
                final DateFormat formatter = DateFormat('dd MMM yyyy');
                final String startDate = formatter.format(p0.startDate!);
                final String endDate =
                    formatter.format(p0.endDate ?? p0.startDate!);
                print('Start Date: $startDate');
                print('End Date: $endDate');
                widget.onDidSelectedDateRange(startDate, endDate);
                Navigator.pop(context);
              }
            }
          },
          onCancel: () {
            Navigator.pop(context);
          },
          selectionMode: DateRangePickerSelectionMode.range,
        ),
      ),
    );
  }
}
