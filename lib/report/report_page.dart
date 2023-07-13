import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:mosaico/home/drawer_home_page.dart';
import 'package:mosaico/utils/usertype_page.dart';
import 'package:quiver/iterables.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatelessWidget {
  ReportPage({Key? key, required this.user}) : super(key: key);

  Size get preferredSize => const Size.fromHeight(80);
  final UserType user;
  final _monthDayFormat = DateFormat('MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: preferredSize.height,
        centerTitle: true,
        title: const Text(
          'Relatórios',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(child: _body(context)),
      endDrawer: DrawerHomePage(user: user),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Relatórios',
            style: TextStyle(color: Colors.blue, fontSize: 20),
          ),
        ),
        const Divider(
          indent: 24,
          endIndent: 24,
          color: Colors.grey,
        ),
        _report('Consulta realizada 10/07/2023', 'assets/professional.jpg'),
        _report('Consulta realizada 05/07/2023', 'assets/responsible.jpg'),
        _report('Consulta realizada 28/06/2023', 'assets/professional.jpg'),
        _report('Consulta realizada 26/06/2023', 'assets/responsible.jpg'),
        const Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Gráficos',
            style: TextStyle(color: Colors.blue, fontSize: 20),
          ),
        ),
        const Divider(
          indent: 24,
          endIndent: 24,
          color: Colors.grey,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          width: 350,
          height: 300,
          child: Chart(
            data: areaStackGradientData,
            variables: {
              'day': Variable(
                accessor: (Map datum) => datum['day'] as String,
                scale: OrdinalScale(inflate: true),
              ),
              'value': Variable(
                accessor: (Map datum) => datum['value'] as num,
                scale: LinearScale(min: 0, max: 1500),
              ),
              'group': Variable(
                accessor: (Map datum) => datum['group'].toString(),
              ),
            },
            marks: [
              AreaMark(
                position: Varset('day') * Varset('value') / Varset('group'),
                shape: ShapeEncode(value: BasicAreaShape(smooth: true)),
                gradient: GradientEncode(
                  variable: 'group',
                  values: [
                    const LinearGradient(
                      begin: Alignment(0, 0),
                      end: Alignment(0, 1),
                      colors: [
                        Color.fromARGB(204, 128, 255, 165),
                        Color.fromARGB(204, 1, 191, 236),
                      ],
                    ),
                    const LinearGradient(
                      begin: Alignment(0, 0),
                      end: Alignment(0, 1),
                      colors: [
                        Color.fromARGB(204, 0, 221, 255),
                        Color.fromARGB(204, 77, 119, 255),
                      ],
                    ),
                    const LinearGradient(
                      begin: Alignment(0, 0),
                      end: Alignment(0, 1),
                      colors: [
                        Color.fromARGB(204, 55, 162, 255),
                        Color.fromARGB(204, 116, 21, 219),
                      ],
                    ),
                    const LinearGradient(
                      begin: Alignment(0, 0),
                      end: Alignment(0, 1),
                      colors: [
                        Color.fromARGB(204, 255, 0, 135),
                        Color.fromARGB(204, 135, 0, 157),
                      ],
                    ),
                    const LinearGradient(
                      begin: Alignment(0, 0),
                      end: Alignment(0, 1),
                      colors: [
                        Color.fromARGB(204, 255, 191, 0),
                        Color.fromARGB(204, 224, 62, 76),
                      ],
                    ),
                  ],
                  updaters: {
                    'groupMouse': {
                      false: (gradient) => LinearGradient(
                            begin: const Alignment(0, 0),
                            end: const Alignment(0, 1),
                            colors: [
                              gradient.colors.first.withAlpha(25),
                              gradient.colors.last.withAlpha(25),
                            ],
                          ),
                    },
                    'groupTouch': {
                      false: (gradient) => LinearGradient(
                            begin: const Alignment(0, 0),
                            end: const Alignment(0, 1),
                            colors: [
                              gradient.colors.first.withAlpha(25),
                              gradient.colors.last.withAlpha(25),
                            ],
                          ),
                    },
                  },
                ),
                modifiers: [StackModifier()],
              ),
            ],
            axes: [
              Defaults.horizontalAxis,
              Defaults.verticalAxis,
            ],
            selections: {
              'tooltipMouse': PointSelection(on: {
                GestureType.hover,
              }, devices: {
                PointerDeviceKind.mouse
              }, variable: 'day'),
              'groupMouse': PointSelection(
                  on: {
                    GestureType.hover,
                  },
                  variable: 'group',
                  devices: {PointerDeviceKind.mouse}),
              'tooltipTouch':
                  PointSelection(on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate}, devices: {PointerDeviceKind.touch}, variable: 'day'),
              'groupTouch':
                  PointSelection(on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate}, variable: 'group', devices: {PointerDeviceKind.touch}),
            },
            tooltip: TooltipGuide(
              selections: {'tooltipTouch', 'tooltipMouse'},
              followPointer: [true, true],
              align: Alignment.topLeft,
            ),
            crosshair: CrosshairGuide(
              selections: {'tooltipTouch', 'tooltipMouse'},
              followPointer: [false, true],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          width: 350,
          height: 300,
          child: Chart(
            data: timeSeriesSales,
            variables: {
              'time': Variable(
                accessor: (TimeSeriesSales datum) => datum.time,
                scale: TimeScale(
                  formatter: (time) => _monthDayFormat.format(time),
                ),
              ),
              'sales': Variable(
                accessor: (TimeSeriesSales datum) => datum.sales,
              ),
            },
            marks: [
              LineMark(
                shape: ShapeEncode(value: BasicLineShape(dash: [5, 2])),
                selected: {
                  'touchMove': {1}
                },
              )
            ],
            coord: RectCoord(color: const Color(0xffdddddd)),
            axes: [
              Defaults.horizontalAxis,
              Defaults.verticalAxis,
            ],
            selections: {
              'touchMove': PointSelection(
                on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
                dim: Dim.x,
              )
            },
            tooltip: TooltipGuide(
              followPointer: [false, true],
              align: Alignment.topLeft,
              offset: const Offset(-20, -20),
            ),
            crosshair: CrosshairGuide(followPointer: [false, true]),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          width: 350,
          height: 300,
          child: Chart(
            data: invalidData,
            variables: {
              'Date': Variable(
                accessor: (Map map) => map['Date'] as String,
                scale: OrdinalScale(tickCount: 5),
              ),
              'Close': Variable(
                accessor: (Map map) => (map['Close'] ?? double.nan) as num,
              ),
            },
            marks: [
              AreaMark(
                shape: ShapeEncode(value: BasicAreaShape(smooth: true)),
                color: ColorEncode(value: Defaults.colors10.first.withAlpha(80)),
              ),
              LineMark(
                shape: ShapeEncode(value: BasicLineShape(smooth: true)),
                size: SizeEncode(value: 0.5),
              ),
            ],
            axes: [
              Defaults.horizontalAxis,
              Defaults.verticalAxis,
            ],
            selections: {
              'touchMove': PointSelection(
                on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate},
                dim: Dim.x,
              )
            },
            tooltip: TooltipGuide(
              followPointer: [false, true],
              align: Alignment.topLeft,
              offset: const Offset(-20, -20),
            ),
            crosshair: CrosshairGuide(followPointer: [false, true]),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          width: 350,
          height: 300,
          child: Chart(
            data: complexGroupData,
            variables: {
              'date': Variable(
                accessor: (Map map) => map['date'] as String,
                scale: OrdinalScale(tickCount: 5, inflate: true),
              ),
              'points': Variable(
                accessor: (Map map) => map['points'] as num,
              ),
              'name': Variable(
                accessor: (Map map) => map['name'] as String,
              ),
            },
            coord: RectCoord(horizontalRange: [0.01, 0.99]),
            marks: [
              LineMark(
                position: Varset('date') * Varset('points') / Varset('name'),
                shape: ShapeEncode(value: BasicLineShape(smooth: true)),
                size: SizeEncode(value: 0.5),
                color: ColorEncode(
                  variable: 'name',
                  values: Defaults.colors10,
                  updaters: {
                    'groupMouse': {false: (color) => color.withAlpha(100)},
                    'groupTouch': {false: (color) => color.withAlpha(100)},
                  },
                ),
              ),
              PointMark(
                color: ColorEncode(
                  variable: 'name',
                  values: Defaults.colors10,
                  updaters: {
                    'groupMouse': {false: (color) => color.withAlpha(100)},
                    'groupTouch': {false: (color) => color.withAlpha(100)},
                  },
                ),
              ),
            ],
            axes: [
              Defaults.horizontalAxis,
              Defaults.verticalAxis,
            ],
            selections: {
              'tooltipMouse': PointSelection(on: {
                GestureType.hover,
              }, devices: {
                PointerDeviceKind.mouse
              }),
              'groupMouse': PointSelection(
                  on: {
                    GestureType.hover,
                  },
                  variable: 'name',
                  devices: {PointerDeviceKind.mouse}),
              'tooltipTouch': PointSelection(on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate}, devices: {PointerDeviceKind.touch}),
              'groupTouch':
                  PointSelection(on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate}, variable: 'name', devices: {PointerDeviceKind.touch}),
            },
            tooltip: TooltipGuide(
              selections: {'tooltipTouch', 'tooltipMouse'},
              followPointer: [true, true],
              align: Alignment.topLeft,
              mark: 0,
              variables: [
                'date',
                'name',
                'points',
              ],
            ),
            crosshair: CrosshairGuide(
              selections: {'tooltipTouch', 'tooltipMouse'},
              styles: [
                PaintStyle(strokeColor: const Color(0xffbfbfbf)),
                PaintStyle(strokeColor: const Color(0x00bfbfbf)),
              ],
              followPointer: [true, false],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          width: 350,
          height: 300,
          child: Chart(
            data: pointBigData,
            variables: {
              'x': Variable(
                accessor: (List<num> datumn) => datumn[0],
                scale: LinearScale(min: 0, max: 1),
              ),
              'y': Variable(
                accessor: (List<num> datumn) => datumn[1],
                scale: LinearScale(min: 0, max: 1),
              ),
              'size': Variable(
                accessor: (List<num> datumn) => datumn[2],
              ),
              'color': Variable(
                accessor: (List<num> datumn) => datumn[3],
              ),
            },
            marks: [
              PointMark(
                  size: SizeEncode(variable: 'size', values: [1, 4]),
                  color: ColorEncode(variable: 'color', values: [
                    const Color(0xffbae7ff),
                    const Color(0xff0050b3),
                  ]))
            ],
            axes: [
              Defaults.horizontalAxis,
              Defaults.verticalAxis,
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          width: 350,
          height: 300,
          child: Chart(
            data: basicData,
            variables: {
              'genre': Variable(
                accessor: (Map map) => map['genre'] as String,
              ),
              'sold': Variable(
                accessor: (Map map) => map['sold'] as num,
              ),
            },
            marks: [
              IntervalMark(
                label: LabelEncode(encoder: (tuple) => Label(tuple['sold'].toString())),
                elevation: ElevationEncode(value: 0, updaters: {
                  'tap': {true: (_) => 5}
                }),
                color: ColorEncode(value: Defaults.primaryColor, updaters: {
                  'tap': {false: (color) => color.withAlpha(100)}
                }),
              )
            ],
            axes: [
              Defaults.horizontalAxis,
              Defaults.verticalAxis,
            ],
            selections: {'tap': PointSelection(dim: Dim.x)},
            tooltip: TooltipGuide(),
            crosshair: CrosshairGuide(),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          width: 350,
          height: 300,
          child: Chart(
            data: basicData,
            variables: {
              'genre': Variable(
                accessor: (Map map) => map['genre'] as String,
              ),
              'sold': Variable(
                accessor: (Map map) => map['sold'] as num,
              ),
            },
            marks: [
              IntervalMark(
                label: LabelEncode(encoder: (tuple) => Label(tuple['sold'].toString())),
                gradient: GradientEncode(
                    value: const LinearGradient(colors: [
                      Color(0x8883bff6),
                      Color(0x88188df0),
                      Color(0xcc188df0),
                    ], stops: [
                      0,
                      0.5,
                      1
                    ]),
                    updaters: {
                      'tap': {
                        true: (_) => const LinearGradient(colors: [
                              Color(0xee83bff6),
                              Color(0xee3f78f7),
                              Color(0xff3f78f7),
                            ], stops: [
                              0,
                              0.7,
                              1
                            ])
                      }
                    }),
              )
            ],
            coord: RectCoord(transposed: true),
            axes: [
              Defaults.verticalAxis
                ..line = Defaults.strokeStyle
                ..grid = null,
              Defaults.horizontalAxis
                ..line = null
                ..grid = Defaults.strokeStyle,
            ],
            selections: {'tap': PointSelection(dim: Dim.x)},
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          width: 350,
          height: 300,
          child: Chart(
            data: lineMarkerData,
            variables: {
              'day': Variable(
                accessor: (Map datum) => datum['day'] as String,
                scale: OrdinalScale(inflate: true),
              ),
              'value': Variable(
                accessor: (Map datum) => datum['value'] as num,
                scale: LinearScale(
                  max: 15,
                  min: -3,
                  tickCount: 7,
                  formatter: (v) => '${v.toInt()} ℃',
                ),
              ),
              'group': Variable(
                accessor: (Map datum) => datum['group'] as String,
              ),
            },
            marks: [
              LineMark(
                position: Varset('day') * Varset('value') / Varset('group'),
                color: ColorEncode(
                  variable: 'group',
                  values: [
                    const Color(0xff5470c6),
                    const Color(0xff91cc75),
                  ],
                ),
              ),
            ],
            axes: [
              Defaults.horizontalAxis,
              Defaults.verticalAxis,
            ],
            selections: {
              'tooltipMouse': PointSelection(on: {
                GestureType.hover,
              }, devices: {
                PointerDeviceKind.mouse
              }, variable: 'day', dim: Dim.x),
              'tooltipTouch': PointSelection(
                  on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate}, devices: {PointerDeviceKind.touch}, variable: 'day', dim: Dim.x),
            },
            tooltip: TooltipGuide(
              followPointer: [true, true],
              align: Alignment.topLeft,
              variables: ['group', 'value'],
            ),
            crosshair: CrosshairGuide(
              followPointer: [false, true],
            ),
            annotations: [
              LineAnnotation(
                dim: Dim.y,
                value: 11.14,
                style: PaintStyle(
                  strokeColor: const Color(0xff5470c6).withAlpha(100),
                  dash: [2],
                ),
              ),
              LineAnnotation(
                dim: Dim.y,
                value: 1.57,
                style: PaintStyle(
                  strokeColor: const Color(0xff91cc75).withAlpha(100),
                  dash: [2],
                ),
              ),
              CustomAnnotation(renderer: (offset, _) => [CircleElement(center: offset, radius: 5, style: PaintStyle(fillColor: const Color(0xff5470c6)))], values: ['Wed', 13]),
              CustomAnnotation(renderer: (offset, _) => [CircleElement(center: offset, radius: 5, style: PaintStyle(fillColor: const Color(0xff5470c6)))], values: ['Sun', 9]),
              CustomAnnotation(renderer: (offset, _) => [CircleElement(center: offset, radius: 5, style: PaintStyle(fillColor: const Color(0xff91cc75)))], values: ['Tue', -2]),
              CustomAnnotation(renderer: (offset, _) => [CircleElement(center: offset, radius: 5, style: PaintStyle(fillColor: const Color(0xff91cc75)))], values: ['Thu', 5]),
              TagAnnotation(
                label: Label(
                    '13',
                    LabelStyle(
                      textStyle: Defaults.textStyle,
                      offset: const Offset(0, -10),
                    )),
                values: ['Wed', 13],
              ),
              TagAnnotation(
                label: Label(
                    '9',
                    LabelStyle(
                      textStyle: Defaults.textStyle,
                      offset: const Offset(0, -10),
                    )),
                values: ['Sun', 9],
              ),
              TagAnnotation(
                label: Label(
                    '-2',
                    LabelStyle(
                      textStyle: Defaults.textStyle,
                      offset: const Offset(0, -10),
                    )),
                values: ['Tue', -2],
              ),
              TagAnnotation(
                label: Label(
                    '5',
                    LabelStyle(
                      textStyle: Defaults.textStyle,
                      offset: const Offset(0, -10),
                    )),
                values: ['Thu', 5],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          width: 350,
          height: 300,
          child: Chart(
            data: zip(lineSectionsData).toList(),
            variables: {
              'time': Variable(
                accessor: (List datum) => datum[0] as String,
                scale: OrdinalScale(inflate: true, tickCount: 6),
              ),
              'value': Variable(
                accessor: (List datum) => datum[1] as num,
                scale: LinearScale(
                  max: 800,
                  min: 0,
                  formatter: (v) => '${v.toInt()} W',
                ),
              ),
            },
            marks: [
              LineMark(
                shape: ShapeEncode(value: BasicLineShape(smooth: true)),
              )
            ],
            axes: [
              Defaults.horizontalAxis,
              Defaults.verticalAxis,
            ],
            selections: {
              'tooltipMouse': PointSelection(on: {
                GestureType.hover,
              }, devices: {
                PointerDeviceKind.mouse
              }, dim: Dim.x),
              'tooltipTouch': PointSelection(on: {GestureType.scaleUpdate, GestureType.tapDown, GestureType.longPressMoveUpdate}, devices: {PointerDeviceKind.touch}, dim: Dim.x),
            },
            tooltip: TooltipGuide(
              followPointer: [true, true],
              align: Alignment.topLeft,
            ),
            crosshair: CrosshairGuide(
              followPointer: [false, true],
            ),
            annotations: [
              RegionAnnotation(
                values: ['07:30', '10:00'],
                color: const Color.fromARGB(120, 255, 173, 177),
              ),
              RegionAnnotation(
                values: ['17:30', '21:15'],
                color: const Color.fromARGB(120, 255, 173, 177),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _report(String text, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(image),
                radius: 25,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.chevron_right,
                    color: Colors.orange,
                  )),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}

const areaStackGradientData = [
  {'day': 'Mon', 'value': 140, 'group': 1},
  {'day': 'Tue', 'value': 232, 'group': 1},
  {'day': 'Wed', 'value': 101, 'group': 1},
  {'day': 'Thu', 'value': 264, 'group': 1},
  {'day': 'Fri', 'value': 90, 'group': 1},
  {'day': 'Sat', 'value': 340, 'group': 1},
  {'day': 'Sun', 'value': 250, 'group': 1},
  {'day': 'Mon', 'value': 120, 'group': 2},
  {'day': 'Tue', 'value': 282, 'group': 2},
  {'day': 'Wed', 'value': 111, 'group': 2},
  {'day': 'Thu', 'value': 234, 'group': 2},
  {'day': 'Fri', 'value': 220, 'group': 2},
  {'day': 'Sat', 'value': 340, 'group': 2},
  {'day': 'Sun', 'value': 310, 'group': 2},
  {'day': 'Mon', 'value': 320, 'group': 3},
  {'day': 'Tue', 'value': 132, 'group': 3},
  {'day': 'Wed', 'value': 201, 'group': 3},
  {'day': 'Thu', 'value': 334, 'group': 3},
  {'day': 'Fri', 'value': 190, 'group': 3},
  {'day': 'Sat', 'value': 130, 'group': 3},
  {'day': 'Sun', 'value': 220, 'group': 3},
  {'day': 'Mon', 'value': 220, 'group': 4},
  {'day': 'Tue', 'value': 402, 'group': 4},
  {'day': 'Wed', 'value': 231, 'group': 4},
  {'day': 'Thu', 'value': 134, 'group': 4},
  {'day': 'Fri', 'value': 190, 'group': 4},
  {'day': 'Sat', 'value': 230, 'group': 4},
  {'day': 'Sun', 'value': 120, 'group': 4},
  {'day': 'Mon', 'value': 220, 'group': 5},
  {'day': 'Tue', 'value': 302, 'group': 5},
  {'day': 'Wed', 'value': 181, 'group': 5},
  {'day': 'Thu', 'value': 234, 'group': 5},
  {'day': 'Fri', 'value': 210, 'group': 5},
  {'day': 'Sat', 'value': 290, 'group': 5},
  {'day': 'Sun', 'value': 150, 'group': 5},
];

const invalidData = [
  {"Date": "04.01.2016", "Close": 126.12},
  {"Date": "05.01.2016", "Close": 125.688},
  {"Date": "06.01.2016", "Close": 119.704},
  {"Date": "07.01.2016", "Close": 120.19},
  {"Date": "08.01.2016", "Close": 121.157},
  {"Date": "11.01.2016", "Close": 117},
  {"Date": "12.01.2016", "Close": 120},
  {"Date": "13.01.2016", "Close": 122},
  {"Date": "14.01.2016", "Close": 117.76},
  {"Date": "15.01.2016", "Close": 114.397},
  {"Date": "18.01.2016", "Close": 116.373},
  {"Date": "19.01.2016", "Close": 120.547},
  {"Date": "20.01.2016", "Close": 113.733},
  {"Date": "21.01.2016", "Close": 114.098},
  {"Date": "22.01.2016", "Close": 123.833},
  {"Date": "25.01.2016", "Close": 125},
  {"Date": "26.01.2016", "Close": 124.866},
  {"Date": "27.01.2016", "Close": 120.264},
  {"Date": "28.01.2016", "Close": 122.296},
  {"Date": "29.01.2016", "Close": 124.502},
  {"Date": "01.02.2016", "Close": 127.936},
  {"Date": "02.02.2016", "Close": null},
  {"Date": "03.02.2016", "Close": 129.95},
  {"Date": "04.02.2016", "Close": 129.275},
  {"Date": "05.02.2016", "Close": 127.898},
  {"Date": "08.02.2016", "Close": 134.9},
  {"Date": "09.02.2016", "Close": 122.819},
  {"Date": "10.02.2016", "Close": 120.108},
  {"Date": "11.02.2016", "Close": 119.447},
  {"Date": "12.02.2016", "Close": 117.8},
  {"Date": "15.02.2016", "Close": 122.8},
  {"Date": "16.02.2016", "Close": 121.865},
  {"Date": "17.02.2016", "Close": 126.3},
  {"Date": "18.02.2016", "Close": 128.259},
  {"Date": "19.02.2016", "Close": 125.724},
  {"Date": "22.02.2016", "Close": 130},
  {"Date": "23.02.2016", "Close": 129.948},
  {"Date": "24.02.2016", "Close": 132.5},
  {"Date": "25.02.2016", "Close": 128.08},
  {"Date": "26.02.2016", "Close": 122},
  {"Date": "29.02.2016", "Close": 122},
  {"Date": "01.03.2016", "Close": 123.449},
  {"Date": "02.03.2016", "Close": double.nan},
  {"Date": "03.03.2016", "Close": 132},
  {"Date": "04.03.2016", "Close": 135},
  {"Date": "07.03.2016", "Close": 123.905},
  {"Date": "08.03.2016", "Close": 125.155},
  {"Date": "09.03.2016", "Close": 126},
  {"Date": "10.03.2016", "Close": 126.778},
  {"Date": "11.03.2016", "Close": 129.656},
  {"Date": "14.03.2016", "Close": 127.64},
  {"Date": "15.03.2016", "Close": 124.786},
  {"Date": "16.03.2016", "Close": 124.469},
  {"Date": "17.03.2016", "Close": 123.5},
  {"Date": "18.03.2016", "Close": 124.061},
  {"Date": "21.03.2016", "Close": 123.5},
  {"Date": "22.03.2016", "Close": 129.002},
  {"Date": "23.03.2016", "Close": 129},
  {"Date": "24.03.2016", "Close": 131.31},
  {"Date": "29.03.2016", "Close": 133},
  {"Date": "30.03.2016", "Close": 129.298},
  {"Date": "31.03.2016", "Close": 127.4},
  {"Date": "01.04.2016", "Close": 122.376},
  {"Date": "04.04.2016", "Close": 119.467},
  {"Date": "05.04.2016", "Close": 120.695},
  {"Date": "06.04.2016", "Close": 118.725},
  {"Date": "07.04.2016", "Close": 127.539},
  {"Date": "08.04.2016", "Close": 129.8},
  {"Date": "11.04.2016", "Close": 129.5},
  {"Date": "12.04.2016", "Close": 134.465},
  {"Date": "13.04.2016", "Close": 133},
  {"Date": "14.04.2016", "Close": 137.35},
  {"Date": "15.04.2016", "Close": 137.2},
  {"Date": "18.04.2016", "Close": 132.611},
  {"Date": "19.04.2016", "Close": 135.479},
  {"Date": "20.04.2016", "Close": 139.05},
  {"Date": "21.04.2016", "Close": 142},
  {"Date": "22.04.2016", "Close": 135.761},
  {"Date": "25.04.2016", "Close": 136.174},
  {"Date": "26.04.2016", "Close": 134.782},
  {"Date": "27.04.2016", "Close": 128},
  {"Date": "28.04.2016", "Close": 121.5},
  {"Date": "29.04.2016", "Close": 120},
  {"Date": "02.05.2016", "Close": 123.966},
  {"Date": "03.05.2016", "Close": 122.538},
  {"Date": "04.05.2016", "Close": 120},
  {"Date": "05.05.2016", "Close": 120.21},
  {"Date": "06.05.2016", "Close": 121.01},
  {"Date": "09.05.2016", "Close": double.nan},
  {"Date": "10.05.2016", "Close": 120.622},
  {"Date": "11.05.2016", "Close": 123.85},
  {"Date": "12.05.2016", "Close": 122.963},
  {"Date": "13.05.2016", "Close": 126},
  {"Date": "17.05.2016", "Close": 130},
  {"Date": "18.05.2016", "Close": 128.845},
  {"Date": "19.05.2016", "Close": 130.17},
  {"Date": "20.05.2016", "Close": 129.741},
  {"Date": "23.05.2016", "Close": 129.668},
  {"Date": "24.05.2016", "Close": 126.886},
  {"Date": "25.05.2016", "Close": 128.239},
  {"Date": "26.05.2016", "Close": 127.239},
  {"Date": "27.05.2016", "Close": 127.457},
  {"Date": "30.05.2016", "Close": 127.37},
  {"Date": "31.05.2016", "Close": 130.756},
  {"Date": "01.06.2016", "Close": 133.232},
  {"Date": "02.06.2016", "Close": 126.47},
  {"Date": "03.06.2016", "Close": 126.385},
  {"Date": "06.06.2016", "Close": 128.331},
  {"Date": "07.06.2016", "Close": 130.914},
  {"Date": "08.06.2016", "Close": 133},
  {"Date": "09.06.2016", "Close": 133.041},
  {"Date": "10.06.2016", "Close": 133.041},
  {"Date": "13.06.2016", "Close": 129},
  {"Date": "14.06.2016", "Close": 129.166},
  {"Date": "15.06.2016", "Close": 124.687},
  {"Date": "16.06.2016", "Close": 122.77},
  {"Date": "17.06.2016", "Close": 126.461},
  {"Date": "20.06.2016", "Close": 127},
  {"Date": "21.06.2016", "Close": 125.594},
  {"Date": "22.06.2016", "Close": 127.438},
  {"Date": "23.06.2016", "Close": 124.44},
  {"Date": "24.06.2016", "Close": 122.131},
  {"Date": "27.06.2016", "Close": 120.53},
  {"Date": "28.06.2016", "Close": 120.296},
  {"Date": "29.06.2016", "Close": 125.877},
  {"Date": "30.06.2016", "Close": 126.404},
];

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}

final timeSeriesSales = [
  TimeSeriesSales(DateTime(2017, 9, 19), 5),
  TimeSeriesSales(DateTime(2017, 9, 26), 25),
  TimeSeriesSales(DateTime(2017, 10, 3), 100),
  TimeSeriesSales(DateTime(2017, 10, 10), 75),
];

const complexGroupData = [
  {'date': '2021-10-01', 'name': 'Liam', 'points': 1468},
  {'date': '2021-10-01', 'name': 'Oliver', 'points': 1487},
  {'date': '2021-10-01', 'name': 'Elijah', 'points': 1494},
  {'date': '2021-10-02', 'name': 'Liam', 'points': 1526},
  {'date': '2021-10-02', 'name': 'Noah', 'points': 1492},
  {'date': '2021-10-02', 'name': 'Oliver', 'points': 1470},
  {'date': '2021-10-02', 'name': 'Elijah', 'points': 1477},
  {'date': '2021-10-03', 'name': 'Liam', 'points': 1466},
  {'date': '2021-10-03', 'name': 'Noah', 'points': 1465},
  {'date': '2021-10-03', 'name': 'Oliver', 'points': 1524},
  {'date': '2021-10-03', 'name': 'Elijah', 'points': 1534},
  {'date': '2021-10-04', 'name': 'Noah', 'points': 1504},
  {'date': '2021-10-04', 'name': 'Elijah', 'points': 1524},
  {'date': '2021-10-05', 'name': 'Oliver', 'points': 1534},
  {'date': '2021-10-06', 'name': 'Noah', 'points': 1463},
  {'date': '2021-10-07', 'name': 'Liam', 'points': 1502},
  {'date': '2021-10-07', 'name': 'Noah', 'points': 1539},
  {'date': '2021-10-08', 'name': 'Liam', 'points': 1476},
  {'date': '2021-10-08', 'name': 'Noah', 'points': 1483},
  {'date': '2021-10-08', 'name': 'Oliver', 'points': 1534},
  {'date': '2021-10-08', 'name': 'Elijah', 'points': 1530},
  {'date': '2021-10-09', 'name': 'Noah', 'points': 1519},
  {'date': '2021-10-09', 'name': 'Oliver', 'points': 1497},
  {'date': '2021-10-09', 'name': 'Elijah', 'points': 1460},
  {'date': '2021-10-10', 'name': 'Liam', 'points': 1514},
  {'date': '2021-10-10', 'name': 'Noah', 'points': 1518},
  {'date': '2021-10-10', 'name': 'Oliver', 'points': 1470},
  {'date': '2021-10-10', 'name': 'Elijah', 'points': 1526},
  {'date': '2021-10-11', 'name': 'Liam', 'points': 1517},
  {'date': '2021-10-11', 'name': 'Noah', 'points': 1478},
  {'date': '2021-10-11', 'name': 'Oliver', 'points': 1468},
  {'date': '2021-10-11', 'name': 'Elijah', 'points': 1487},
  {'date': '2021-10-12', 'name': 'Liam', 'points': 1535},
  {'date': '2021-10-12', 'name': 'Noah', 'points': 1537},
  {'date': '2021-10-12', 'name': 'Oliver', 'points': 1463},
  {'date': '2021-10-12', 'name': 'Elijah', 'points': 1478},
  {'date': '2021-10-13', 'name': 'Oliver', 'points': 1524},
  {'date': '2021-10-13', 'name': 'Elijah', 'points': 1496},
  {'date': '2021-10-14', 'name': 'Liam', 'points': 1527},
  {'date': '2021-10-14', 'name': 'Oliver', 'points': 1527},
  {'date': '2021-10-14', 'name': 'Elijah', 'points': 1462},
  {'date': '2021-10-15', 'name': 'Liam', 'points': 1532},
  {'date': '2021-10-15', 'name': 'Noah', 'points': 1509},
  {'date': '2021-10-15', 'name': 'Oliver', 'points': 1540},
  {'date': '2021-10-15', 'name': 'Elijah', 'points': 1536},
  {'date': '2021-10-16', 'name': 'Liam', 'points': 1480},
  {'date': '2021-10-16', 'name': 'Elijah', 'points': 1533},
  {'date': '2021-10-17', 'name': 'Noah', 'points': 1515},
  {'date': '2021-10-17', 'name': 'Oliver', 'points': 1518},
  {'date': '2021-10-17', 'name': 'Elijah', 'points': 1515},
  {'date': '2021-10-18', 'name': 'Oliver', 'points': 1489},
  {'date': '2021-10-18', 'name': 'Elijah', 'points': 1518},
  {'date': '2021-10-19', 'name': 'Oliver', 'points': 1472},
  {'date': '2021-10-19', 'name': 'Elijah', 'points': 1473},
  {'date': '2021-10-20', 'name': 'Liam', 'points': 1513},
  {'date': '2021-10-20', 'name': 'Noah', 'points': 1533},
  {'date': '2021-10-20', 'name': 'Oliver', 'points': 1487},
  {'date': '2021-10-20', 'name': 'Elijah', 'points': 1532},
  {'date': '2021-10-21', 'name': 'Liam', 'points': 1497},
  {'date': '2021-10-21', 'name': 'Noah', 'points': 1477},
  {'date': '2021-10-21', 'name': 'Oliver', 'points': 1516},
  {'date': '2021-10-22', 'name': 'Liam', 'points': 1466},
  {'date': '2021-10-22', 'name': 'Noah', 'points': 1476},
  {'date': '2021-10-22', 'name': 'Oliver', 'points': 1536},
  {'date': '2021-10-22', 'name': 'Elijah', 'points': 1483},
  {'date': '2021-10-23', 'name': 'Liam', 'points': 1503},
  {'date': '2021-10-23', 'name': 'Oliver', 'points': 1521},
  {'date': '2021-10-23', 'name': 'Elijah', 'points': 1529},
  {'date': '2021-10-24', 'name': 'Liam', 'points': 1460},
  {'date': '2021-10-24', 'name': 'Noah', 'points': 1532},
  {'date': '2021-10-24', 'name': 'Oliver', 'points': 1477},
  {'date': '2021-10-24', 'name': 'Elijah', 'points': 1470},
  {'date': '2021-10-25', 'name': 'Noah', 'points': 1504},
  {'date': '2021-10-25', 'name': 'Oliver', 'points': 1494},
  {'date': '2021-10-25', 'name': 'Elijah', 'points': 1528},
  {'date': '2021-10-26', 'name': 'Liam', 'points': 1517},
  {'date': '2021-10-26', 'name': 'Noah', 'points': 1503},
  {'date': '2021-10-26', 'name': 'Elijah', 'points': 1507},
  {'date': '2021-10-27', 'name': 'Liam', 'points': 1538},
  {'date': '2021-10-27', 'name': 'Noah', 'points': 1530},
  {'date': '2021-10-27', 'name': 'Oliver', 'points': 1496},
  {'date': '2021-10-27', 'name': 'Elijah', 'points': 1519},
  {'date': '2021-10-28', 'name': 'Liam', 'points': 1511},
  {'date': '2021-10-28', 'name': 'Oliver', 'points': 1500},
  {'date': '2021-10-28', 'name': 'Elijah', 'points': 1519},
  {'date': '2021-10-29', 'name': 'Noah', 'points': 1499},
  {'date': '2021-10-29', 'name': 'Oliver', 'points': 1489},
  {'date': '2021-10-30', 'name': 'Noah', 'points': 1460}
];

List<List<num>> getPointBigData(int n) {
  final rdm = Random();

  final rst = <List<num>>[];
  for (var i = 0; i < n; i++) {
    rst.add([
      rdm.nextDouble(),
      rdm.nextDouble(),
      rdm.nextDouble(),
      rdm.nextDouble(),
    ]);
  }

  return rst;
}

final pointBigData = getPointBigData(100);

const basicData = [
  {'genre': 'Sports', 'sold': 275},
  {'genre': 'Strategy', 'sold': 115},
  {'genre': 'Action', 'sold': 120},
  {'genre': 'Shooter', 'sold': 350},
  {'genre': 'Other', 'sold': 150},
];

const lineMarkerData = [
  {'day': 'Mon', 'value': 10, 'group': 'Highest'},
  {'day': 'Tue', 'value': 11, 'group': 'Highest'},
  {'day': 'Wed', 'value': 13, 'group': 'Highest'},
  {'day': 'Thu', 'value': 11, 'group': 'Highest'},
  {'day': 'Fri', 'value': 12, 'group': 'Highest'},
  {'day': 'Sat', 'value': 12, 'group': 'Highest'},
  {'day': 'Sun', 'value': 9, 'group': 'Highest'},
  {'day': 'Mon', 'value': 1, 'group': 'Lowest'},
  {'day': 'Tue', 'value': -2, 'group': 'Lowest'},
  {'day': 'Wed', 'value': 2, 'group': 'Lowest'},
  {'day': 'Thu', 'value': 5, 'group': 'Lowest'},
  {'day': 'Fri', 'value': 3, 'group': 'Lowest'},
  {'day': 'Sat', 'value': 2, 'group': 'Lowest'},
  {'day': 'Sun', 'value': 0, 'group': 'Lowest'},
];

const lineSectionsData = [
  [
    '00:00',
    '01:15',
    '02:30',
    '03:45',
    '05:00',
    '06:15',
    '07:30',
    '08:45',
    '10:00',
    '11:15',
    '12:30',
    '13:45',
    '15:00',
    '16:15',
    '17:30',
    '18:45',
    '20:00',
    '21:15',
    '22:30',
    '23:45'
  ],
  [300, 280, 250, 260, 270, 300, 550, 500, 400, 390, 380, 390, 400, 500, 600, 750, 800, 700, 600, 400],
];
