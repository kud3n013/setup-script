# Load WPF and WinForms assemblies
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# Define the XAML layout for the Windows Setup Utility
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Windows Desktop Setup" Height="650" Width="1000" 
        WindowStartupLocation="CenterScreen" Background="{DynamicResource WindowBg}">
    
    <Window.Resources>
        <!-- Light Theme base -->
        <SolidColorBrush x:Key="WindowBg" Color="#F9FAFB"/>
        <SolidColorBrush x:Key="SidebarBg" Color="#F3F4F6"/>
        <SolidColorBrush x:Key="SidebarBorder" Color="#E5E7EB"/>
        <SolidColorBrush x:Key="PanelBg" Color="White"/>
        
        <SolidColorBrush x:Key="TextHeader" Color="#111827"/>
        <SolidColorBrush x:Key="TextLabel" Color="#374151"/>
        <SolidColorBrush x:Key="TextBody" Color="#4B5563"/>
        
        <SolidColorBrush x:Key="NavBtnFg" Color="#1F2937"/>
        <SolidColorBrush x:Key="NavBtnActiveBg" Color="#E5E7EB"/>
        <SolidColorBrush x:Key="SeparatorBg" Color="#E5E7EB"/>
    </Window.Resources>

    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="220" />
            <ColumnDefinition Width="*" />
        </Grid.ColumnDefinitions>

        <!-- Sidebar Navigation Menu -->
        <Border Grid.Column="0" Background="{DynamicResource SidebarBg}" BorderBrush="{DynamicResource SidebarBorder}" BorderThickness="0,0,1,0">
            <StackPanel Margin="15,20,15,20">
                <TextBlock Text="Navigation" FontWeight="Bold" FontSize="18" Margin="0,0,0,20" Foreground="{DynamicResource TextHeader}" />
                
                <Button Name="NavInstall" Content="Install Software" Height="40" Margin="0,5,0,5" 
                        Background="Transparent" BorderThickness="0" FontSize="14" FontWeight="SemiBold"
                        HorizontalContentAlignment="Left" Padding="15,0" Foreground="{DynamicResource NavBtnFg}">
                    <Button.Resources>
                        <Style TargetType="{x:Type Border}">
                            <Setter Property="CornerRadius" Value="6"/>
                        </Style>
                    </Button.Resources>
                </Button>
                
                <Button Name="NavUserConfigs" Content="User Configs" Height="40" Margin="0,5,0,5" 
                        Background="Transparent" BorderThickness="0" FontSize="14" FontWeight="SemiBold"
                        HorizontalContentAlignment="Left" Padding="15,0" Foreground="{DynamicResource NavBtnFg}">
                    <Button.Resources>
                        <Style TargetType="{x:Type Border}">
                            <Setter Property="CornerRadius" Value="6"/>
                        </Style>
                    </Button.Resources>
                </Button>

                <Separator Margin="0,15,0,15" Background="{DynamicResource SeparatorBg}" />

                <Button Name="BtnToggleTheme" Content="🌓 Toggle Theme" Height="40" Margin="0,5,0,5" 
                        Background="Transparent" BorderThickness="0" FontSize="14" FontWeight="SemiBold"
                        HorizontalContentAlignment="Left" Padding="15,0" Foreground="{DynamicResource NavBtnFg}">
                    <Button.Resources>
                        <Style TargetType="{x:Type Border}">
                            <Setter Property="CornerRadius" Value="6"/>
                        </Style>
                    </Button.Resources>
                </Button>

            </StackPanel>
        </Border>

        <!-- Main Content Area Dashboard -->
        <Border Grid.Column="1" Background="{DynamicResource PanelBg}" Padding="30">
            <Grid Name="ContentArea">
                <Grid.RowDefinitions>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="Auto"/>
                    <RowDefinition Height="*"/>
                </Grid.RowDefinitions>
                
                <TextBlock Name="MainTitle" Grid.Row="0" Text="Welcome" FontSize="28" FontWeight="Bold" Margin="0,0,0,10" Foreground="{DynamicResource TextHeader}"/>
                <Separator Grid.Row="1" Margin="0,0,0,20" Background="{DynamicResource SeparatorBg}" />
                
                <!-- Install Panel -->
                <Grid Name="PanelInstall" Grid.Row="2" Visibility="Collapsed">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    
                    <TextBlock Grid.Row="0" Text="Package Manager Configuration" FontWeight="SemiBold" FontSize="16" Margin="0,0,0,10" Foreground="{DynamicResource TextLabel}"/>
                    
                    <StackPanel Grid.Row="1" Orientation="Horizontal" Margin="0,0,0,20" VerticalAlignment="Center">
                        <Button Name="BtnInstallScoop" Content="Install Scoop" Padding="15,5" Background="#E0E7FF" Foreground="#4338CA" BorderThickness="0" FontWeight="SemiBold" Margin="0,0,20,0">
                            <Button.Resources>
                                <Style TargetType="{x:Type Border}">
                                    <Setter Property="CornerRadius" Value="4"/>
                                </Style>
                            </Button.Resources>
                        </Button>
                        <TextBlock Text="Legend:" FontWeight="SemiBold" Foreground="{DynamicResource TextLabel}" VerticalAlignment="Center" Margin="0,0,10,0"/>
                        <TextBlock Text="■ Scoop" Foreground="#059669" FontWeight="SemiBold" VerticalAlignment="Center" Margin="0,0,10,0"/>
                        <TextBlock Text="■ Winget" Foreground="#2563EB" FontWeight="SemiBold" VerticalAlignment="Center"/>
                    </StackPanel>
                    
                    <ScrollViewer Grid.Row="2" VerticalScrollBarVisibility="Auto" Margin="0,0,0,20">
                        <WrapPanel Name="AppListPanel" Orientation="Horizontal" />
                    </ScrollViewer>

                    <Button Name="BtnInstallSelected" Grid.Row="3" Content="Install Selected" Height="40" Width="180" Background="#10B981" Foreground="White" FontWeight="Bold" FontSize="16" BorderThickness="0" HorizontalAlignment="Right" Padding="20,0">
                        <Button.Resources>
                            <Style TargetType="{x:Type Border}">
                                <Setter Property="CornerRadius" Value="6"/>
                            </Style>
                        </Button.Resources>
                    </Button>
                </Grid>

                <!-- User Configs Panel -->
                <StackPanel Name="PanelUserConfigs" Grid.Row="2" Visibility="Collapsed">
                    <TextBlock Text="Import and Export User Configurations." 
                               FontSize="15" Foreground="{DynamicResource TextBody}" TextWrapping="Wrap"/>
                </StackPanel>
                
                <!-- Welcome/Home Panel -->
                <StackPanel Name="PanelWelcome" Grid.Row="2" Visibility="Visible">
                    <TextBlock Text="Select an option from the sidebar to begin customizing your Windows installation." 
                               FontSize="15" Foreground="{DynamicResource TextBody}" TextWrapping="Wrap"/>
                </StackPanel>
            </Grid>
        </Border>
    </Grid>
