part of 'tripPlan_page.dart';

class TripPlanPageWidgets {
  Widget tripTitleWidget() {
    return Consumer(
      builder: (context, ref, child) {
        Trip planData = ref.watch(tripProvider).trip!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.tripTitle,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
                planData.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget destinationWidget() {
    return Consumer(
      builder: (context, ref, child) {
        Trip planData = ref.watch(tripProvider).trip!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.destination,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Text(
                planData.nation,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}

class PlanOfDaysWidget extends ConsumerStatefulWidget {
  const PlanOfDaysWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlanOfDaysWidgetState();
}

class _PlanOfDaysWidgetState extends ConsumerState<PlanOfDaysWidget> {
  @override
  Widget build(BuildContext context) {
    Trip planData = ref.watch(tripProvider).trip!;
    final selectedDay = ref.watch(planOfDaysIndex)!;
    final tripDuration = planData.duration;
    final planOfDaySchedule = planData.planOfDay;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // trip duration days
        SizedBox(
          height: 50,
          child: ListView.separated(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: tripDuration,
            itemBuilder: (BuildContext ctx, int idx) {
              return InkWell(
                onTap: () {
                  ref.read(planOfDaysIndex.notifier).selectIndex(idx);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: idx == selectedDay
                          ? Colors.black.withOpacity(0.5)
                          : Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'Days ${idx + 1}',
                    style: TextStyle(
                      color: idx == selectedDay ? Colors.white : Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, idx) {
              return const SizedBox(width: 10);
            },
          ),
        ),
        const SizedBox(height: 20),
        //plan of day schedule
        ListView.separated(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: planOfDaySchedule['$selectedDay']?.length ?? 0,
          itemBuilder: (BuildContext ctx2, int idx2) {
            double minHeight = MediaQuery.of(context).size.width - 32;
            var thisImage = planOfDaySchedule['$selectedDay']![idx2]['image'];
            bool isFile = thisImage.runtimeType != String;
            bool isThumbnail = selectedDay == 0 && idx2 == 0;
            return Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: double.infinity,
                minHeight: minHeight,
              ),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Image
                  InkWell(
                    onTap: () async {
                      //full screen image
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImagePage(
                            thisImageTag: isThumbnail
                                ? planData.docName
                                : '${selectedDay}_$idx2',
                            thisImage: thisImage,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: isThumbnail
                          ? planData.docName
                          : '${selectedDay}_$idx2',
                      child: SizedBox(
                        width: double.infinity,
                        height: minHeight * 0.7,
                        child: thisImage == null
                            ? Container(
                                color: Colors.grey,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.image,
                                  size: minHeight * 0.2,
                                  color: Colors.white,
                                ),
                              )
                            : isFile
                                ? Image.file(
                                    thisImage,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: thisImage,
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      ),
                    ),
                  ),
                  //Location
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.4,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(
                            CustomIcon.map_marker_alt,
                            color: Colors.grey,
                            size: 21,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              planOfDaySchedule['$selectedDay']?[idx2]
                                      ['location'] ??
                                  '',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Detail
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      planOfDaySchedule['$selectedDay']![idx2]['detail'] ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (ctx2, idx2) {
            return Container(
              height: 60,
              alignment: Alignment.center,
              child: const FaIcon(
                FontAwesomeIcons.arrowDown,
                color: Colors.grey,
                size: 21,
              ),
            );
          },
        ),
      ],
    );
  }
}
