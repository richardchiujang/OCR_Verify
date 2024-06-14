# 定义函数 ConvertToANSI 用于转换文件编码
function ConvertToANSI {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    # 读取文件内容，假定原始文件编码为 UTF-8
    $content = Get-Content $FilePath -Raw -Encoding UTF8

    # 将内容写回到文件，并设置编码为 ANSI
    $content | Set-Content -Path $FilePath -Encoding Default
}

# 設定目標目錄, 將該目錄內的所有文字檔案編碼從 UTF8 改為 ANSI
$targetDirectory = "C:\develop\hch_ocr\work\output\ocr_result"   # <=== 目錄位置 

# 获取目录中的所有 .txt 文件
$txtFiles = Get-ChildItem -Path $targetDirectory -Filter "*.txt"

# 遍历所有文件并转换编码
foreach ($file in $txtFiles) {
    ConvertToANSI -FilePath $file.FullName
    Write-Host "已將文件 $($file.Name) 的編碼調整為 ANSI 格式" -ForegroundColor Green
}

Write-Host "所有文件的編碼已調整完畢" -ForegroundColor Yellow