</Window>
"@

# Read and Load the XAML
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
try {
    $Form = [Windows.Markup.XamlReader]::Load($reader)
}
catch {
    Write-Host "Failed to load XAML." -ForegroundColor Red
    Write-Host $_.Exception.Message
    exit
}

# Map UI Elements to PowerShell Variables
$NavInstall = $Form.FindName("NavInstall")
$NavUserConfigs = $Form.FindName("NavUserConfigs")
$BtnToggleTheme = $Form.FindName("BtnToggleTheme")
$MainTitle = $Form.FindName("MainTitle")

$PanelInstall = $Form.FindName("PanelInstall")
$PanelUserConfigs = $Form.FindName("PanelUserConfigs")
$PanelWelcome = $Form.FindName("PanelWelcome")

$BtnInstallScoop = $Form.FindName("BtnInstallScoop")

$AppListPanel = $Form.FindName("AppListPanel")
$BtnInstallSelected = $Form.FindName("BtnInstallSelected")

# Advanced Config Install Handler
function global:Invoke-AdvancedInstall {
    param(
        [string]$AppName,
        [System.Windows.Controls.Button]$Button
    )
    $data = $global:AdvancedHandlerCheckboxes[$AppName]
    if (-not $data) { return }

    if ($data.handler -eq "odt") {
        $Button.Content = "Installing..."
        $Button.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        $odtPath = Join-Path $env:ProgramFiles "OfficeDeploymentTool"
        $setupExe = Join-Path $odtPath "setup.exe"

        # Step 1: Install ODT if not present
        if (-not (Test-Path $setupExe)) {
            Write-Host "Office Deployment Tool not found. Installing via winget..." -ForegroundColor Cyan
            winget install -e --id Microsoft.OfficeDeploymentTool --accept-package-agreements --accept-source-agreements
            [System.Windows.Forms.Application]::DoEvents()
        }

        if (-not (Test-Path $setupExe)) {
            Write-Host "Failed to install Office Deployment Tool. setup.exe not found at $setupExe" -ForegroundColor Red
            $Button.Content = "Install Failed"
            $Button.IsEnabled = $true
            return
        }

        # Step 2: Build ExcludeApp lines for unchecked apps
        $excludeLines = ""
        foreach ($cb in $data.checkboxes) {
            if (-not $cb.IsChecked) {
                $excludeLines += "      <ExcludeApp ID=`"$($cb.Tag)`" />`n"
            }
        }

        # Step 2.5: Vietnamese language lines
        $viLangLine = ""
        $viProofingProduct = ""
        if ($data.viCheckbox -and $data.viCheckbox.IsChecked) {
            $viLangLine = "`n      <Language ID=`"vi-vn`" />"
            $viProofingProduct = @"

    <Product ID="ProofingTools">
      <Language ID="vi-vn" />
    </Product>
"@
        }

        # Step 3: Generate cfg.xml
        $cfgXml = @"
<Configuration ID="fa7d3c5b-dcdb-4abd-99f1-d60d307c651c">
  <Add Path="$odtPath" OfficeClientEdition="64" Channel="Current">
    <Product ID="O365ProPlusEEANoTeamsRetail">
      <Language ID="en-us" />$viLangLine
$excludeLines    </Product>$viProofingProduct
  </Add>
  <Updates Enabled="TRUE" />
  <RemoveMSI />
  <Display Level="Full" AcceptEULA="TRUE" />
</Configuration>
"@

        $cfgPath = Join-Path $odtPath "cfg.xml"
        Write-Host "Writing Office configuration to $cfgPath" -ForegroundColor Cyan
        Set-Content -Path $cfgPath -Value $cfgXml -Force

        # Step 4: Run setup.exe /configure cfg.xml as Admin
        Write-Host "Running Office Deployment Tool setup..." -ForegroundColor Cyan
        try {
            Start-Process $setupExe -ArgumentList "/configure cfg.xml" -WorkingDirectory $odtPath -Verb RunAs -Wait
            Write-Host "Office installation completed." -ForegroundColor Green
        }
        catch {
            Write-Host "Office installation failed: $_" -ForegroundColor Red
        }

        $Button.Content = "Install $AppName"
        $Button.IsEnabled = $true
    }
    elseif ($data.handler -eq "searxng") {
        $Button.Content = "Installing..."
        $Button.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        try {
            # Step 1: Verify Docker is available
            if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
                Write-Host "Docker is not installed or not in PATH. Please install Docker first." -ForegroundColor Red
                $Button.Content = "Docker Not Found"
                $Button.IsEnabled = $true
                return
            }

            # Step 2: Pull the SearxNG image
            Write-Host "Pulling SearxNG Docker image..." -ForegroundColor Cyan
            docker pull searxng/searxng
            [System.Windows.Forms.Application]::DoEvents()

            # Step 3: Create data directory for persistent config
            $searxngData = Join-Path $env:LOCALAPPDATA "SearxNG"
            if (-not (Test-Path $searxngData)) {
                New-Item -ItemType Directory -Path $searxngData -Force | Out-Null
                Write-Host "Created SearxNG data directory: $searxngData" -ForegroundColor Cyan
            }

            # Step 4: Run the container on port 8888 with auto-restart and volume
            Write-Host "Starting SearxNG container on port 8888..." -ForegroundColor Cyan
            docker run -d -p 8888:8080 --name searxng --restart unless-stopped -v "${searxngData}:/etc/searxng" searxng/searxng
            Write-Host "SearxNG is running at http://localhost:8888" -ForegroundColor Green

            $Button.Content = "SearxNG Installed"
        }
        catch {
            Write-Host "SearxNG installation failed: $_" -ForegroundColor Red
            $Button.Content = "Install Failed"
            $Button.IsEnabled = $true
        }
    }
}

# Load Applications Config and Generate UI Checkboxes
$global:AppCheckboxes = @()
$global:AdvancedHandlerCheckboxes = @{}

# Try local path first, fall back to fetching from GitHub
$appsConfigPath = Join-Path $PSScriptRoot "configs\applications.json"
$appsJsonRaw = $null

if ($PSScriptRoot -and (Test-Path $appsConfigPath)) {
    $appsJsonRaw = Get-Content -Raw $appsConfigPath
} else {
    try {
        $appsJsonRaw = Invoke-RestMethod -Uri "https://raw.githubusercontent.com/kud3n013/setup-script/master/windows/configs/applications.json"
    } catch {
        Write-Host "Failed to download applications.json from GitHub." -ForegroundColor Red
    }
}

if ($appsJsonRaw) {
    try {
        $appsConfig = $appsJsonRaw | ConvertFrom-Json
        foreach ($category in $appsConfig.PSObject.Properties) {
            $groupStack = New-Object System.Windows.Controls.StackPanel
            $groupStack.Margin = "0,0,20,30"
            $groupStack.Width = 220

            $header = New-Object System.Windows.Controls.TextBlock
            $header.Text = $category.Name
            $header.FontWeight = "SemiBold"
            $header.FontSize = 16
            $header.SetResourceReference([System.Windows.Controls.TextBlock]::ForegroundProperty, "TextLabel")
            $header.Margin = "0,0,0,10"
            $groupStack.Children.Add($header) | Out-Null

            foreach ($app in $category.Value) {
                # Advanced Configuration items render sub-app checkboxes inline
                if ($app.handler -and $app.handler -eq "odt") {
                    # App name label
                    $label = New-Object System.Windows.Controls.TextBlock
                    $label.Text = $app.name
                    $label.FontWeight = "SemiBold"
                    $label.FontSize = 14
                    $label.Foreground = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#4338CA"))
                    $label.Margin = "0,4,0,6"
                    $groupStack.Children.Add($label) | Out-Null

                    # Sub-app checkboxes
                    $handlerCheckboxes = @()
                    foreach ($subApp in $app.apps) {
                        $cb = New-Object System.Windows.Controls.CheckBox
                        $cb.Content = $subApp.name
                        $cb.Tag = $subApp.id
                        $cb.IsChecked = $subApp.default
                        $cb.Margin = "10,3,0,3"
                        $cb.FontSize = 13
                        $cb.SetResourceReference([System.Windows.Controls.Control]::ForegroundProperty, "TextBody")
                        $handlerCheckboxes += $cb
                        $groupStack.Children.Add($cb) | Out-Null
                    }

                    # Store checkboxes for install handler
                    $global:AdvancedHandlerCheckboxes[$app.name] = @{
                        handler = $app.handler
                        checkboxes = $handlerCheckboxes
                    }

                    # Vietnamese language option
                    $viCheckbox = New-Object System.Windows.Controls.CheckBox
                    $viCheckbox.Content = "Include Vietnamese"
                    $viCheckbox.IsChecked = $false
                    $viCheckbox.Margin = "0,8,0,4"
                    $viCheckbox.FontSize = 13
                    $viCheckbox.FontStyle = "Italic"
                    $viCheckbox.SetResourceReference([System.Windows.Controls.Control]::ForegroundProperty, "TextBody")
                    $groupStack.Children.Add($viCheckbox) | Out-Null

                    $global:AdvancedHandlerCheckboxes[$app.name].viCheckbox = $viCheckbox

                    # Inline install button
                    $installBtn = New-Object System.Windows.Controls.Button
                    $installBtn.Content = "Install $($app.name)"
                    $installBtn.Tag = $app.name
                    $installBtn.Margin = "0,8,0,4"
                    $installBtn.Padding = "12,6"
                    $installBtn.FontSize = 13
                    $installBtn.FontWeight = "SemiBold"
                    $installBtn.Background = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#10B981"))
                    $installBtn.Foreground = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("White"))
                    $installBtn.BorderThickness = "0"

                    $installBtn.Add_Click({
                        param($s, $e)
                        $clickedAppName = $s.Tag
                        Invoke-AdvancedInstall -AppName $clickedAppName -Button $s
                    }.GetNewClosure())

                    $groupStack.Children.Add($installBtn) | Out-Null

                    # Activation notice
                    $notice = New-Object System.Windows.Controls.TextBlock
                    $notice.Text = "After installing, run MAS to activate Office:`n  [2] Office Activation → [1] Ohook → [0] Exit"
                    $notice.TextWrapping = "Wrap"
                    $notice.FontSize = 12
                    $notice.FontStyle = "Italic"
                    $notice.Margin = "0,8,0,4"
                    $notice.SetResourceReference([System.Windows.Controls.TextBlock]::ForegroundProperty, "TextBody")
                    $groupStack.Children.Add($notice) | Out-Null

                    # MAS Activation button
                    $masBtn = New-Object System.Windows.Controls.Button
                    $masBtn.Content = "Activate Office (MAS)"
                    $masBtn.Margin = "0,4,0,4"
                    $masBtn.Padding = "12,6"
                    $masBtn.FontSize = 13
                    $masBtn.FontWeight = "SemiBold"
                    $masBtn.Background = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#E0E7FF"))
                    $masBtn.Foreground = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#4338CA"))
                    $masBtn.BorderThickness = "0"

                    $masBtn.Add_Click({
                        $masScript = Join-Path $PSScriptRoot "3rd-party\MAS_AIO.cmd"
                        if (Test-Path $masScript) {
                            Start-Process "cmd.exe" -ArgumentList "/c `"$masScript`"" -Verb RunAs
                        } else {
                            Write-Host "MAS script not found at $masScript" -ForegroundColor Red
                        }
                    })

                    $groupStack.Children.Add($masBtn) | Out-Null

                    # MAS Online Activation button
                    $masOnlineBtn = New-Object System.Windows.Controls.Button
                    $masOnlineBtn.Content = "Activate Office (MAS Online)"
                    $masOnlineBtn.Margin = "0,4,0,4"
                    $masOnlineBtn.Padding = "12,6"
                    $masOnlineBtn.FontSize = 13
                    $masOnlineBtn.FontWeight = "SemiBold"
                    $masOnlineBtn.Background = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#E0E7FF"))
                    $masOnlineBtn.Foreground = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#4338CA"))
                    $masOnlineBtn.BorderThickness = "0"

                    $masOnlineBtn.Add_Click({
                        $masOnlineCmd = 'try { irm https://get.activated.win -ErrorAction Stop | iex } catch { iex (curl.exe -s --doh-url https://1.1.1.1/dns-query https://get.activated.win | Out-String) }'
                        Start-Process "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"$masOnlineCmd`"" -Verb RunAs
                    })

                    $groupStack.Children.Add($masOnlineBtn) | Out-Null
                }
                elseif ($app.handler -and $app.handler -eq "searxng") {
                    # SearxNG section label
                    $label = New-Object System.Windows.Controls.TextBlock
                    $label.Text = $app.name
                    $label.FontWeight = "SemiBold"
                    $label.FontSize = 14
                    $label.Foreground = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#4338CA"))
                    $label.Margin = "0,14,0,4"
                    $groupStack.Children.Add($label) | Out-Null

                    # Description
                    $desc = New-Object System.Windows.Controls.TextBlock
                    $desc.Text = "Privacy-respecting metasearch engine via Docker.`nRuns on port 8888, auto-starts on boot."
                    $desc.TextWrapping = "Wrap"
                    $desc.FontSize = 12
                    $desc.FontStyle = "Italic"
                    $desc.Margin = "0,2,0,6"
                    $desc.SetResourceReference([System.Windows.Controls.TextBlock]::ForegroundProperty, "TextBody")
                    $groupStack.Children.Add($desc) | Out-Null

                    # Store handler reference
                    $global:AdvancedHandlerCheckboxes[$app.name] = @{
                        handler = $app.handler
                        checkboxes = @()
                    }

                    # Install button
                    $searxBtn = New-Object System.Windows.Controls.Button
                    $searxBtn.Content = "Install $($app.name)"
                    $searxBtn.Tag = $app.name
                    $searxBtn.Margin = "0,4,0,4"
                    $searxBtn.Padding = "12,6"
                    $searxBtn.FontSize = 13
                    $searxBtn.FontWeight = "SemiBold"
                    $searxBtn.Background = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#10B981"))
                    $searxBtn.Foreground = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("White"))
                    $searxBtn.BorderThickness = "0"

                    $searxBtn.Add_Click({
                        param($s, $e)
                        $clickedAppName = $s.Tag
                        Invoke-AdvancedInstall -AppName $clickedAppName -Button $s
                    }.GetNewClosure())

                    $groupStack.Children.Add($searxBtn) | Out-Null
                }
                else {
                    # Standard apps render as checkboxes
                    $cb = New-Object System.Windows.Controls.CheckBox
                    $cb.Content = $app.name
                    
                    # Tag metadata for install process
                    $tagObj = New-Object PSObject -Property @{ id = $app.id; type = $app.type }
                    $cb.Tag = $tagObj
                    
                    $cb.Margin = "0,4,0,4"
                    $cb.FontSize = 14
                    
                    if ($app.type -eq "scoop") {
                        $cb.Foreground = "#059669" # Emerald/Green
                    }
                    elseif ($app.type -eq "winget") {
                        $cb.Foreground = "#2563EB" # Blue
                    }
                    else {
                        $cb.SetResourceReference([System.Windows.Controls.Control]::ForegroundProperty, "TextBody")
                    }
                    
                    $global:AppCheckboxes += $cb
                    $groupStack.Children.Add($cb) | Out-Null
                }
            }

            $AppListPanel.Children.Add($groupStack) | Out-Null
        }
    }
    catch {
        Write-Host "Failed to parse applications.json config!" -ForegroundColor Red
    }
}

