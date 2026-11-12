# Build Plan — MEPCO Meter Report App

## ▶ The prompt to paste into Claude Code
Paste this in the Claude app → Code, with the repository `faisal-395/mepco-meter-app` selected:

```
Read CLAUDE.md and PLAN.md (and the images in docs/forms/ if any are there).
Build the complete app by doing Phases 1 to 8 of PLAN.md in order, without
stopping to ask me between phases unless you are truly blocked.

Rules:
- First check `flutter --version`. If Flutter is missing, try installing the
  stable SDK (git clone https://github.com/flutter/flutter -b stable --depth 1).
  If that is not possible, write the code carefully and rely on the GitHub
  Actions workflow to run build_runner, analyze, test and build.
- After each phase: run analyze/tests (locally or via CI), fix errors, commit
  with a message like "Phase 3: templates and calculations", and push to main.
- Never break .github/workflows/build-apk.yml. After the final push, check
  that the workflow passed and that a GitHub Release with the APK exists.
  If it failed, read the logs, fix, and push again until it is green.
- At the end, tell me: what works, what is missing, and which release to
  download.
```

If the session stops before it's finished, send this: `Continue with the next unfinished phase of PLAN.md.`

## ▶ Testing on your phone
1. Open the repo on GitHub → **Releases** → the newest `build-N` → download `app-release.apk`.
2. Open the APK file and allow "Install unknown apps" for your browser or file manager when Android asks.
3. **Important:** until a fixed signing key is set up (see "Signing" at the bottom), every new build is signed with a different key. To install a newer build, **uninstall the old app first**, and its test data is lost. That's fine for testing. Set up signing before the officer enters real data.

---

## Phase 1 — Project setup and database
- Create the Flutter project files: pubspec.yaml with the packages from CLAUDE.md, `lib/` structure, and `analysis_options.yaml`.
  - The app name shown to users is "MEPCO Meter Reports"; the package is `com.faisal.mepco_meter_app`.
- Set up a responsive theme with large inputs. Phone portrait is one column; tablet landscape (width ≥ 900) is two panes.
- Create the drift database with these tables:
  - **consumers**: account_no (unique, e.g. "27-15824-0641001"), tariff ("B2"), name, address, sub_division, op_division, sanctioned_load_kw, connected_load, industry_kind, transformer_kva, transformer_make, transformer_no, ct_primary, ct_secondary, mf, cable_size, msb_type, feeder_name, application_no, application_date, sanction_ref (SE/XEN No & date), sco_mco_rco_no, sco_date, notes, timestamps
  - **meters**: consumer_id, mfg_no, make, meter_kind (AMR / TOU / AMI / NET), amps, volts, meter_constant, mf, sim_no, comm_id, status (active / removed), installed_on, removed_on
  - **reports**: consumer_id, report_type, status (draft / final), memo_no, memo_date, to_sub_division, ref_type (memo / telephonic / seasonal / routine), ref_no, ref_date, visit_date, team_text, msb_status, postal_orders_text, checked_load_kw, export_load_text, accuracy_text, transformer_lt_bushes, remarks, store_challan_no, store_challan_date, new_meter_count, ct_count, signer_exen_op, signer_sdo_op, timestamps
  - **report_meters**: report_id, meter_id, column_role (removed / amr / existing / billing / backup / backup_removed), not_applicable flag
  - **readings**: report_id, report_meter_id, param_code, value_text
  - **phase_loads**: report_id, side (import / export), phase (R / Y / B), volts, amps, kw_override, pf
  - **seals**: report_id, spot (TOU_MC, TOU_TC, MSB, MSB_2, MSB_GLASS, TFORMER), column_role, mt_seal, postal_order
  - **settings** (key / value)
- Seed these settings (all editable later):
  - office phone 063-9240037
  - circle "Bahawalnagar"
  - XEN M&T "Engr. Muhammad Tanveer Abid"
  - test inspector "Mr. Abdul Hafeez"
  - T.A "Sajid Naveed"
  - check-load method "average_of_phases"
  - permissible error limit (empty)
  - the default C.C list:
    1. The SE (OP) MEPCO Circle Bahawal Nagar for information and necessary action please.
    2. The Deputy Chief Auditor MEPCO Multan for information and necessary action please.
    3. The Manager (T.S) M&T-1st Region MEPCO Multan for information and necessary action please.
    4. The Executive Engineer (OP) MEPCO Division {division} for information and necessary action please.
    5. The Assistant Manager (CS) MEPCO Division {division} for information and necessary action please.
    6. Master File
