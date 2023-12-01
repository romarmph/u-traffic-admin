///
///
/// * -------------------------------------------------------------Packages
///
///

// ?------------------------------------------------------Firebase
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:firebase_storage/firebase_storage.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:intl/intl.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:email_validator/email_validator.dart';
export 'package:quickalert/quickalert.dart';
export 'package:easy_sidemenu/easy_sidemenu.dart';
export 'package:syncfusion_flutter_datagrid/datagrid.dart';
export 'package:syncfusion_flutter_core/theme.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:syncfusion_flutter_datagrid_export/export.dart';
export 'package:syncfusion_flutter_pdf/pdf.dart';
export 'package:image_picker_web/image_picker_web.dart';
export 'package:side_sheet/side_sheet.dart';
export 'package:syncfusion_flutter_charts/charts.dart';

/**
 * 
 * !-------------------------------------------------------------Views
 * 
 */

//
// ?------------------------------------------------------Data Grid Source
export 'package:u_traffic_admin/datagrids/ticket_data_grid_source.dart';
export 'package:u_traffic_admin/datagrids/vehicle_type_data_grid_source.dart';
export 'package:u_traffic_admin/datagrids/payment_data_grid_source.dart';
export 'package:u_traffic_admin/datagrids/violation_data_grid_source.dart';
export 'package:u_traffic_admin/datagrids/enforcer_sched_data_grid_source.dart';
export 'package:u_traffic_admin/datagrids/enforcer_data_grid_source.dart';

// * ---- data grid columns
export 'package:u_traffic_admin/datagrids/columns/ticket_grid_columns.dart';
export 'package:u_traffic_admin/datagrids/columns/payment_grid_columns.dart';
export 'package:u_traffic_admin/datagrids/columns/vehicle_types_grid_columns.dart';
export 'package:u_traffic_admin/datagrids/columns/traffic_post_grid_columns.dart';
export 'package:u_traffic_admin/datagrids/traffic_post_data_grid_source.dart';
export 'package:u_traffic_admin/datagrids/columns/violation_grid_columns.dart';
export 'package:u_traffic_admin/datagrids/columns/enforcer_schedule_grid_columns.dart';
export 'package:u_traffic_admin/datagrids/columns/enforcer_grid_columns.dart';
export 'package:u_traffic_admin/datagrids/columns/admin_grid_columns.dart';
export 'package:u_traffic_admin/datagrids/columns/complaints_grid_columns.dart';

// * ---- data grid fields
export 'package:u_traffic_admin/datagrids/column_names/ticket_grid_fields.dart';
export 'package:u_traffic_admin/datagrids/column_names/vehicle_type_grid_fields.dart';
export 'package:u_traffic_admin/datagrids/column_names/violation_grid_fields.dart';
export 'package:u_traffic_admin/datagrids/column_names/payment_grid_fields.dart';
export 'package:u_traffic_admin/datagrids/column_names/traffic_post_grid_fields.dart';
export 'package:u_traffic_admin/datagrids/column_names/enforcer_schedule_grid_fields.dart';
export 'package:u_traffic_admin/datagrids/column_names/enforcer_grid_fields.dart';
export 'package:u_traffic_admin/datagrids/column_names/complaints_grid_fields.dart';

export 'package:u_traffic_admin/datagrids/column_names/admin_grid_fields.dart';

// ?------------------------------------------------------Common
export 'package:u_traffic_admin/views/common/current_admin.dart';
export 'package:u_traffic_admin/views/common/page_container.dart';
export 'package:u_traffic_admin/views/common/admin_scaffold/admin_scaffold.dart';
export 'package:u_traffic_admin/views/common/alert_dialogs.dart';
export 'package:u_traffic_admin/views/common/theme_toggle.dart';
export 'package:u_traffic_admin/views/common/buttons/elevated_button.dart';
export 'package:u_traffic_admin/views/common/buttons/back_button.dart';

export 'package:u_traffic_admin/views/common/widgets/data_grid.dart';
export 'package:u_traffic_admin/views/common/widgets/ticket_status.dart';
export 'package:u_traffic_admin/views/common/widgets/ticket_details.dart';
export 'package:u_traffic_admin/views/common/preview_list_tile.dart';
export 'package:u_traffic_admin/views/common/dropdown_button.dart';
export 'package:u_traffic_admin/views/common/ticket_details_page.dart';