# Theming Logic
$global:IsDarkMode = $false

function Set-AppTheme {
    param([bool]$Dark)
    if ($Dark) {
        # Switch to Dark
        $Form.Resources["WindowBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#111827"))
        $Form.Resources["SidebarBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#1F2937"))
        $Form.Resources["SidebarBorder"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#374151"))
        $Form.Resources["PanelBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#111827"))
        $Form.Resources["TextHeader"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#F9FAFB"))
        $Form.Resources["TextLabel"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#E5E7EB"))
        $Form.Resources["TextBody"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#D1D5DB"))
        $Form.Resources["NavBtnFg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#F3F4F6"))
        $Form.Resources["NavBtnActiveBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#374151"))
        $Form.Resources["SeparatorBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#374151"))
        $global:IsDarkMode = $true
    }
    else {
        # Switch to Light
        $Form.Resources["WindowBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#F9FAFB"))
        $Form.Resources["SidebarBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#F3F4F6"))
        $Form.Resources["SidebarBorder"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#E5E7EB"))
        $Form.Resources["PanelBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("White"))
        $Form.Resources["TextHeader"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#111827"))
        $Form.Resources["TextLabel"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#374151"))
        $Form.Resources["TextBody"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#4B5563"))
        $Form.Resources["NavBtnFg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#1F2937"))
        $Form.Resources["NavBtnActiveBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#E5E7EB"))
        $Form.Resources["SeparatorBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#E5E7EB"))
        $global:IsDarkMode = $false
    }
}

