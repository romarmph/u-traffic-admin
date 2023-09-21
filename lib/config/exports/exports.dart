///
///
///   Packages
///
///

// Firebase
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:cloud_firestore/cloud_firestore.dart';

export 'package:flutter_riverpod/flutter_riverpod.dart';
export 'package:intl/intl.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:email_validator/email_validator.dart';
export 'package:quickalert/quickalert.dart';

/**
 * 
 * views
 * 
 */

// Commons
export 'package:u_traffic_admin/views/common/alert_dialogs.dart';
export 'package:u_traffic_admin/views/common/theme_toggle.dart';

// Auth
export 'package:u_traffic_admin/views/auth/login_page.dart';
export 'package:u_traffic_admin/views/auth/widget/login_form.dart';
export 'package:u_traffic_admin/views/auth/widget/login_button.dart';

// Home
export 'package:u_traffic_admin/views/home/home_page.dart';

// Wrapper
export 'package:u_traffic_admin/views/wrapper.dart';

/**
 * 
 * Themes
 * 
 */
export 'package:u_traffic_admin/config/theme/colors.dart';
export 'package:u_traffic_admin/config/theme/spacing.dart';
export 'package:u_traffic_admin/config/theme/textstyles.dart';

// Components
export 'package:u_traffic_admin/config/theme/components/app_bar_theme.dart';
export 'package:u_traffic_admin/config/theme/components/elevated_button.dart';
export 'package:u_traffic_admin/config/theme/components/fab.dart';
export 'package:u_traffic_admin/config/theme/components/input_decoration.dart';
export 'package:u_traffic_admin/config/theme/components/text_button.dart';
export 'package:u_traffic_admin/config/theme/components/outlined_button.dart';

/**
 * 
 * Riverpod
 * 
 */

// Database
export 'package:u_traffic_admin/riverpod/database/database_providers.dart';

// Auth
export 'package:u_traffic_admin/riverpod/auth/auth_provider.dart';
export 'package:u_traffic_admin/riverpod/auth/form_controller.dart';

// Theme
export 'package:u_traffic_admin/riverpod/theme/theme_mode_provider.dart';

/**
 * 
 * Models
 * 
 */
export 'package:u_traffic_admin/model/admin_model.dart';

/**
 * 
 * Database
 * 
 */
export 'package:u_traffic_admin/database/admin_db.dart';

/**
 * 
 * Services
 * 
 */
export 'package:u_traffic_admin/services/auth/auth_service.dart';

/**
 * 
 * Config
 * 
 */

// Extensions
export 'package:u_traffic_admin/config/extensions/date_time_extension.dart';
export 'package:u_traffic_admin/config/extensions/string_extensions.dart';
export 'package:u_traffic_admin/config/extensions/timestamp.dart';
export 'package:u_traffic_admin/config/extensions/validators.dart';

// Exceptions
export 'package:u_traffic_admin/config/exceptions/custom_exception.dart';

// Routes
export 'package:u_traffic_admin/config/routes/routes.dart';

// Keys
export 'package:u_traffic_admin/config/navigator_key.dart';