// ?------------------------------------------------------Auth
export 'package:u_traffic_admin/views/auth/login_page.dart';
export 'package:u_traffic_admin/views/auth/widget/login_form.dart';
export 'package:u_traffic_admin/views/auth/widget/login_button.dart';
export 'package:u_traffic_admin/views/auth/login_error_page.dart';
export 'package:u_traffic_admin/views/auth/login_loading_page.dart';

// ?------------------------------------------------------Home
export 'package:u_traffic_admin/views/home/home_page.dart';

// ?------------------------------------------------------Admin
export 'package:u_traffic_admin/views/admin/admin_page.dart';

// * ---- widgets
export 'package:u_traffic_admin/views/admin/widgets/create_admin_form.dart';
export 'package:u_traffic_admin/views/admin/widgets/permission_selection_widget.dart';

// ?------------------------------------------------------Enforcer
export 'package:u_traffic_admin/views/enforcer/enforcer_page.dart';
export 'package:u_traffic_admin/views/enforcer/enforcer_schedule_page.dart';
export 'package:u_traffic_admin/views/enforcer/enforcer_detail_view_page.dart';
export 'package:u_traffic_admin/views/enforcer/create_schedule_form.dart';
export 'package:u_traffic_admin/views/enforcer/update_enforcer_sched_form.dart';

export 'package:u_traffic_admin/views/enforcer/enforcer_sched_detail_view.dart';
// * ---- widgets
export 'package:u_traffic_admin/views/enforcer/create_enforcer_form.dart';
export 'package:u_traffic_admin/views/enforcer/update_enforcer_form.dart';
export 'package:u_traffic_admin/views/enforcer/create_enforcer_form_field.dart';
export 'package:u_traffic_admin/views/enforcer/widgets/enforcer_selection_tile.dart';
export 'package:u_traffic_admin/views/enforcer/widgets/post_selection_tile.dart';
export 'package:u_traffic_admin/views/enforcer/widgets/enforcer_info_container.dart';
export 'package:u_traffic_admin/views/enforcer/widgets/traffic_post_info_container.dart';
export 'package:u_traffic_admin/views/enforcer/widgets/assignable_enforcer_list_view.dart';
export 'package:u_traffic_admin/views/enforcer/widgets/assignable_post_list_view.dart';
export 'package:u_traffic_admin/views/enforcer/widgets/sched_reassign_widget.dart';

// ?------------------------------------------------------Ticket
export 'package:u_traffic_admin/views/ticket/ticket_page.dart';
export 'package:u_traffic_admin/views/ticket/view_ticket.dart';

// ?------------------------------------------------------Analytics
export 'package:u_traffic_admin/views/analytics/analytics_page.dart';

// ?------------------------------------------------------Complaints
export 'package:u_traffic_admin/views/complaints/complaints_page.dart';

// ?------------------------------------------------------System
export 'package:u_traffic_admin/views/system/system_violations_page.dart';
export 'package:u_traffic_admin/views/system/system_vehicle_type_page.dart';
export 'package:u_traffic_admin/views/system/system_traffic_posts_page.dart';

export 'package:u_traffic_admin/views/system/widgets/menu.dart';

// ?------------------------------------------------------Settings
export 'package:u_traffic_admin/views/settings/settings_page.dart';

// ?------------------------------------------------------Payment
export 'package:u_traffic_admin/views/payment/payment_page.dart';
export 'package:u_traffic_admin/views/payment/payment_processing_page.dart';
export 'package:u_traffic_admin/views/payment/widgets/evidence_drawer.dart';
export 'package:u_traffic_admin/views/payment/widgets/evidence_card.dart';
export 'package:u_traffic_admin/views/payment/widgets/numpad.dart';
export 'package:u_traffic_admin/views/payment/widgets/numpad_button.dart';
export 'package:u_traffic_admin/views/payment/payment_details_page.dart';

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
export 'package:u_traffic_admin/riverpod/database/vehicle_type_database_providers.dart';
export 'package:u_traffic_admin/riverpod/database/violation_database_providers.dart';
export 'package:u_traffic_admin/riverpod/database/evidence_database_providers.dart';
export 'package:u_traffic_admin/riverpod/database/payment_database_providers.dart';
export 'package:u_traffic_admin/riverpod/database/traffic_post_database_providers.dart';
export 'package:u_traffic_admin/riverpod/database/enforcer_database_providers.dart';
export 'package:u_traffic_admin/riverpod/database/enforcer_schedule_database_providers.dart';

