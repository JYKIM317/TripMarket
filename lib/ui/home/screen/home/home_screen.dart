import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_market/ui/home/screen/home/home_screen_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
            /*
              수집하는 데이터 
              - Search history
              - Search or main에서 들어간 post info history
            */
            //favorite destinations recommend widget
            //
            //favorite tag recommend widget
            //
            //random recommend widget
            ),
      ),
    );
  }
}