- Write DAO unit tests.

## Phase 2 — Consumers and meters
- **Consumer list**: search by account no or name.
- **Consumer form**: all fields of section A. MF is auto-calculated from the CT ratio but can be edited.
- **Consumer detail**: its meters (active and removed) and the list of past reports, newest first.
- **Meter form**.
- **Settings screen**: edit every setting, including the C.C list.
- **Home screen**: buttons for New report, Consumers, Reports, Settings, plus a list of drafts.

## Phase 3 — Report templates and calculations
- In `domain/` create:
  - `report_templates.dart`: the parameter list for each report type, with codes, labels exactly as printed on the forms, and the order.
    - **AMR_TEST_CHECK and NEW_CONNECTION** use these 18 rows: Current Date, Current Time, Current Total KWH, Peak, Off Peak, Current Total KVARH, Peak, Off Peak, MDI Current, Peak, Off Peak, CUM (MDI), Peak, Off Peak, Reset No, Instant K.W, A.V P.F, Current P.F.
    - **NET_METER** uses these 30 numbered rows: 1 Meter No, 2 Current Date, 3 Current Time, 4 Import active Energy Total, 5 Export active Energy Total, 6 Import active Energy T-1, 7 Export active Energy T-1, 8 Import active Energy T-2, 9 Export active Energy T-2, 10 Import reactive Energy Total, 11 Export reactive Energy Total, 12 Import reactive Energy T-1, 13 Export reactive Energy T-1, 14 Import reactive Energy T-2, 15 Export reactive Energy T-2, 16 Import active MDI Total, 17 Export active MDI Total, 18 Import active MDI T-1, 19 Export active MDI T-1, 20 Import active MDI T-2, 21 Export active MDI T-2, 22 Import active Cum MDI Total, 23 Export active Cum MDI Total, 24 Import active Cum MDI T-1, 25 Export active Cum MDI T-1, 26 Import active Cum MDI T-2, 27 Export active Cum MDI T-2, 28 Resets No, 29 Import Instant Total active KW, 30 Export Instant Total active KW.
  - `calculations.dart` and `validators.dart`: everything in the CLAUDE.md "Calculation rules" section.
- Write unit tests using the TEST DATA at the bottom of this file. All the tests must pass.

## Phase 4 — Report wizard
Build a step-by-step wizard that autosaves a draft on every step:
1. Report type, consumer (search, or add a new one), and the header (memo no and date, To sub division, ref type / no / date, visit date, team text).
2. **Section A**: prefilled from the consumer and editable. Changes ask "also update consumer record?"
3. **Section B**: pick or add meters for each column of the report type. A column can be marked "not applicable", which strikes it through on the PDF.
4. **Readings**:
   - On a phone, one meter at a time with tabs. On a tablet, all columns side by side.
   - Show the previous report's value in grey under each field.
   - Totals show a green tick or a yellow warning.
   - Instant kW takes the raw value and shows "raw × MF = result" live.
5. **Section C**: import and export per phase (V, A, PF). KW per phase, check load, % error and within-limit are computed live and can be overridden.
6. **Section D**: a seals grid (spot × column, M&T seal and postal order). Include a "fill a range" helper for serials like TA-823623-24.
7. **Section E**: MSB status, postal orders, checked load (filled from C), export load, accuracy, transformer LT bushes, and free remarks. For NEW_CONNECTION, an editable paragraph filled from the template in Phase 6.
8. **Section F**: postal-order signer names.
9. **Review**: all warnings in one list, then the "Mark final" and "Print / PDF" buttons.

Final reports are read-only, with a "Duplicate as new draft" button. Make AMR_TEST_CHECK work end to end first, then reuse the wizard for the other types.

## Phase 5 — PDF for AMR_TEST_CHECK
- In `features/pdf/` build the PDF (A4 portrait, 2 pages) with the `pdf` package. Follow the page layout in CLAUDE.md and the photos in docs/forms/ if present:
  - The same section order, table borders, bold headings, numbered cells in A, and the signature boxes at the bottom (Consumer / Supervisor M&T Circle B/Nagar / SDO (OP) Sub Division / Executive Engineer M&T Circle B/Nagar / Executive Engineer (OP) <division>).
  - Show the logo if `assets/mepco_logo.png` exists. Otherwise leave space for it and don't crash.
  - Unused columns and empty blocks get ONE diagonal line, like on the paper.
  - Instant kW is printed as "2.258 x 80 = 180.64 KW".