# Auto-detect System Theme using Registry
$regKey = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
$lightThemeVal = (Get-ItemProperty -Path $regKey -Name AppsUseLightTheme -ErrorAction SilentlyContinue).AppsUseLightTheme

if ($null -ne $lightThemeVal -and $lightThemeVal -eq 0) {
    Set-AppTheme -Dark $true
}
else {
    Set-AppTheme -Dark $false
}

$BtnToggleTheme.Add_Click({
        Set-AppTheme -Dark (-not $global:IsDarkMode)
    })

# Helper to hide all panels
function Hide-AllPanels {
    $PanelInstall.Visibility = "Collapsed"
    $PanelUserConfigs.Visibility = "Collapsed"
    $PanelWelcome.Visibility = "Collapsed"
}

# Highlight Selected Menu Helper Function
function Set-MenuHighlight {
    param([System.Windows.Controls.Button]$SelectedButton)
    $NavInstall.Background = "Transparent"
    $NavUserConfigs.Background = "Transparent"
    $SelectedButton.SetResourceReference([System.Windows.Controls.Control]::BackgroundProperty, "NavBtnActiveBg")
}

# Event Handlers for Navigation
$NavInstall.Add_Click({
        Set-MenuHighlight $NavInstall
        $MainTitle.Text = "Install Software"
        Hide-AllPanels
        $PanelInstall.Visibility = "Visible"
    })

