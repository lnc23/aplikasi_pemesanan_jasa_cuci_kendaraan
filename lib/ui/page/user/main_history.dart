// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazywash/cubit/pesanan_cubit.dart';
import 'package:lazywash/models/pesanan_model.dart';
import 'package:lazywash/shared/theme.dart';
import 'package:lazywash/ui/page/widgets/custom_form_detail_history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    context.read<PesananCubit>().fetchPesanan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
          child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
            ),
            child: Text(
              'History',
              style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
            ),
          ),
        ],
      ));
    }

    Widget detailhistory(List<PesananModel> pesanan) {
      return Container(
        child: Column(
          children: pesanan.map(
            (PesananModel pesanan) {
              return CustomFormDetailHistory(pesanan);
            },
          ).toList(),
        ),
      );
    }

    return BlocConsumer<PesananCubit, PesananState>(
      listener: (context, state) {
        if (state is PesananFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: kRedColor,
              content: Text(state.error),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is PesananSuccess) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Scaffold(
              backgroundColor: kBackgroundColor,
              body: SafeArea(
                child: ListView(
                  padding: EdgeInsets.only(
                      left: defaultMargin, right: defaultMargin, top: 35),
                  children: [
                    title(),
                    SizedBox(
                      height: 15,
                    ),
                    detailhistory(state.pesanan),
                  ],
                ),
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