- Use the `printing` package for preview, print (Wi-Fi printer or Save as PDF) and Share (to send on WhatsApp). Save a copy to app documents as `<account_no>_<visit_date>_<type>.pdf`.
- Add a test that builds the PDF from test data 1 without errors.

## Phase 6 — NET_METER and NEW_CONNECTION
- Add both report types to the wizard and the PDF.
- **NET_METER**: billing and backup columns, 30 rows, and "% age Billing / B/UP meter recorded instantaneous KW" in section C.
- **NEW_CONNECTION**: the extra fields (application no and date, SCO no and date, store challan, SIM no, comm ID, T/F no, new meter count, CT count and ratio). The SIM no and comm ID print in the page-1 header area.
  - Section E is an editable paragraph filled from this template:
    ```
    The Site was visited by the committee of M/S: {consumer_name} on Dated {visit_date} for installation of New connection vide XEN (OP) {op_division}. Memo No. {ref_no} Dated {ref_date}, App No. {application_no} dt {application_date}. SDO (OP) Store challan No. {store_challan_no} dt. {store_challan_date} SCO No. {sco_no} dt {sco_date}. The job was carried out and ({new_meter_count}) No. New AMI Meter install in Separate MSBs with ({ct_count}) no. {ct_ratio} Amp CTs. After installation the accuracy checked of new installed AMI Meter at 3/Phase Heater Load ({checked_load_kw} KW) and found within permissible limits of error. Finally MSB Closed / Secured with postal orders duly signed by the committee mentioned above in this performa. RO / SDO (OP) is advised to implement the SCO/SJO as per SOP.
    ```
- Add PDF tests for test data 2 and 3.

## Phase 7 — History, search, backup
- **Search** by account no, name, meter no or memo no.
- **Consumer history**: a table of readings across all visits for each meter, with consumption between visits (× MF).
- **Report list / memo register**: filter by date, sub division and type.
- **Backup**: export the SQLite file plus all PDFs as one .zip and share it (Google Drive / WhatsApp). Show a reminder banner if the last backup is more than 7 days old.
- **Restore**: pick a .zip and replace the data, after a confirmation and an automatic backup of the current data first.
- **Demo data**: a "Load demo data" button in Settings that inserts the three test reports below, so the app can be tried right after installing.

## Phase 8 — Release polish
- App icon (a simple meter / lightning icon, no MEPCO logo) and the app name "MEPCO Meter Reports".
- Signing: read the keystore from the GitHub secrets ANDROID_KEYSTORE_BASE64, ANDROID_KEYSTORE_PASSWORD, ANDROID_KEY_ALIAS and ANDROID_KEY_PASSWORD when they exist. Fall back to debug signing when they don't. Update the workflow for this.
- README.md, written for a non-developer:
  - how to install the APK
  - how to make a report
  - how to print
  - how to back up and restore
  - how to set up the signing secrets
- Fix every analyze warning. All tests and the workflow must be green.

---

## TEST DATA (numbers from real forms; names and IDs replaced with dummies)

### 1. AMR_TEST_CHECK — M/S Test Cotton Factory F/Abbas (visit 06-10-26)
**Section A:**
- A/C 99-00001-0000001 / B2
- Sanction 255.00 kW
- Cotton & Factory
- Transformer 400 KVA
- CT 400/5 → MF 80
- Cable 37/0.103
- MSB "A" Type New
- Sub division F/Abbas, division HND

**Section B:**
- AMR meter: 000001, AMR MTL, 5(10)A, 3x230/400V, 10000 imp/kWh/kVARh, MF R x 80
- Existing meter: 000002, TOU CE, same ratings
- Removed column: not applicable

| Param | AMR | Existing |
|---|---|---|
| Date / Time | 06-10-26 14:55 | 06-10-26 14:52 |
| kWh total / peak / off | 2556.74 / 508.62 / 2048.11 | 8651.72 / 1745.70 / 6906.02 |
| kVARh total / peak / off | 1937.75 / 391.22 / 1546.53 | 4785.78 / 968.12 / 3817.66 |
| MDI total / peak / off | 2.00 / 1.99 / 2.00 | 2.016 / 1.990 / 2.016 |
| Cum MDI total / peak / off | 12.45 / 18.15 / 12.42 | 34.26 / 33.11 / 34.22 |
| Reset no | 09 | 25 |
| Instant kW raw | 2.25 | 2.25 |

