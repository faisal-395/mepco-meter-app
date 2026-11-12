/// Keys and default values of the editable settings.
class SettingKeys {
  static const officePhone = 'office_phone';
  static const circle = 'circle';
  static const xenMt = 'xen_mt';
  static const testInspector = 'test_inspector';
  static const ta = 'ta';
  static const checkLoadMethod = 'check_load_method';
  static const permissibleErrorLimit = 'permissible_error_limit';
  static const ccList = 'cc_list';
  static const lastBackupAt = 'last_backup_at';

  static const methodAverage = 'average_of_phases';
  static const methodSum = 'sum_per_phase';

  static const defaultCcList = [
    'The SE (OP) MEPCO Circle Bahawal Nagar for information and necessary action please.',
    'The Deputy Chief Auditor MEPCO Multan for information and necessary action please.',
    'The Manager (T.S) M&T-1st Region MEPCO Multan for information and necessary action please.',
    'The Executive Engineer (OP) MEPCO Division {division} for information and necessary action please.',
    'The Assistant Manager (CS) MEPCO Division {division} for information and necessary action please.',
    'Master File',
  ];

  static final Map<String, String> defaults = {
    officePhone: '063-9240037',
    circle: 'Bahawalnagar',
    xenMt: 'Engr. Muhammad Tanveer Abid',
    testInspector: 'Mr. Abdul Hafeez',
    ta: 'Sajid Naveed',
    checkLoadMethod: methodAverage,
    permissibleErrorLimit: '',
    ccList: defaultCcList.join('\n'),
  };

  /// Labels for the settings screen (key -> label), in display order.
  static const labels = {
    officePhone: 'Office phone',
    circle: 'Circle',
    xenMt: 'XEN M&T name',
    testInspector: 'Test inspector',
    ta: 'T.A',
    permissibleErrorLimit: 'Permissible error limit (%)',
  };
}
