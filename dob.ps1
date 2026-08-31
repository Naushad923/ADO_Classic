
# ==========================================
# TELEGRAM BIRTHDAY NOTIFICATION
# ==========================================

$BotToken = "8792690594:AAGVEPLGKnO0f7_XDHSyJW_wCY4bKkWv9BE"
$ChatId   = "5261412431"
$CsvPath  = "./dob.csv"

$Today = Get-Date

Write-Host "Today's Date : $($Today.ToString('dd-MM-yyyy'))"
Write-Host "Checking birthdays..."
Write-Host ""

# Check CSV
if (-not (Test-Path $CsvPath)) {
    Write-Host "ERROR: dob.csv not found!" -ForegroundColor Red
    exit 1
}

# Read CSV
$Employees = Import-Csv $CsvPath

$BirthdayFound = $false

foreach ($Person in $Employees) {

    try {
        $DOB = [datetime]::ParseExact(
            $Person.DOB.Trim(),
            "dd-MM-yyyy",
            [System.Globalization.CultureInfo]::InvariantCulture
        )
    }
    catch {
        Write-Host "Invalid DOB: $($Person.DOB)" -ForegroundColor Yellow
        continue
    }

    # Check only day and month
    if ($DOB.Day -eq $Today.Day -and $DOB.Month -eq $Today.Month) {

        $BirthdayFound = $true

        Write-Host "Birthday Found!" -ForegroundColor Green
        Write-Host "Name : $($Person.Name)"
        Write-Host "DOB  : $($Person.DOB)"
        Write-Host ""

        # ONLY NAME + DATE
        $Message = "Happy Birthday, $($Person.Name)! `nDate of Birth: $($Person.DOB)"

        $TelegramUri = "https://api.telegram.org/bot$BotToken/sendMessage"

        $Body = @{
            chat_id = $ChatId
            text    = $Message
        }

        try {

            $Response = Invoke-RestMethod `
                -Uri $TelegramUri `
                -Method Post `
                -Body $Body

            if ($Response.ok -eq $true) {

                Write-Host "Telegram notification sent successfully!" -ForegroundColor Green

            }
            else {

                Write-Host "Telegram Error: $($Response.description)" -ForegroundColor Red

            }

        }
        catch {

            Write-Host "Telegram API Error:" -ForegroundColor Red
            Write-Host $_.Exception.Message -ForegroundColor Red
        }
    }
}

if (-not $BirthdayFound) {

    Write-Host "No birthday today." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Script completed." -ForegroundColor Cyan