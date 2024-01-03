class Routes {
  // Dashboard route
  static const String home = '/';

  // Auth routes
  static const String login = '/login';

  // Analytics routes
  static const String analytics = '/analytics';

  // Ticket routes
  static const String tickets = '/tickets';
  static const String ticketView = '/tickets/view';
  static const String ticketRelated = '/tickets/related';

  // Enforcer routes
  static const String enforcers = '/enforcers';
  static const String enforcersView = '/enforcers/view';
  static const String enforcersCreate = '/enforcers/create';
  static const String enforcersEdit = '/enforcers/edit';
  static const String enforcerSchedules = '/enforcers/schedules';
  static const String enforcerSchedulesCreate = '/enforcers/schedules/create';
  static const String enforcerSchedulesUpdate = '/enforcers/schedules/update';
  static const String enforcerAttendance = '/enforcers/attendance';

  // Admin Staff routes
  static const String adminStaffs = '/admin-staffs';
  static const String adminStaffsView = '/admin-staffs/view';
  static const String adminStaffsCreate = '/admin-staffs/create';
  static const String adminStaffsEdit = '/admin-staffs/edit';

  // System routes
  static const String system = '/system';
  static const String systemViolations = '/system/violations';
  static const String systemVehicleTypes = '/system/vehicle-types';
  static const String systemTrafficPosts = '/system/traffic-posts';
  static const String systemEnforcerSchedule = '/system/enforcer-schedule';
  static const String systemFiles = '/system/files';

  // Settings routes
  static const String settings = '/settings';

  // Complaints routes
  static const String complaints = '/complaints';

  // Payment routes
  static const String payment = '/payment';
}
