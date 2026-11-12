# MEPCO Meter Reports

An offline Android app for the M&T office, MEPCO Circle Bahawalnagar. The officer records
meter installation and test-check visits on a phone or tablet, then prints the report in the
MEPCO paper-form layout, ready to sign by hand.

- No internet, no login. All data stays on the device.
- Three report types: **AMR Test Check**, **Net Meter** (bi-directional) and **New Connection**.
- Every report prints as a two-page A4 PDF. Unused columns and empty blocks are struck through
  with one diagonal line, like on the paper forms.
- The app keeps the history of every consumer and meter, so each visit is compared with the last one.

---

## 1. Install the app on your phone

1. On your phone, open this repository on GitHub and tap **Releases**.
2. Open the newest release (`build-N`, where N is the highest number) and tap **app-release.apk** to download it.
3. Open the downloaded file. If Android asks, allow **Install unknown apps** for your browser or
   file manager, then tap **Install**.
4. Open **MEPCO Meter Reports**.

To try the app straight away, go to **Settings → Load demo data**. This adds three example
reports with dummy names.

> **Updating:** until the signing key is set up (section 6), each new build has a different
> signature. To install a newer build you must **uninstall the old app first, and that deletes its
> data**. Make a backup before uninstalling (section 4), or set up signing before real use.

---

## 2. Make a report

1. On the home screen, tap **New report** and choose the type:
   - **AMR Test Check**: installation-cum-test-check of an AMR L.T MDI meter.
   - **Net Meter**: billing and backup bi-directional meters.
   - **New Connection**: a new AMI/AMR meter installation.
2. Pick the consumer (search by A/C No or name), or tap **New consumer** to add one.
3. Fill in the steps. Use **Next** and **Back** at the bottom; on a tablet the steps are listed on the left.
   - **Header**: memo no and date, "To" sub division, reference (memo / telephonic / seasonal /
     routine) with its no and date, visit date, and team names.
   - **A) Installation**: filled from the consumer record. If you change something, the app asks
     whether to update the consumer record too. M.F is calculated from the CT ratio
     (e.g. 400/5 = 80), and you can type another value.
   - **B) Meters**: pick the meter for each column, or **Add new meter**. Turn on **Not applicable**
     for unused columns; they are struck through on the printout.
   - **Readings**: type the values exactly as shown on the meter display (leading zeros are kept).
     - Grey "Last:" values are from the previous visit.
     - A green tick means Total = Peak + Off-peak (or T-1 + T-2). A yellow warning means the
       difference is more than 0.02.
     - For **Instant K.W**, type the raw display value. The app shows `raw x MF = KW`.
   - **C) Checking**: volts, amps and P.F for each phase. KW per phase, the check load and the
     % error are calculated as you type. Every result can be overridden.
   - **D) Seals**: M&T seal and postal-order serials. **Fill a range** writes serials like
     `TA-900009-10-11-12` for you.
   - **E) Remarks**: MSB status, accuracy, transformer LT bushes and so on. For a New Connection
     the paragraph is filled in automatically, and you can edit it.
   - **F) Signers**: names of the officers who signed the postal orders.
   - **Review**: a list of all warnings. Warnings never stop you from saving or printing.
4. The report is saved automatically on every step. Unfinished reports are listed under **Drafts**
   on the home screen.
5. Tap **Mark final** when the report is complete. Final reports can't be edited, but
   **Duplicate as new draft** copies one for a correction or the next visit.

---

## 3. Print or share

- In a report, tap the **PDF** icon (top right) or **Print / PDF** on the Review step.
- The preview shows both pages. Use the **print** button for a Wi-Fi printer (or "Save as PDF"),
  and the **share** button to send it on WhatsApp or by email.
- A copy of each PDF is also kept inside the app as `<account_no>_<visit_date>_<type>.pdf`.
- To print the MEPCO logo, add `assets/mepco_logo.png` to the repository; the next build will
  include it. Without it, the space for the logo stays blank.
- The PDF uses a built-in font that prints English text only. Urdu letters are left out.

---

## 4. Back up and restore

**Back up** (do it at least once a week; the home screen shows a reminder after 7 days):

1. Go to **Settings → Backup now**.
2. The app makes one `.zip` file containing the database and all PDFs, and opens the share menu.
3. Choose **Google Drive** (or send it to yourself on WhatsApp) so the backup is kept off the phone.

**Restore** (for example on a new phone, or after reinstalling):

1. Download the backup `.zip` to the phone.
2. Go to **Settings → Restore from a .zip backup** and pick the file.
3. Confirm. The app first saves a safety backup of the current data, then replaces all data with
   the backup.

---

## 5. Settings

Office phone, circle, officer names, permissible error limit, check-load method (average or sum
of the three phases) and the C.C list printed on page 2 can all be changed in **Settings**. In
the C.C list, `{division}` is replaced by the consumer's OP division.

---

## 6. Set up the signing key (once, before real use)

With a fixed signing key, new builds install over the old app and the data is kept.

1. Make a keystore. In Claude Code, ask: *"generate an Android release keystore and tell me the 4
   values for GitHub secrets"*. On a computer with Java you can instead run:
   ```
   keytool -genkey -v -keystore mepco-release.jks -keyalg RSA -keysize 2048 -validity 10000 -alias mepco
   base64 -w 0 mepco-release.jks > keystore.txt
   ```
2. On GitHub, open the repository → **Settings → Secrets and variables → Actions → New repository
   secret**, and add these four secrets:

   | Secret name | Value |
   |---|---|
   | `ANDROID_KEYSTORE_BASE64` | the content of `keystore.txt` (the keystore in base64) |
   | `ANDROID_KEYSTORE_PASSWORD` | the keystore password |
   | `ANDROID_KEY_ALIAS` | the alias (e.g. `mepco`) |
   | `ANDROID_KEY_PASSWORD` | the key password |

3. **Keep the `.jks` file and the passwords somewhere safe**, such as Google Drive and a written
   copy. If they are lost, future updates can't install over the app.
4. The next build is signed with this key. Uninstall the old debug-signed app once (back up
   first), install the new one, and restore your backup. From then on, updates install directly.

---

## For developers

- Flutter (stable) with drift (SQLite), Riverpod, go_router, pdf/printing, share_plus and
  file_picker. See `CLAUDE.md` for the rules and `PLAN.md` for the build plan.
- `lib/domain/` holds the report templates, calculation rules and validators (pure Dart, unit
  tested). `lib/features/pdf/` holds the PDF builder.
- Commands:
  ```
  flutter pub get
  dart run build_runner build --delete-conflicting-outputs   # drift code
  flutter analyze
  flutter test
  flutter build apk --release
  ```
- `.github/workflows/build-apk.yml` runs all of these on every push and publishes the APK as a
  GitHub Release named `build-<run number>`.
- The app icon is drawn by `docs/make_icon.py`.
