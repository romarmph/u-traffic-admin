///
///
/// * -------------------------------------------------------------Packages
///
///

// ?------------------------------------------------------Firebase
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:cloud_firestore/cloud_firestore.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:intl/intl.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:email_validator/email_validator.dart';
export 'package:quickalert/quickalert.dart';
export 'package:easy_sidemenu/easy_sidemenu.dart';
export 'package:syncfusion_flutter_datagrid/datagrid.dart';
export 'package:syncfusion_flutter_core/theme.dart';

/**
 * 
 * !-------------------------------------------------------------Views
 * 
 */

//
// ?------------------------------------------------------Data Grid Source
export 'package:u_traffic_admin/views/ticket/datagrid/data_grid_source.dart';

// ?------------------------------------------------------Common
export 'package:u_traffic_admin/views/common/page_container.dart';
export 'package:u_traffic_admin/views/common/admin_scaffold/admin_scaffold.dart';
export 'package:u_traffic_admin/views/common/alert_dialogs.dart';
export 'package:u_traffic_admin/views/common/theme_toggle.dart';
export 'package:u_traffic_admin/views/common/buttons/elevated_button.dart';

// ?------------------------------------------------------Auth
export 'package:u_traffic_admin/views/auth/login_page.dart';
export 'package:u_traffic_admin/views/auth/widget/login_form.dart';
export 'package:u_traffic_admin/views/auth/widget/login_button.dart';

// ?------------------------------------------------------Home
export 'package:u_traffic_admin/views/home/home_page.dart';

// ?------------------------------------------------------Admin
export 'package:u_traffic_admin/views/admin/admin_page.dart';

// ?------------------------------------------------------Enforcer
export 'package:u_traffic_admin/views/enforcer/enforcer_page.dart';

// ?------------------------------------------------------Ticket
export 'package:u_traffic_admin/views/ticket/ticket_page.dart';
export 'package:u_traffic_admin/views/ticket/view_ticket.dart';
export 'package:u_traffic_admin/views/ticket/widgets/data_grid.dart';

// ?------------------------------------------------------Analytics
export 'package:u_traffic_admin/views/analytics/analytics_page.dart';

// ?------------------------------------------------------Complaints
export 'package:u_traffic_admin/views/complaints/complaints_page.dart';

// ?------------------------------------------------------System
export 'package:u_traffic_admin/views/system/system_page.dart';

// ?------------------------------------------------------Settings
export 'package:u_traffic_admin/views/settings/settings_page.dart';

// ?------------------------------------------------------Wrapper
export 'package:u_traffic_admin/views/wrapper.dart';

/**
 * 
 * !-------------------------------------------------------------Themes
 * 
 */
export 'package:u_traffic_admin/config/theme/colors.dart';
export 'package:u_traffic_admin/config/theme/spacing.dart';
export 'package:u_traffic_admin/config/theme/textstyles.dart';

// ?------------------------------------------------------Components
export 'package:u_traffic_admin/config/theme/components/app_bar_theme.dart';
export 'package:u_traffic_admin/config/theme/components/elevated_button.dart';
export 'package:u_traffic_admin/config/theme/components/fab.dart';
export 'package:u_traffic_admin/config/theme/components/input_decoration.dart';
export 'package:u_traffic_admin/config/theme/components/text_button.dart';
export 'package:u_traffic_admin/config/theme/components/outlined_button.dart';

/**
 * 
 * !-------------------------------------------------------------Riverpod
 * 
 */

// ?------------------------------------------------------Database
export 'package:u_traffic_admin/riverpod/database/admin_database_providers.dart';
export 'package:u_traffic_admin/riverpod/database/ticket_database_providers.dart';

// ?------------------------------------------------------Auth
export 'package:u_traffic_admin/riverpod/auth/auth_provider.dart';
export 'package:u_traffic_admin/riverpod/auth/form_controller.dart';

// ?------------------------------------------------------Theme
export 'package:u_traffic_admin/riverpod/theme/theme_mode_provider.dart';

// ?------------------------------------------------------Views
export 'package:u_traffic_admin/riverpod/views/ticket/ticket_providers.dart';

/**
 * 
 * !-------------------------------------------------------------Models
 * 
 */
export 'package:u_traffic_admin/model/user/admin_model.dart';
export 'package:u_traffic_admin/model/user/driver_model.dart';
export 'package:u_traffic_admin/model/user/enforcer_model.dart';
export 'package:u_traffic_admin/model/location/address.dart';
export 'package:u_traffic_admin/model/location/barangays.dart';
export 'package:u_traffic_admin/model/location/city.dart';
export 'package:u_traffic_admin/model/location/location_model.dart';
export 'package:u_traffic_admin/model/location/province.dart';

export 'package:u_traffic_admin/model/license_detail_model.dart';
export 'package:u_traffic_admin/model/ticket_model.dart';
export 'package:u_traffic_admin/model/vehicle_type.dart';
export 'package:u_traffic_admin/model/violation_model.dart';

/**
 * 
 * !-------------------------------------------------------------Database
 * 
 */
export 'package:u_traffic_admin/database/admin_db.dart';
export 'package:u_traffic_admin/database/ticket_db.dart';

/**
 * 
 * !-------------------------------------------------------------Services
 * 
 */
export 'package:u_traffic_admin/services/auth/auth_service.dart';

/**
 * 
 * !-------------------------------------------------------------Config
 * 
 */

// ?------------------------------------------------------Extensions
export 'package:u_traffic_admin/config/extensions/flutter/date_time_extension.dart';
export 'package:u_traffic_admin/config/extensions/flutter/string_extensions.dart';
export 'package:u_traffic_admin/config/extensions/flutter/timestamp.dart';
export 'package:u_traffic_admin/config/extensions/flutter/validators.dart';

// ?------------------------------------------------------Exceptions
export 'package:u_traffic_admin/config/exceptions/custom_exception.dart';

// ?------------------------------------------------------Data Source
// export 'package:u_traffic_admin/views/ticket/datagrid/data_grid_source.dart';

// ?------------------------------------------------------Enums
export 'package:u_traffic_admin/config/enums/ticket_status.dart';

// ?------------------------------------------------------Routes
export 'package:u_traffic_admin/config/routes/routes.dart';

// ?------------------------------------------------------Keys
export 'package:u_traffic_admin/config/navigator_key.dart';

// ?------------------------------------------------------Navigator
export 'package:u_traffic_admin/config/navigator.dart';

// ?------------------------------------------------------Constants
export 'package:u_traffic_admin/config/constants/constants.dart';
export 'package:u_traffic_admin/config/constants/ticket_grid_fields.dart';
