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

  late int tripDuration;

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
                      Trip planData = ref.watch(tripProvider).trip!;
                      planData.duration = dayList[idx];
                      ref.read(planOfDaysIndex.notifier).selectIndex(0);
                      ref
                          .read(tripProvider)
                          .modifyTripData(modifiedTripData: planData);
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
    Trip planData = ref.watch(tripProvider).trip!;
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
                      planData.duration.toString(),
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

//

class TripTitleWidget extends ConsumerStatefulWidget {
  const TripTitleWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TripTitleWidgetState();
}

class _TripTitleWidgetState extends ConsumerState<TripTitleWidget> {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
          child: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: (title) {
              planData.title = title;
              ref.read(tripProvider).modifyTripData(modifiedTripData: planData);
            },
          ),
        ),
      ],
    );
  }
}

//

class PlanOfDaysWidget extends ConsumerStatefulWidget {
  const PlanOfDaysWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PlanOfDaysWidgetState();
}

class _PlanOfDaysWidgetState extends ConsumerState<PlanOfDaysWidget> {
  Map<dynamic, List<TextEditingController>> detailControllers = {};
  @override
  Widget build(BuildContext context) {
    Trip planData = ref.watch(tripProvider).trip!;
    final selectedDay = ref.watch(planOfDaysIndex)!;
    final tripDuration = planData.duration;
    final planOfDaySchedule = planData.planOfDay;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
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
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
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
                            //image picker
                            await PlanMyTripViewModel()
                                .requestGetImageFile()
                                .then((file) {
                              if (file != null) {
                                planOfDaySchedule['$selectedDay']![idx2]
                                    ['image'] = file;
                                ref
                                    .read(tripProvider)
                                    .modifyTripData(modifiedTripData: planData);
                              }
                            });
                          },
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
                        //Location
                        InkWell(
                          onTap: () async {
                            //Google Maps 연동 후 lat lng 가져오기
                            await PlanMyTripViewModel()
                                .requestGetMyPosition()
                                .then(
                              (position) {
                                final lat = position['lat'];
                                final lng = position['lng'];
                                Map<String, dynamic> locationData = {
                                  'lat': lat,
                                  'lng': lng,
                                  'selectedDay': '$selectedDay',
                                  'idx': idx2,
                                };

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SelectPlaceMapView(
                                      locationData: locationData,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                                          AppLocalizations.of(context)!
                                              .location,
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
                        ),
                        //Detail
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          child: TextField(
                            controller: detailControllers[selectedDay]![idx2],
                            minLines: 2,
                            maxLines: null,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            onChanged: (detail) {
                              planOfDaySchedule['$selectedDay']![idx2]
                                  ['detail'] = detail;

                              ref
                                  .read(tripProvider)
                                  .modifyTripData(modifiedTripData: planData);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      planOfDaySchedule['$selectedDay']!.removeAt(idx2);
                      ref
                          .read(tripProvider)
                          .modifyTripData(modifiedTripData: planData);
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.trash,
                      color: Colors.black,
                      size: 24,
                      shadows: [
                        Shadow(
                          color: Colors.white,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ],
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
          const SizedBox(height: 20),
          //Add place button
          InkWell(
            onTap: () {
              List<dynamic> temporaryList =
                  planOfDaySchedule['$selectedDay'] ?? [];
              temporaryList.add({});
              planOfDaySchedule['$selectedDay'] = temporaryList;

              List<TextEditingController> controllers =
                  detailControllers[selectedDay] ?? [];
              controllers.add(TextEditingController());
              detailControllers[selectedDay] = controllers;

              planData.planOfDay = planOfDaySchedule;
              ref.read(tripProvider).modifyTripData(modifiedTripData: planData);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(CustomIcon.map_marker_alt),
                  const SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context)!.addPlace,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlanMyTripWidgets {
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
