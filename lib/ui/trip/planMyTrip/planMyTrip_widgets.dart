part of 'planMyTrip_page.dart';

OverlayEntry? overlayEntry;

void removeOverlay() {
  overlayEntry?.remove();
  overlayEntry = null;
}

class TripDurationWidget extends ConsumerStatefulWidget {
  const TripDurationWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TripDurationWidgetState();
}

class _TripDurationWidgetState extends ConsumerState<TripDurationWidget> {
  @override
  void dispose() {
    overlayEntry?.remove();
    super.dispose();
  }

  final LayerLink tripDurationlayerLink = LayerLink();

  int tripDuration = 1;

  void tripDurationDropdown() {
    if (overlayEntry == null) {
      overlayEntry = tripDurationOverlay();
      Overlay.of(context).insert(overlayEntry!);
    }
  }

  OverlayEntry tripDurationOverlay() {
    List<int> dayList = List.generate(31, (index) => index + 1);
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: 60,
        child: CompositedTransformFollower(
          link: tripDurationlayerLink,
          offset: const Offset(0, 45),
          child: Material(
            color: Colors.white,
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                itemCount: dayList.length,
                itemBuilder: (BuildContext ctx, int idx) {
                  return TextButton(
                    onPressed: () {
                      removeOverlay();
                      setState(() {
                        tripDuration = dayList[idx];
                      });
                    },
                    child: Text(
                      dayList[idx].toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
                separatorBuilder: (ctx, idx) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.tripDuration,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CompositedTransformTarget(
                link: tripDurationlayerLink,
                child: InkWell(
                  onTap: () {
                    removeOverlay();
                    tripDurationDropdown();
                  },
                  child: Container(
                    width: 60,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Text(
                      tripDuration.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.days,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