$NavUserConfigs.Add_Click({
        Set-MenuHighlight $NavUserConfigs
        $MainTitle.Text = "User Configs"
        Hide-AllPanels
        $PanelUserConfigs.Visibility = "Visible"
    })

$BtnInstallScoop.Add_Click({
        $BtnInstallScoop.Content = "Installing..."
        $BtnInstallScoop.IsEnabled = $false
    
        # Force UI to update text before blocking the thread
        [System.Windows.Forms.Application]::DoEvents()

        try {
            if (Get-Command scoop -ErrorAction SilentlyContinue) {
                $BtnInstallScoop.Content = "Scoop Already Installed"
            }
            else {
                Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction Stop
                Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
                $BtnInstallScoop.Content = "Scoop Installed"
            }
        }
        catch {
            $BtnInstallScoop.Content = "Install Failed"
            $BtnInstallScoop.IsEnabled = $true
        }
    })

$BtnInstallSelected.Add_Click({
        $BtnInstallSelected.Content = "Installing..."
        $BtnInstallSelected.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        # Define required buckets
        $buckets = @("extras", "nonportable", "games", "main", "versions")

        # Add Scoop buckets (Silently continues if already exists)
        foreach ($b in $buckets) {
            Write-Host "Verifying bucket: $b"
            try {
                scoop bucket add $b | Out-Null
            }
            catch { }
        }

        # Gather selected apps
        $scoopApps = @()
        $wingetApps = @()

        foreach ($cb in $global:AppCheckboxes) {
            if ($cb.IsChecked) {
                $appData = $cb.Tag
                if ($appData.type -eq "scoop") {
                    $scoopApps += $appData.id
                }
                elseif ($appData.type -eq "winget") {
                    $wingetApps += $appData.id
                }
            }
        }

        # Install Scoop apps
        if ($scoopApps.Count -gt 0) {
            $scoopList = $scoopApps -join " "
            Write-Host "Installing Scoop apps: $scoopList"
            # Run in console window so user sees progress
            Invoke-Expression "scoop install $scoopList"
        }

        # Install Winget apps
        if ($wingetApps.Count -gt 0) {
            foreach ($wa in $wingetApps) {
                Write-Host "Installing Winget app: $wa"
                winget install -e --id $wa --accept-package-agreements --accept-source-agreements
            }
        }

        # WSL Setup for Docker
        if ($scoopApps -contains "main/docker") {
            Write-Host "Docker installation detected. Enabling Windows Subsystem for Linux (WSL)..." -ForegroundColor Cyan
            try {
                wsl --install
                wsl --update
                Write-Host "WSL installation completed successfully." -ForegroundColor Green
            }
            catch {
                Write-Host "Failed to install or update WSL. Manual setup may be required." -ForegroundColor Red
                Write-Host $_ -ForegroundColor Red
            }
        }

        $BtnInstallSelected.Content = "Install Selected"
        $BtnInstallSelected.IsEnabled = $true
    })

# Display the application frame
$Form.ShowDialog() | Out-Null
