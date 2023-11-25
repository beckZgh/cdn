
# 输入库名称: 如 vue
$lib = Read-Host "Enter Lib"
if (-not $lib) { return }

# 输入版本号: 如 3.3.8
$ver = Read-Host "Enter Ver"
if (-not $ver) { return }

# 获取文件列表
$api  = "https://api.cdnjs.com/libraries/$lib/$ver"
$json = Invoke-WebRequest $api | ConvertFrom-Json
if (-not $json) { return }

# CND 查询页面
# https://cdnjs.com/libraries/vue/          cdnjs cloudflare
# https://www.bootcdn.cn/vue/               Bootstrap 中文网
# https://cdn.baomitu.com/vue/              360 前端静态资源库

# 创建目录
New-Item -Name "$lib/$ver" -ItemType Directory -Force | Out-Null

# 下载文件
foreach ($file in $json.files) {
  # $uri = "https://cdnjs.cloudflare.com/ajax/libs/$lib/$ver/$file"     # cdnjs cloudflare
  # $uri = "https://cdn.bootcdn.net/ajax/libs/$lib/$ver/$file"          # Bootstrap 中文网
  # $uri = "https://cdn.staticfile.org/$lib/$ver/$file"                 # 七牛云 + 掘金
    $uri = "https://lib.baomitu.com/$lib/$ver/$file"                    # 360 前端静态资源库
    Write-Output $uri
    Invoke-WebRequest -Uri $uri -OutFile "$lib/$ver/$file"
}
