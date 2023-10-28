import 'package:flutter/material.dart';
import 'package:u_traffic_admin/config/theme/data/dark_theme.dart';
import 'package:u_traffic_admin/config/theme/data/light_theme.dart';
import 'config/exports/exports.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: UTrafficAdmin(),
    ),
  );
}

class UTrafficAdmin extends ConsumerWidget {
  const UTrafficAdmin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: "U-Traffic Admin",
      themeMode: themeMode,
      darkTheme: darkTheme,
      theme: lightTheme,
      onGenerateInitialRoutes: (initialRoute) {
        return [
          MaterialPageRoute(
            builder: (context) => const Wrapper(),
          ),
        ];
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.home:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const Wrapper(),
            );
          case Routes.login:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const LoginPage(),
            );
          case Routes.adminStaffs:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const AdminPage(),
            );
          case Routes.enforcers:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const EnforcerPage(),
            );
          case Routes.tickets:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const TicketPage(),
            );
          case Routes.analytics:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const AnalyticsPage(),
            );
          case Routes.complaints:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const ComplaintsPage(),
            );
          case Routes.system:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const SystemPage(),
            );
          case Routes.settings:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const SettingsPage(),
            );
          default:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => const Wrapper(),
            );
        }
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Syncfusion DataGrid Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// List<Employee> employees = populateData();
// int _rowsPerPage = 15;

// class MyHomePageState extends State<MyHomePage> {
//   late EmployeeDataSource _employeeDataSource;
//   late double pageCount;

//   void _updatePageCount() {
//     final rowsCount = _employeeDataSource.filterConditions.isNotEmpty
//         ? _employeeDataSource.effectiveRows.length
//         : employees.length;
//     pageCount = (rowsCount / _rowsPerPage).ceilToDouble();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _employeeDataSource = EmployeeDataSource();
//     _updatePageCount();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('PageNavigation Demo')),
//         body: LayoutBuilder(builder: (context, constraints) {
//           return Column(children: [
//             SizedBox(
//                 height: constraints.maxHeight - 60,
//                 child: SfDataGrid(
//                     allowFiltering: true,
//                     allowSorting: true,
//                     onFilterChanged: (details) {
//                       setState(() {
//                         _updatePageCount();
//                       });
//                     },
//                     source: _employeeDataSource,
//                     columnWidthMode: ColumnWidthMode.fill,
//                     columns: getColumns)),
//             SizedBox(
//               height: 60,
//               child: SfDataPager(
//                   pageCount: pageCount, delegate: _employeeDataSource),
//             ),
//           ]);
//         }));
//   }

//   List<GridColumn> get getColumns {
//     return <GridColumn>[
//       GridColumn(
//           columnName: 'id',
//           label: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               alignment: Alignment.center,
//               child: const Text(
//                 'ID',
//               ))),
//       GridColumn(
//           columnName: 'name',
//           label: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               alignment: Alignment.center,
//               child: const Text('Name'))),
//       GridColumn(
//           columnName: 'designation',
//           label: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               alignment: Alignment.center,
//               child: const Text(
//                 'Designation',
//                 overflow: TextOverflow.ellipsis,
//               ))),
//       GridColumn(
//           columnName: 'salary',
//           label: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               alignment: Alignment.center,
//               child: const Text('Salary'))),
//     ];
//   }
// }

// class EmployeeDataSource extends DataGridSource {
//   EmployeeDataSource() {
//     buildDataGridRows();
//   }

//   List<DataGridRow> employeeData = [];

//   @override
//   List<DataGridRow> get rows => employeeData;

//   void buildDataGridRows() {
//     employeeData = employees
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               DataGridCell<int>(columnName: 'id', value: e.id),
//               DataGridCell<String>(columnName: 'name', value: e.name),
//               DataGridCell<String>(
//                   columnName: 'designation', value: e.designation),
//               DataGridCell<int>(columnName: 'salary', value: e.salary),
//             ]))
//         .toList();
//   }

//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((e) {
//       return Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Text(e.value.toString()),
//       );
//     }).toList());
//   }
// }

// class Employee {
//   Employee(this.id, this.name, this.designation, this.salary);

//   final int id;
//   final String name;
//   final String designation;
//   final int salary;
// }

