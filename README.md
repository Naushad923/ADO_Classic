# ADO_Classic
Birthday Notification on Telegram 

# command to check chat id
$BotToken="8792690594:AAGVEPLGKnO0f7_XDHSyJW_wCY4bKkWv9BE"; $response=Invoke-RestMethod -Uri "https://api.telegram.org/bot$BotToken/getUpdates" -Method Get; $response | ConvertTo-Json -Depth 10



# Telegram Birthday Notification 🎂

This PowerShell script reads employee details from a CSV file and automatically sends a **birthday notification to Telegram** when an employee's birthday matches today's date.

---

## 📌 Project Overview

The script performs the following tasks:

1. Reads employee data from `dob.csv`.
2. Gets today's date from the system.
3. Checks each employee's Date of Birth.
4. Compares only the **day and month**.
5. If a birthday is found, sends a Telegram message.
6. Displays the execution status in PowerShell.

---

## 📁 Project Structure

```text
telegram-birthday/
│
├── birthday.ps1
├── dob.csv
└── README.md
```

---

## 📄 CSV Format

Create a file named:

```text
dob.csv
```

The CSV should contain the following columns:

```csv
Name,DOB
Rahul,31-08-1995
Amit,15-04-1998
Neha,31-08-2000
```

## 🤖 Telegram Bot Setup

### Step 1: Create Telegram Bot

Open Telegram and search for:

```text
@BotFather
```

Run:

```text
/newbot
```

Follow the instructions and create your bot.

BotFather will provide a **Bot Token**.

Example:

```text
123456789:AAxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

> Never share your real Bot Token publicly.

---

## 💬 Get Telegram Chat ID

Send any message to your Telegram bot first.

Then open:

```text
https://api.telegram.org/bot<BOT_TOKEN>/getUpdates
```

Example:

```text
https://api.telegram.org/bot123456789:AAxxxxxxxx/getUpdates
```

Look for:

```json
"chat": {
    "id": 5261412431
}
```

The value of `id` is your **Chat ID**.

---

## 🔐 Configure Bot Token and Chat ID

For testing, you can configure them in the PowerShell script:

```powershell
$BotToken = "YOUR_BOT_TOKEN"
$ChatId   = "YOUR_CHAT_ID"
$CsvPath  = "./dob.csv"
```

Example:

```powershell
$BotToken = "123456789:AAxxxxxxxxxxxxxxxx"
$ChatId   = "5261412431"
$CsvPath  = "./dob.csv"
```

### Recommended

For a real project, avoid hard-coding the Bot Token in the script.

Use an environment variable or a secret store instead.

---

## ▶️ How to Run

Open PowerShell in the project directory.

Example:

```powershell
cd "C:\DevOps Insider\Daily Practice\Telegram Birthday"
```

Run:

```powershell
.\birthday.ps1
```

If PowerShell blocks script execution, you can run:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
```

Then:

```powershell
.\birthday.ps1
```

---

## 🔄 How the Script Works

The script first gets today's date:

```powershell
$Today = Get-Date
```

Then it reads the CSV:

```powershell
$Employees = Import-Csv $CsvPath
```

For every employee, it converts the DOB into a DateTime object:

```powershell
$DOB = [datetime]::ParseExact(
    $Person.DOB.Trim(),
    "dd-MM-yyyy",
    [System.Globalization.CultureInfo]::InvariantCulture
)
```

The script compares only the day and month:

```powershell
if ($DOB.Day -eq $Today.Day -and $DOB.Month -eq $Today.Month)
```

This means the **birth year is ignored**.

For example:

```text
DOB       : 31-08-1995
Today     : 31-08-2026
Result    : Birthday Found
```

---

## 📩 Telegram Message

When a birthday is found, the script sends:

```text
Happy Birthday, Rahul!
Date of Birth: 31-08-1995
```

The Telegram API endpoint used is:

```text
https://api.telegram.org/bot<BOT_TOKEN>/sendMessage
```

The request contains:

```powershell
$Body = @{
    chat_id = $ChatId
    text    = $Message
}
```

---

## ❌ Invalid DOB Handling

If the DOB format is incorrect, the script displays:

```text
Invalid DOB: 31/08/1995
```

and continues processing the remaining employees.

For example, this is **invalid**:

```text
31/08/1995
```

This is **valid**:

```text
31-08-1995
```

---

## 🖥️ Example Output

If today's date is `31-08-2026` and Rahul's DOB is `31-08-1995`:

```text
Today's Date : 31-08-2026
Checking birthdays...

Birthday Found!
Name : Rahul
DOB  : 31-08-1995

Telegram notification sent successfully!

Script completed.
```

If nobody has a birthday:

```text
Today's Date : 31-08-2026
Checking birthdays...

No birthday today.

Script completed.
```

---

## ⚙️ Important Features

* ✅ PowerShell based
* ✅ CSV input
* ✅ Automatic birthday detection
* ✅ Checks day and month only
* ✅ Telegram notification
* ✅ Invalid DOB handling
* ✅ CSV file validation
* ✅ Telegram API error handling
* ✅ Multiple birthdays supported

---

## 🔒 Security Best Practice

Do **not** commit your real Telegram Bot Token to GitHub.

Instead of:

```powershell
$BotToken = "REAL_BOT_TOKEN"
```

use an environment variable:

```powershell
$BotToken = $env:TELEGRAM_BOT_TOKEN
```

Set it in PowerShell:

```powershell
$env:TELEGRAM_BOT_TOKEN = "YOUR_BOT_TOKEN"
```

Then run:

```powershell
.\birthday.ps1
```

You can also store the token as a **GitHub Actions Secret** if this project is executed through GitHub Actions.

---

## 🚀 Possible Automation

This script can be automated using:

* Windows Task Scheduler
* GitHub Actions
* Azure DevOps Pipeline
* Self-hosted GitHub Actions Runner

For example, the script can run every morning at:

```text
09:00 AM
```

and automatically send birthday notifications to Telegram.

---

## 🛠️ Requirements

* Windows
* PowerShell 5.1 or PowerShell 7+
* Internet connectivity
* Telegram Bot
* Telegram Chat ID
* `dob.csv`

No additional PowerShell modules are required.

---

## 📌 Summary

This project automates employee birthday notifications using:

```text
CSV
 ↓
PowerShell Script
 ↓
Check Today's Date
 ↓
Compare DOB Day + Month
 ↓
Birthday Found?
 ├── YES → Telegram Notification
 └── NO  → No Birthday Today
```

---

## 👨‍💻 Author

**Naushad Alam**

DevOps / DevSecOps Engineer
