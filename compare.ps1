function Compare-WordFiles {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$SourceFilePath,
        
        [Parameter(Mandatory = $true)]
        [string]$TargetFilePath
    )

    # 載入 source.txt 並以空白字元分割成字串陣列
    $sourceContent = Get-Content $SourceFilePath -Raw
    $sourceWords = $sourceContent -split ' '

    # 載入 target.txt 的內容
    $targetContent = Get-Content $TargetFilePath -Raw

    # 初始化變數
    $matchWords = @()
    $noMatchWords = @()

    # 迴圈方式比對 sourceWords 是否存在於 targetContent 中
    foreach ($word in $sourceWords) {
        $pattern = $word
        if ($word -match '\p{IsBasicLatin}') {
            $pattern = [regex]::Escape($word)  # 轉譯特殊字元
            $pattern = "(?:\b|\s)$pattern(?:\b|\s)"  # 英文單字增加邊界
        }
        if ($targetContent -match $pattern) {
            $matchWords += $word
        } else {
            $noMatchWords += $word
        }
    }

    # 已指定格式輸出比對結果
    $matchWordsString = $matchWords -join '", "'
    $noMatchWordsString = $noMatchWords -join '", "'

    $successRate = [math]::Round(($matchWords.Count / $sourceWords.Count) * 100, 2)

    # 比對回傳結果
    return @{
        SourceFileName = $SourceFilePath
        TargetFileName = $TargetFilePath
        MatchedWords = $matchWordsString
        UnmatchedWords = $noMatchWordsString
        SuccessRate = $successRate
    }
}

# # 單一結果比對檔案
# $result = Compare-WordFiles -SourceFilePath "C:\develop\OCR_Verify\Source\ocr_words_eng_test1.txt" -TargetFilePath "C:\develop\hch_ocr\work\output\ocr_result\ocr_words_eng_test1_consola_20-300-dpi-0001.txt"
# $result 
# Write-Host "Matched Words: $($result.MatchedWords)" -ForegroundColor Green
# Write-Host "Unmatched Words: $($result.UnmatchedWords)" -ForegroundColor Red

# 匯出至 CSV 檔案 (使用 ANSI 編碼)
# $outputFilePath = "C:\temp\comparison_result.csv"
# $resultObj = New-Object PSObject -Property $result
# $resultObj | Export-Csv -Path $outputFilePath -NoTypeInformation -Encoding 'UTF8'

# Write-Host "比對結果已匯出至 $outputFilePath" -ForegroundColor Yellow


### 批次比對目錄設定 ###
# Source: 考卷答案目錄
# Target: OCR結果目錄
###################
$sourceFiles = Get-ChildItem -Path "C:\develop\OCR_Verify\Source" -Filter "*.txt"
$targetFiles = Get-ChildItem -Path "C:\develop\hch_ocr\work\output\ocr_result" -Filter "*.txt"
$results = @()
$totalSuccessRate = 0
$totalComparisons = 0

foreach ($sourceFile in $sourceFiles) {
    foreach ($targetFile in $targetFiles) {
        if ($targetFile.Name -like "*$($sourceFile.BaseName)*") {
            $result = Compare-WordFiles -SourceFilePath $sourceFile.FullName -TargetFilePath $targetFile.FullName
            $results += $result
            $totalSuccessRate += $result.SuccessRate
            $totalComparisons++
        }
    }
}

foreach ($result in $results) {
    Write-Host "Source File: $($result.SourceFileName), Target File: $($result.TargetFileName), Success Rate: $($result.SuccessRate)%"
}

if ($totalComparisons -gt 0) {
    $averageSuccessRate = [math]::Round($totalSuccessRate / $totalComparisons, 2)
    Write-Host "`n總共比對 Target 檔案 $totalComparisons 個, 平均比對成功率為: $averageSuccessRate%"
} else {
    Write-Host "`n未找到匹配的 Target 檔案進行比對"
}