// List<Employee> populateData() {
//   return [
//     Employee(10001, 'James', 'Project Lead', 20000),
//     Employee(10002, 'Kathryn', 'Manager', 30000),
//     Employee(10003, 'Lara', 'Developer', 15000),
//     Employee(10004, 'Michael', 'Designer', 15000),
//     Employee(10005, 'martin', 'Developer', 15000),
//     Employee(10006, 'newberry', 'Developer', 15000),
//     Employee(10007, 'Balnc', 'Project Lead', 25000),
//     Employee(10008, 'Perry', 'Developer', 15000),
//     Employee(10009, 'Gable', 'Designer', 10000),
//     Employee(10010, 'Keefe', 'Project Lead', 25000),
//     Employee(10011, 'Doran', 'Developer', 35000),
//     Employee(10012, 'Linda', 'Designer', 19000),
//     Employee(10013, 'Perry', 'Developer', 15000),
//     Employee(10014, 'Gable', 'Designer', 10000),
//     Employee(10015, 'Keefe', 'Project Lead', 25000),
//     Employee(10016, 'Doran', 'Developer', 35000),
//     Employee(10017, 'Linda', 'Designer', 19000),
//     Employee(10018, 'Perry', 'Developer', 15000),
//     Employee(10019, 'Gable', 'Designer', 10000),
//     Employee(10020, 'Keefe', 'Project Lead', 25000),
//     Employee(10021, 'James', 'Project Lead', 20000),
//     Employee(10022, 'Kathryn', 'Manager', 30000),
//     Employee(10023, 'Lara', 'Developer', 15000),
//     Employee(10024, 'Michael', 'Designer', 15000),
//     Employee(10025, 'martin', 'Developer', 15000),
//     Employee(10026, 'newberry', 'Developer', 15000),
//     Employee(10027, 'Balnc', 'Project Lead', 25000),
//     Employee(10028, 'Perry', 'Developer', 15000),
//     Employee(10029, 'Gable', 'Designer', 10000),
//     Employee(10030, 'Keefe', 'Project Lead', 25000),
//     Employee(10031, 'Doran', 'Developer', 35000),
//     Employee(10032, 'Linda', 'Designer', 19000),
//     Employee(10033, 'Perry', 'Developer', 15000),
//     Employee(10034, 'Gable', 'Designer', 10000),
//     Employee(10035, 'Keefe', 'Project Lead', 25000),
//     Employee(10036, 'Doran', 'Developer', 35000),
//     Employee(10037, 'Linda', 'Designer', 19000),
//     Employee(10038, 'Perry', 'Developer', 15000),
//     Employee(10039, 'Gable', 'Designer', 10000),
//     Employee(10040, 'Keefe', 'Project Lead', 25000),
//     Employee(10041, 'James', 'Project Lead', 20000),
//     Employee(10042, 'Kathryn', 'Manager', 30000),
//     Employee(10043, 'Lara', 'Developer', 15000),
//     Employee(10044, 'Michael', 'Designer', 15000),
//     Employee(10045, 'martin', 'Developer', 15000),
//     Employee(10046, 'newberry', 'Developer', 15000),
//     Employee(10047, 'Balnc', 'Project Lead', 25000),
//     Employee(10048, 'Perry', 'Developer', 15000),
//     Employee(10049, 'Gable', 'Designer', 10000),
//     Employee(10050, 'Keefe', 'Project Lead', 25000),
//     Employee(10051, 'Doran', 'Developer', 35000),
//     Employee(10052, 'Linda', 'Designer', 19000),
//     Employee(10053, 'Perry', 'Developer', 15000),
//     Employee(10054, 'Gable', 'Designer', 10000),
//     Employee(10055, 'Keefe', 'Project Lead', 25000),
//     Employee(10056, 'Doran', 'Developer', 35000),
//     Employee(10057, 'Linda', 'Designer', 19000),
//     Employee(10058, 'Perry', 'Developer', 15000),
//     Employee(10059, 'Gable', 'Designer', 10000),
//     Employee(10060, 'Keefe', 'Project Lead', 25000),
//     Employee(10061, 'James', 'Project Lead', 20000),
//     Employee(10062, 'Kathryn', 'Manager', 30000),
//     Employee(10063, 'Lara', 'Developer', 15000),
//     Employee(10064, 'Michael', 'Designer', 15000),
//     Employee(10065, 'martin', 'Developer', 15000),
//     Employee(10066, 'newberry', 'Developer', 15000),
//     Employee(10067, 'Balnc', 'Project Lead', 25000),
//     Employee(10068, 'Perry', 'Developer', 15000),
//     Employee(10069, 'Gable', 'Designer', 10000),
//     Employee(10070, 'Keefe', 'Project Lead', 25000),
//     Employee(10071, 'Doran', 'Developer', 35000),
//     Employee(10072, 'Linda', 'Designer', 19000),
//     Employee(10073, 'Perry', 'Developer', 15000),
//     Employee(10074, 'Gable', 'Designer', 10000),
//     Employee(10075, 'Keefe', 'Project Lead', 25000),
//     Employee(10076, 'Doran', 'Developer', 35000),
//     Employee(10077, 'Linda', 'Designer', 19000),
//     Employee(10078, 'Perry', 'Developer', 15000),
//     Employee(10079, 'Gable', 'Designer', 10000),
//     Employee(10080, 'Keefe', 'Developer', 25000),
//     Employee(10081, 'James', 'Developer', 20000),
//     Employee(10082, 'Kathryn', 'Developer', 30000),
//     Employee(10083, 'Lara', 'Developer', 15000),
//     Employee(10084, 'Michael', 'Designer', 15000),
//     Employee(10085, 'Martin', 'Developer', 15000),
//     Employee(10086, 'Newberry', 'Developer', 15000),
//     Employee(10087, 'Balnc', 'Developer', 25000),
//     Employee(10088, 'Perry', 'Developer', 15000),
//     Employee(10089, 'Gable', 'Designer', 10000),
//     Employee(10090, 'Keefe', 'Developer', 25000),
//     Employee(10091, 'Doran', 'Developer', 35000),
//     Employee(10092, 'Linda', 'Designer', 19000),
//     Employee(10093, 'Perry', 'Developer', 15000),
//     Employee(10094, 'Gable', 'Designer', 10000),
//     Employee(10095, 'Keefe', 'Developer', 25000),
//     Employee(10096, 'Doran', 'Developer', 35000),
//     Employee(10097, 'Linda', 'Designer', 19000),
//     Employee(10098, 'Perry', 'Developer', 15000),
//     Employee(10099, 'Gable', 'Designer', 10000),
//     Employee(10100, 'Keefe', 'Developer', 25000),
//   ];
// }
