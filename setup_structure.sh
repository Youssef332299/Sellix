#!/bin/bash

echo "🚀 Creating project structure..."

# ===== MOBILE =====
mkdir -p lib/screens/mobile/select_user_type/{view,components,cubit}
mkdir -p lib/screens/mobile/admin_login/{view,components,cubit}
mkdir -p lib/screens/mobile/employee_login/{view,components,cubit}
mkdir -p lib/screens/mobile/employee_home/{view,components,cubit}
mkdir -p lib/screens/mobile/admin_home/{view,components,cubit}

touch lib/screens/mobile/select_user_type/view/select_user_type_page.dart
touch lib/screens/mobile/select_user_type/components/{user_type_card.dart,app_logo.dart}
touch lib/screens/mobile/select_user_type/cubit/{select_user_type_cubit.dart,select_user_type_state.dart}

touch lib/screens/mobile/admin_login/view/admin_login_page.dart
touch lib/screens/mobile/admin_login/components/{admin_password_field.dart,admin_login_button.dart}
touch lib/screens/mobile/admin_login/cubit/{admin_login_cubit.dart,admin_login_state.dart}

touch lib/screens/mobile/employee_login/view/employee_login_page.dart
touch lib/screens/mobile/employee_login/components/{employee_id_field.dart,remember_me_checkbox.dart,employee_login_button.dart}
touch lib/screens/mobile/employee_login/cubit/{employee_login_cubit.dart,employee_login_state.dart}

touch lib/screens/mobile/employee_home/view/employee_home_page.dart
touch lib/screens/mobile/employee_home/components/{scan_qr_button.dart,attendance_status_card.dart,today_attendance_widget.dart}
touch lib/screens/mobile/employee_home/cubit/{attendance_cubit.dart,attendance_state.dart}

touch lib/screens/mobile/admin_home/view/admin_home_page.dart
touch lib/screens/mobile/admin_home/components/{reports_card.dart,employees_summary_card.dart}
touch lib/screens/mobile/admin_home/cubit/{admin_home_cubit.dart,admin_home_state.dart}

# ===== POS =====
mkdir -p lib/screens/pos/company_setup/{view,components,cubit}
mkdir -p lib/screens/pos/pos_setup/{view,components,cubit}
mkdir -p lib/screens/pos/pos_login/{view,components,cubit}
mkdir -p lib/screens/pos/company_dashboard/{view,components,cubit}
mkdir -p lib/screens/pos/cashier_home/{view,components,cubit}

touch lib/screens/pos/company_setup/view/company_setup_page.dart
touch lib/screens/pos/company_setup/components/{company_name_field.dart,logo_picker.dart,company_password_field.dart,cashier_password_field.dart}
touch lib/screens/pos/company_setup/cubit/{company_setup_cubit.dart,company_setup_state.dart}

touch lib/screens/pos/pos_setup/view/pos_setup_page.dart
touch lib/screens/pos/pos_setup/components/{section_form.dart,section_list.dart,item_form.dart,item_list.dart}
touch lib/screens/pos/pos_setup/cubit/{pos_setup_cubit.dart,pos_setup_state.dart}

touch lib/screens/pos/pos_login/view/pos_login_page.dart
touch lib/screens/pos/pos_login/components/{login_type_selector.dart,password_field.dart,login_button.dart}
touch lib/screens/pos/pos_login/cubit/{pos_login_cubit.dart,pos_login_state.dart}

touch lib/screens/pos/company_dashboard/view/company_dashboard_page.dart
touch lib/screens/pos/company_dashboard/components/{items_management_panel.dart,sections_management_panel.dart,generate_qr_button.dart,active_tokens_list.dart}
touch lib/screens/pos/company_dashboard/cubit/{company_dashboard_cubit.dart,company_dashboard_state.dart}

touch lib/screens/pos/cashier_home/view/cashier_home_page.dart
touch lib/screens/pos/cashier_home/components/{open_till_button.dart,generate_attendance_qr_card.dart,qr_display_box.dart,till_status_indicator.dart}
touch lib/screens/pos/cashier_home/cubit/{cashier_home_cubit.dart,cashier_home_state.dart}

# ===== WEB =====
mkdir -p lib/screens/web/web_admin_login/{view,components,cubit}
mkdir -p lib/screens/web/web_dashboard/{view,components}
mkdir -p lib/screens/web/employees/{view,components,cubit}
mkdir -p lib/screens/web/attendance/{view,components,cubit}

touch lib/screens/web/web_admin_login/view/web_admin_login_page.dart
touch lib/screens/web/web_admin_login/components/{admin_password_field.dart,login_button.dart}
touch lib/screens/web/web_admin_login/cubit/{web_admin_login_cubit.dart,web_admin_login_state.dart}

touch lib/screens/web/web_dashboard/view/web_dashboard_page.dart
touch lib/screens/web/web_dashboard/components/{sidebar.dart,top_navbar.dart,logout_button.dart}

touch lib/screens/web/employees/view/employees_page.dart
touch lib/screens/web/employees/components/{employee_table.dart,employee_row.dart,add_employee_modal.dart,employee_form.dart}
touch lib/screens/web/employees/cubit/{employees_cubit.dart,employees_state.dart}

touch lib/screens/web/attendance/view/attendance_page.dart
touch lib/screens/web/attendance/components/{attendance_table.dart,attendance_filter_bar.dart,edit_attendance_modal.dart}
touch lib/screens/web/attendance/cubit/{attendance_cubit.dart,attendance_state.dart}

echo "✅ Structure created successfully!"