**Expected test results:**
- kWh peak + off = 2556.73 vs 2556.74 → within 0.02, no warning.
- Instant 2.25 × 80 = 180.00.

**Section C import:**

| Phase | V | A | PF |
|---|---|---|---|
| R | 425 | 275 | 0.89 |
| Y | 419 | 270 | 0.92 |
| B | 428 | 272 | 0.94 |

**Expected test results:** phase kW ≈ 180.17 / 180.27 / 189.54, average ≈ 183.33. The paper form says 180.66 from a hand calculation; assert the formula values, not 180.66.

**Seals:** none. **Section E:** MSB status "Welded", accuracy "OK", transformer LT bushes "Sealed".

### 2. NET_METER — M/S Test Marble Factory F/Abbas (06-10-26)
**Section A:**
- A/C 99-00001-0000002 / B2
- 40.00 kW
- Marble Factory
- 50 KVA
- CT 100/5 → MF 20
- Cable 37/0.083
- "A" Type New

**Meters:**
- Billing net meter 100001 (CE)
- Backup net meter 100002 (CE)
- Both 5/10A, 230/400V, 10000 imp, R x 20

| Param | Billing | Backup |
|---|---|---|
| Time | 16:40 | 16:41 |
| Import active total / T1 / T2 | 780.2 / 73.8 / 706.4 | 773.6 / 72.6 / 701.0 |
| Export active total / T1 / T2 | 1855.4 / 22.8 / 1832.6 | 1842.0 / 21.2 / 1820.8 |
| Import reactive total / T1 / T2 | 287.1 / 14.9 / 272.2 | 301.4 / 14.2 / 287.2 |
| Export reactive total / T1 / T2 | 411.3 / 54.6 / 356.7 | 402.2 / 52.9 / 349.3 |
| Resets | 22 | 22 |
| Import instant kW raw | 0.801 | 0.801 |

**Expected test results:**
- All totals equal T1 + T2 exactly.
- Instant 0.801 × 20 = 16.02.
- Billing and backup instant kW match.

### 3. NEW_CONNECTION — M/S Test School 13/G Road CTN (05-11-26)
**Header:**
- Memo 101-11, dated 05-11-26
- To: Sub Division S/Town CTN, division CTN
- Ref memo 10001-05, dated 29-10-26

**Section A and connection details:**
- App No 10000000000001, dated 17-07-26
- A/C 99-00002-0000003 / A3
- 39.00 kW
- School
- Transformer 50 KVA (PEL), T/F No 100001
- CT 100/5 → MF 20
- Cable 19/0.083
- "A" Type New
- Store challan 1001, dt 30-10-26
- SCO 10000000000001, dt 17-07-26
- 1 new AMI meter, 4 CTs of 100/5
- SIM no 0300-0000000, comm ID 000000000000000

**Meter:** AMI 3200000001, make CE AMI, 5(10)A, 3x230/400V, 10000 imp, R x 20.

**Readings:**
- kWh total / peak / off = 0.40 / 0.00 / 0.40
- kVARh = 0.70 / 0.00 / 0.70
- Reset 01
- Instant raw 0.736 → 14.72

**Section C:**

| Phase | V | A | PF |
|---|---|---|---|
| R | 414 | 21 | 1.00 |
| Y | 412 | 20 | 1.00 |
| B | 413 | 21 | 1.00 |

**Expected test results:**
- Phase kW ≈ 15.06 / 14.27 / 15.02, average ≈ 14.78.
- % error ≈ −0.43.

**Seals (AMR column, postal orders):**
- TOU M/C TA-900001
- TOU T/C TA-900002
- MSB TA-900003-04 and TA-900005-06
- MSB Glass TA-900007-08
- T/Former TA-900009-10-11-12

**Postal order signers:**
- Engr. Test One (EXEN OP CTN)
- Engr. Test Two (SDO OP S/Town CTN)

---

## Signing (do once, before real use)
Without a fixed key, every CI build has a different signature and updates need an uninstall, which deletes all data. Before the officer uses it for real:
1. Ask Claude Code to "generate an Android release keystore and tell me the 4 values for GitHub secrets".
2. Add the 4 values in GitHub → repo Settings → Secrets and variables → Actions.
3. Keep a copy of the keystore somewhere safe. Without it, future updates can't install over the app.
