import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:inbestment/controllers/6successController.dart';
import 'package:inbestment/shared/app_text_styles.dart';
import 'package:inbestment/shared/auth_manager.dart';
import 'package:inbestment/utils/pic_enc_dec.dart';
import 'package:inbestment/widgets/custom_btn.dart';
import 'package:inbestment/widgets/my_chart_datum_model.dart';
import 'package:inbestment/widgets/my_round_card.dart';
import 'package:inbestment/widgets/my_scaffold2.dart';
import 'package:mrx_charts/mrx_charts.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

// final DashboardController controller = Get.put(DashboardController(Get.arguments));
  final SuccessController controller = Get.put(SuccessController(Get.arguments));
  final Color puhunanColor = Colors.amberAccent;
  final Color kitaColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return MyScaffold2(
      body: OrientationBuilder(builder: (context, orientation) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.1),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0), child: introCard()),
              const SizedBox(height: 30.0),
              Text(
                "YOUR PLAN IS READY",
                textAlign: TextAlign.center,
                style: poppinsMedium.copyWith(height: 1.0, fontSize: 25.0, color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              kayamananCard(),
              const SizedBox(height: 20.0),
              ///extra info
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               'PMT',
              //               style: tStyle(),
              //               textAlign: TextAlign.start,
              //             ),
              //             Text('Interest', style: tStyle(), textAlign: TextAlign.start),
              //             Text('N', style: tStyle(), textAlign: TextAlign.start),
              //             Text('Total Interest', style: tStyle(), textAlign: TextAlign.start),
              //             Text('Total Investment', style: tStyle(), textAlign: TextAlign.start),
              //             Text('Future Value', style: tStyle(), textAlign: TextAlign.start),
              //           ],
              //         ),
              //       ),
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text('${controller.pmt.toStringAsFixed(2)}',
              //                 style: tStyle(), textAlign: TextAlign.start),
              //             Text('${(controller.interest * 100).toStringAsFixed(2)}',
              //                 style: tStyle(), textAlign: TextAlign.start),
              //             Text('${controller.n.toStringAsFixed(2)}',
              //                 style: tStyle(), textAlign: TextAlign.start),
              //             Text('${controller.tInterest.toStringAsFixed(2)}',
              //                 style: tStyle(), textAlign: TextAlign.start),
              //             Text('${controller.tInvestment.toStringAsFixed(2)}',
              //                 style: tStyle(), textAlign: TextAlign.start),
              //             Text('${controller.fv.toStringAsFixed(2)}',
              //                 style: tStyle(), textAlign: TextAlign.start),
              //             Text('${controller.total_years}',
              //                 style: tStyle(), textAlign: TextAlign.start),
              //             Text('${controller.total_profit}',
              //                 style: tStyle(), textAlign: TextAlign.start),
              //             Text('${controller.total_inv}',
              //                 style: tStyle(), textAlign: TextAlign.start),
              //           ],
              //         ),
              //       )
              //     ],
              //   ),
              // ),

              /// Here starts chart
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 400.0,
                  maxWidth: 600.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black.withOpacity(.3),
                ),
                padding: const EdgeInsets.all(24.0),
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ///legend
                    Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 10.0,
                      spacing: 20.0,
                      children: [
                        Container(height: 20, width: 50, color: puhunanColor),
                        const Text("Puhunan",
                            style: TextStyle(color: Colors.white, fontSize: 14.0)),
                        Container(height: 20, width: 50, color: kitaColor),
                        const Text("Kita", style: TextStyle(color: Colors.white, fontSize: 14.0)),
                      ],
                    ),
                    Expanded(
                      child: Chart(
                        layers: layers(),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12.0).copyWith(bottom: 12.0),
                      ),
                    ),
                  ],
                ),
              ),

              ///chart finished
              const SizedBox(height: 20.0),

              ///second chart started

              Container(
                constraints: const BoxConstraints(
                  minHeight: 400.0,
                  minWidth: 600.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black.withOpacity(.3),
                ),
                padding: const EdgeInsets.all(24.0),
                margin: const EdgeInsets.all(20.0),
                child: chartToRun(),
              ),

              ///second chart finished
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 10.0,
                spacing: 5.0,
                children: [
                  // InfoCard(title: "Gender", desc: controller.userModel.gender),
                  // InfoCard(
                  //     title: "Age", desc: calculateAge(controller.userModel.birthday).toString()),
                  InfoCard(title: "Investor Type", desc: controller.category.value ?? ''),
                  InfoCard(
                      title: "Monthly Income",
                      desc:
                          controller.userModel.monthlyIncome.toCurrencyString(leadingSymbol: '₱')),
                  InfoCard(
                      title: "Monthly Contribution",
                      desc: controller.userModel.toInvestMonthly
                          .toCurrencyString(leadingSymbol: '₱')),
                  InfoCard(title: "Time Span", desc: "${controller.userModel.yearsToReturn} Years"),
                  InfoCard(
                      title: "Total Puhunan",
                      desc: controller.tInvestment.toCurrencyString(leadingSymbol: '₱')),
                  InfoCard(
                      title: "Total Kita",
                      desc: controller.tInterest.toCurrencyString(leadingSymbol: '₱')),
                ],
              ),
              // const SizedBox(height: 20.0),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: CustomButton(
              //     btnText: "Next",
              //     onTap: () {},
              //     btnColor: Colors.white,
              //     borderColor: Colors.white,
              //   ),
              // ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomButton(
                    btnText: "LOGOUT",
                    onTap: () {
                      Get.find<AuthManager>().logoutAndRemoveToken();
                    }),
              ),
              const SizedBox(height: 20.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "The content of this app is not an investment advise and does not constitute any offer or solicitation or offer or recommendation of any investment product.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        );
      }),
    );
  }

  TextStyle tStyle() {
    return poppinsMedium.copyWith(fontSize: 14, color: Colors.white);
  }

  Widget introCard({double avatarRadius = 65}) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: avatarRadius * 2 - 10,
                  ),
                  Expanded(
                      child: Text(
                    'Your risk profile is'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(fontSize: 20.0, height: 1.0, color: Colors.white),
                  )),
                ],
              ),
            ),
            MyRoundCard(
                padding: 0.0,
                color: Colors.amberAccent,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: avatarRadius * 1.2),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 20, 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: avatarRadius * 2 - 10,
                        ),
                        Expanded(
                            child: Text(
                          controller.category.value?.toUpperCase() ?? '',
                          textAlign: TextAlign.center,
                          style: poppinsMedium.copyWith(
                              fontSize: 25.0, height: 1.0, color: Colors.blueAccent),
                        ))
                      ],
                    ),
                  ),
                ))
          ],
        ),
        Positioned(
          left: -5,
          child: CircleAvatar(
            radius: avatarRadius,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: avatarRadius - 5,
              backgroundImage: const AssetImage('assets/images/user.png'),
              foregroundImage: (controller.userModel.picture != null)
                  ? MemoryImage(PicUtility.dataFromBase64String(controller.userModel.picture!))
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget kayamananCard() {
    return MyRoundCard(
      color: Colors.amberAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "YOUR FUTURE KAYAMANAN WHEN YOU'RE BACK TO THE PHILIPPINES".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(fontSize: 16.0, height: 1.0, color: Colors.black),
                  ),
                  Text(
                    controller.fv.toCurrencyString(leadingSymbol: '₱'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20.0, color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20.0),
            CircleAvatar(
              backgroundColor: Colors.white,
              // backgroundImage: AssetImage('assets/images/rocket.png',),
              radius: 50,
              child: Image.asset(
                'assets/images/rocket.png',
                width: 50,
                height: 50,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<ChartLayer> layers() {
    List<MyChartDatumModel> d = controller.myChartData;
    return [
      ChartGridLayer(
          settings: ChartGridSettings(
        x: ChartGridSettingsAxis(
          color: Colors.white.withOpacity(0.2),
          frequency: 1.0,
          max: d.last.myX.toDouble(),
          min: d.first.myX.toDouble(),
        ),
        y: ChartGridSettingsAxis(
          color: Colors.white.withOpacity(0.2),
          frequency: controller.maxY / 10,
          max: controller.maxY,
          min: 0.0,
        ),
      )),
      ChartAxisLayer(
        settings: ChartAxisSettings(
          x: ChartAxisSettingsAxis(
            frequency: 1.0,
            // max: 12.0,
            // min: 7.0,
            max: d.last.myX.toDouble(),
            min: d.first.myX.toDouble(),
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
          y: ChartAxisSettingsAxis(
            // frequency: 100.0,
            // max: 300.0,
            // min: 0.0,
            frequency: controller.maxY / 10,
            max: controller.maxY,
            min: 0.0,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
        labelX: (value) => value.toInt().toString(),
        labelY: (value) => value.toInt().toString(),
      ),
      ChartGroupBarLayer(
        items: List.generate(
          d.length,
          (index) => [
            ChartGroupBarDataItem(
              // color: const Color(0xFF8043F9),
              color: puhunanColor,
              x: index.toDouble() + 1,
              value: d[index].myY1,
            ),
            ChartGroupBarDataItem(
              // color: const Color(0xFFFF4150),
              color: kitaColor,
              x: index.toDouble() + 1,
              value: d[index].myY2,
            ),
          ],
        ),
        settings: const ChartGroupBarSettings(
          thickness: 8.0,
          radius: BorderRadius.all(Radius.circular(4.0)),
        ),
      ),
      ChartTooltipLayer(
        shape: () => ChartTooltipBarShape<ChartGroupBarDataItem>(
          backgroundColor: Colors.white,
          currentPos: (item) => item.currentValuePos,
          currentSize: (item) => item.currentValueSize,
          onTextValue: (item) => '₱ ${item.value.toStringAsFixed(2)}',
          marginBottom: 6.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 8.0,
          ),
          radius: 6.0,
          textStyle: TextStyle(
            // color: Color(0xFF8043F9),
            color: kitaColor,
            letterSpacing: 0.2,
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ];
  }

  Widget chartToRun() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions(

      labelCommonOptions: LabelCommonOptions(labelTextColor: Colors.white),

      legendOptions: LegendOptions(legendColorIndicatorWidth: 20.0),
      dataContainerOptions: DataContainerOptions(
        gridStepWidthPortionUsedByAtomicPresenter: 0.75,

        gridLinesColor: Colors.white,
      ),

      yContainerOptions: YContainerOptions(
        // isYContainerShown:true,
        // isYGridlinesShown:true,
        yLeftMinTicksWidth: 0.0,
        yRightMinTicksWidth: 0.0,

        // yLabelUnits: ""

      ),
    );
    xContainerLabelLayoutStrategy = DefaultIterativeLabelLayoutStrategy(options: chartOptions);
    chartData = ChartData(
        dataRows: [
          controller.total_inv,
          controller.myChartData.map((e) => e.myY2 - e.myY1).toList(),
        ],
        dataRowsColors: [puhunanColor, kitaColor],
        xUserLabels: controller.total_years.map((e) => e.toString()).toList(),
        // yUserLabels: [...(controller.total_profit.map((e) => e.toStringAsFixed(0)).toList()),],
        dataRowsLegends: ['Puhunan', 'Kita'],
        chartOptions: chartOptions);
    // chartData.dataRowsDefaultColors(); // if not set, called in constructor
    var verticalBarChartContainer = VerticalBarChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );
    var verticalBarChart = VerticalBarChart(
      painter: VerticalBarChartPainter(
        verticalBarChartContainer: verticalBarChartContainer,
      ),
    );
    return verticalBarChart;
  }
// Widget chartToRun() {
//   LabelLayoutStrategy? xContainerLabelLayoutStrategy;
//   ChartData chartData;
//   ChartOptions chartOptions = const ChartOptions();
//   // Set chart options to show no labels
//   chartOptions = const ChartOptions.noLabels();
//
//   chartData = ChartData(
//     dataRows: const [
//       [10.0, 20.0, 5.0, 30.0, 5.0, 20.0],
//       [30.0, 60.0, 16.0, 100.0, 12.0, 120.0],
//       [25.0, 40.0, 20.0, 80.0, 12.0, 90.0],
//       [12.0, 30.0, 18.0, 40.0, 10.0, 30.0],
//     ],
//     xUserLabels: const ['Wolf', 'Deer', 'Owl', 'Mouse', 'Hawk', 'Vole'],
//     dataRowsLegends: const [
//       'Spring',
//       'Summer',
//       'Fall',
//       'Winter',
//     ],
//     chartOptions: chartOptions,
//   );
//   var verticalBarChartContainer = VerticalBarChartTopContainer(
//     chartData: chartData,
//     xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
//   );
//
//   var verticalBarChart = VerticalBarChart(
//     painter: VerticalBarChartPainter(
//       verticalBarChartContainer: verticalBarChartContainer,
//     ),
//   );
//   return verticalBarChart;
// }
}

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.title, required this.desc}) : super(key: key);
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: MyRoundCard(
        padding: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 50.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                color: Colors.amberAccent,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 5),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: poppinsMedium.copyWith(fontSize: 16.0, color: Colors.black, height: 1.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 50.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                        height: 1.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