// ?------------------------------------------------------Auth
export 'package:u_traffic_admin/riverpod/auth/auth_provider.dart';
export 'package:u_traffic_admin/riverpod/auth/form_controller.dart';

// ?------------------------------------------------------Theme
export 'package:u_traffic_admin/riverpod/theme/theme_mode_provider.dart';

// ?------------------------------------------------------Views
export 'package:u_traffic_admin/riverpod/views/ticket/ticket_providers.dart';
export 'package:u_traffic_admin/riverpod/views/payment.riverpod.dart';
export 'package:u_traffic_admin/riverpod/views/system.riverpod.dart';
export 'package:u_traffic_admin/riverpod/views/enforcer.riverpod.dart';
export 'package:u_traffic_admin/riverpod/views/admin.riverpod.dart';
export 'package:u_traffic_admin/riverpod/views/enforcer_sched.riverpod.dart';

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
export 'package:u_traffic_admin/model/violations/violation_model.dart';
export 'package:u_traffic_admin/model/violations/violation_offense.dart';
export 'package:u_traffic_admin/model/violations/issued_violations.dart';
export 'package:u_traffic_admin/model/schedule/enforcer_schedule.dart';
export 'package:u_traffic_admin/model/schedule/period.dart';

export 'package:u_traffic_admin/model/license_detail_model.dart';
export 'package:u_traffic_admin/model/ticket_model.dart';
export 'package:u_traffic_admin/model/vehicle_type.dart';
export 'package:u_traffic_admin/model/evidence_model.dart';
export 'package:u_traffic_admin/model/payment_model.dart';
export 'package:u_traffic_admin/model/notification.dart';
export 'package:u_traffic_admin/model/traffic_post_model.dart';
export 'package:u_traffic_admin/model/data_exports.dart';
export 'package:u_traffic_admin/model/attachment.dart';
export 'package:u_traffic_admin/model/complaint_model.dart';

// * ---- data chart models
export 'package:u_traffic_admin/model/charts/pie_chart_data_model.dart';

/**
 * 
 * !-------------------------------------------------------------Database
 * 
 */
export 'package:u_traffic_admin/database/admin_db.dart';
export 'package:u_traffic_admin/database/ticket_db.dart';
export 'package:u_traffic_admin/database/vehicle_type_db.dart';
export 'package:u_traffic_admin/database/violation_db.dart';
export 'package:u_traffic_admin/database/evidence_db.dart';
export 'package:u_traffic_admin/database/payments_db.dart';
export 'package:u_traffic_admin/database/traffic_post_db.dart';
export 'package:u_traffic_admin/database/enforcer_schedule.dart';
export 'package:u_traffic_admin/database/enforcer_database.dart';
export 'package:u_traffic_admin/database/complaints_db.dart';

/**
 * 
 * !-------------------------------------------------------------Services
 * 
 */

// * ---- Auth
export 'package:u_traffic_admin/services/auth/auth.service.dart';

// * ---- http
export 'package:u_traffic_admin/services/http/enforcer.service.dart';
export 'package:u_traffic_admin/services/http/admin.service.dart';

export 'package:u_traffic_admin/services/image_picker.service.dart';
export 'package:u_traffic_admin/services/storage.service.dart';

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

// ?------------------------------------------------------Enums
export 'package:u_traffic_admin/config/enums/ticket_status.dart';
export 'package:u_traffic_admin/config/enums/payment_method.dart';
export 'package:u_traffic_admin/config/enums/notification_type.dart';
export 'package:u_traffic_admin/config/enums/admin_permissions.dart';
export 'package:u_traffic_admin/config/enums/enforcer_status.dart';
export 'package:u_traffic_admin/config/enums/shift_period.dart';

// ?------------------------------------------------------Routes
export 'package:u_traffic_admin/config/routes/routes.dart';
export 'package:u_traffic_admin/config/routes/on_generate_routes.dart';

// ?------------------------------------------------------Keys
export 'package:u_traffic_admin/config/navigator_key.dart';

// ?------------------------------------------------------Navigator
export 'package:u_traffic_admin/config/navigator.dart';

// ?------------------------------------------------------Constants
export 'package:u_traffic_admin/config/constants/constants.dart';

/**
 * 
 * !-------------------------------------------------------------Utils
 * 
 */
export 'package:u_traffic_admin/utils/enforcer_form_validator.dart';
