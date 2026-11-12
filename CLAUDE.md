# MEPCO Meter Report App — Project Context

## What this is
An offline Android app (phone and tablet) for **one** MEPCO M&T officer (Circle Bahawalnagar).
He visits consumer sites, enters meter installation / test-check data, and **prints** the report
in the exact MEPCO paper format, so other officers can sign it by hand.

- Single user, no login, no server, no internet needed.
- All data lives in a local SQLite database on the device.
- The output is a printable A4 PDF that matches the paper form (see `docs/forms/`).
- The app also keeps the history of every consumer and meter, so each new visit can be compared with the last one.

## Devices and build
- **Testing happens on an Android phone first, then on the tablet.** The layout must be responsive:
  - phone portrait: one column, with the wizard steps as full screens
  - tablet landscape (width ≥ 900): two panes
- The user has no PC. **The APK is built by GitHub Actions** (`.github/workflows/build-apk.yml`). The user downloads it from the repo's Releases page on his phone.
  - Never break that workflow. After pushing, check the workflow result and fix any failure.
- The `android/` folder is generated in CI by `flutter create` if it's missing. If you can run Flutter locally, generate and commit it instead.
- Drift code (`*.g.dart`) is generated in CI by `build_runner`. Commit the generated files too if you can run it locally.

## Tech stack (do not change without asking)
- Flutter (stable), Dart, Android target, responsive phone + tablet layout
- `drift` + `sqlite3_flutter_libs` for the local DB
- `flutter_riverpod` for state, `go_router` for navigation
- `pdf` + `printing` for PDF generation, print preview, Wi-Fi printing and sharing
- `path_provider`, `share_plus`, `file_picker` for backup/restore
- `intl` for dates (format dd-MM-yy, as on the forms)

## Folder structure
```
lib/
  main.dart
  app/            router, theme
  data/           drift database, tables, DAOs
  domain/         models, report templates, calculations, validators
  features/
    consumers/    consumer list, consumer form, consumer history
    meters/       meter list / form
    reports/      report wizard (sections A–F), report list
    pdf/          one PDF builder per report type + shared widgets
    settings/     office info, officer names, CC list, backup/restore
test/             unit tests for calculations, validators, PDF smoke tests
docs/forms/       photos of the real paper forms (the reference layout)
assets/           mepco_logo.png
```

## Report types
1. **AMR_TEST_CHECK**: "Installation cum Test Check Report of the Metering Equipments" for an AMR L.T MDI meter.
   - Meter columns: Removed Meter / AMR Meter / Installed-Existing Meter.
2. **NET_METER**: "Description of Installation of Bi-Direction Meter (Net Meter)".
   - Meter columns: Billing Net Meter / Backup Net Meter / Removed (Meter, B/up Meter).
3. **NEW_CONNECTION**: same page-1 layout as AMR_TEST_CHECK, with only the AMR/AMI column filled.
   - Page 2 has a fixed remarks paragraph with blanks, plus seal / postal-order serial numbers.

Every report has two A4 pages:
- **Page 1**
  - Header: MEPCO logo and title, phone 063-9240037, Memo No / Dated, the "Office of the Executive Engineer M&T MEPCO Circle Bahawal Nagar" block, "To: The Sub Divisional Officer (OP), MEPCO Sub Division ___"
  - Sub line: "M/S: <consumer name>"
  - Ref line: memo / telephonic / seasonal / routine check, with ref no and date
  - Intro paragraph naming the team and the visit date
  - **A)** Description of installation (12 numbered cells)
  - **B)** Energy meter particulars (MFG No, Make, Amps, Volts, Meter Constant, M.F)
  - Meter readings grid
- **Page 2**
  - **C)** Meter checking results: import and export load per phase (R/Y/B: Volts, Amps, KW, P.F, Total), plus "% age Billing / B/UP meter recorded instantaneous KW — within permissible limits of error"
  - **D)** Sealing status / record: rows TOU M/C, TOU T/C, MSB, (blank row), MSB Glass, T/Former; for each meter column: M&T Seals and Postal Orders
  - **E)** Discrepancy, remarks and recommendations
  - **F)** Postal orders signed by (4 rows), signature boxes, "Executive Engineer M&T MEPCO Circle B/Nagar", and the C.C list
- **Unused columns and blocks are struck through with one diagonal line**, exactly like the paper forms.

## Calculation rules (put all of these in `domain/calculations.dart`, with unit tests)
- **MF** = CT primary / CT secondary (400/5 → 80, 100/5 → 20). Can be edited by hand.
- **Totals**: Total = Peak + Off-peak (AMR); Total = T1 + T2 (net meter). Warn if the difference is more than 0.02.
- **Instant kW**: store the RAW display value. Instant kW = raw × MF, rounded to 2 decimals.
  - Print it as "2.258 x 80 = 180.64 KW".
- **Phase kW** = √3 × V × I × PF / 1000.
- **Check load kW** = average of the three phase kW values. This method must be a setting: `average_of_phases` (default) or `sum_per_phase`.
- **% error** = (meter instant kW − check load kW) / check load kW × 100.
  - The permissible limit is a setting (no hard-coded value).
- **Against the previous report for the same meter**: warn if any energy register or the reset no is lower than before.
  - Show consumption since the last visit = (new − old) × MF.
- **Never block saving** because of a warning. Show warnings in a yellow banner; the officer decides.

## Rules for the code
- Every DB change goes through a drift migration. Never wipe user data.
- Report templates (parameter list per type) are Dart const definitions, not hard-coded widgets.
  - The wizard and the PDF both render from the same template.
- Readings are stored as text exactly as typed (to keep leading zeros like "035165" and values like "0.8100").
  - They are parsed to numbers only for calculations.
- Large touch targets, numeric keyboard for number fields, autosave the draft on every step.
- Keep the code simple. This is a one-person tool, not an enterprise app.
- Run `flutter analyze` and `flutter test` before saying a phase is done (locally if Flutter is available, otherwise check the CI run).
