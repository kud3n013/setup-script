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
                
                <Button Name="NavTweaks" Content="System Tweaks" Height="40" Margin="0,5,0,5" 
                        Background="Transparent" BorderThickness="0" FontSize="14" FontWeight="SemiBold"
                        HorizontalContentAlignment="Left" Padding="15,0" Foreground="{DynamicResource NavBtnFg}">
                    <Button.Resources>
                        <Style TargetType="{x:Type Border}">
                            <Setter Property="CornerRadius" Value="6"/>
                        </Style>
                    </Button.Resources>
                </Button>
                
                <Button Name="NavConfig" Content="Settings" Height="40" Margin="0,5,0,5" 
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
                        <Button Name="BtnInstallScoop" Content="Install Scoop" Padding="15,5" Background="#E0E7FF" Foreground="#4338CA" BorderThickness="0" FontWeight="SemiBold">
                            <Button.Resources>
                                <Style TargetType="{x:Type Border}">
                                    <Setter Property="CornerRadius" Value="4"/>
                                </Style>
                            </Button.Resources>
                        </Button>
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

                <!-- Tweaks Panel -->
                <StackPanel Name="PanelTweaks" Grid.Row="2" Visibility="Collapsed">
                    <TextBlock Text="Apply custom system modifications, debloat unnecessary background tasks, and optimize performance." 
                               FontSize="15" Foreground="{DynamicResource TextBody}" TextWrapping="Wrap"/>
                </StackPanel>

                <!-- Config Panel -->
                <StackPanel Name="PanelConfig" Grid.Row="2" Visibility="Collapsed">
                    <TextBlock Text="Update your automation tool settings and manage overarching preferences." 
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
} catch {
    Write-Host "Failed to load XAML." -ForegroundColor Red
    Write-Host $_.Exception.Message
    exit
}

# Map UI Elements to PowerShell Variables
$NavInstall = $Form.FindName("NavInstall")
$NavTweaks = $Form.FindName("NavTweaks")
$NavConfig = $Form.FindName("NavConfig")
$BtnToggleTheme = $Form.FindName("BtnToggleTheme")
$MainTitle = $Form.FindName("MainTitle")

$PanelInstall = $Form.FindName("PanelInstall")
$PanelTweaks = $Form.FindName("PanelTweaks")
$PanelConfig = $Form.FindName("PanelConfig")
$PanelWelcome = $Form.FindName("PanelWelcome")

$BtnInstallScoop = $Form.FindName("BtnInstallScoop")

$AppListPanel = $Form.FindName("AppListPanel")
$BtnInstallSelected = $Form.FindName("BtnInstallSelected")

# Load Applications Config and Generate UI Checkboxes
$global:AppCheckboxes = @()
$appsConfigPath = Join-Path $PSScriptRoot "configs\applications.json"

if (Test-Path $appsConfigPath) {
    try {
        $appsConfig = Get-Content -Raw $appsConfigPath | ConvertFrom-Json
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
                $cb = New-Object System.Windows.Controls.CheckBox
                $cb.Content = $app.name
                
                # Tag metadata for install process
                $tagObj = New-Object PSObject -Property @{ id = $app.id; type = $app.type }
                $cb.Tag = $tagObj
                
                $cb.Margin = "0,4,0,4"
                $cb.FontSize = 14
                
                if ($app.type -eq "scoop") {
                    $cb.Foreground = "#059669" # Emerald/Green
                } elseif ($app.type -eq "winget") {
                    $cb.Foreground = "#2563EB" # Blue
                } else {
                    $cb.SetResourceReference([System.Windows.Controls.Control]::ForegroundProperty, "TextBody")
                }
                
                $global:AppCheckboxes += $cb
                $groupStack.Children.Add($cb) | Out-Null
            }

            $AppListPanel.Children.Add($groupStack) | Out-Null
        }
    } catch {
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
    } else {
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
} else {
    Set-AppTheme -Dark $false
}

$BtnToggleTheme.Add_Click({
    Set-AppTheme -Dark (-not $global:IsDarkMode)
})

# Helper to hide all panels
function Hide-AllPanels {
    $PanelInstall.Visibility = "Collapsed"
    $PanelTweaks.Visibility = "Collapsed"
    $PanelConfig.Visibility = "Collapsed"
    $PanelWelcome.Visibility = "Collapsed"
}

# Highlight Selected Menu Helper Function
function Set-MenuHighlight {
    param([System.Windows.Controls.Button]$SelectedButton)
    $NavInstall.Background = "Transparent"
    $NavTweaks.Background = "Transparent"
    $NavConfig.Background = "Transparent"
    $SelectedButton.SetResourceReference([System.Windows.Controls.Control]::BackgroundProperty, "NavBtnActiveBg")
}

# Event Handlers for Navigation
$NavInstall.Add_Click({
    Set-MenuHighlight $NavInstall
    $MainTitle.Text = "Install Software"
    Hide-AllPanels
    $PanelInstall.Visibility = "Visible"
})

$NavTweaks.Add_Click({
    Set-MenuHighlight $NavTweaks
    $MainTitle.Text = "System Tweaks"
    Hide-AllPanels
    $PanelTweaks.Visibility = "Visible"
})

$NavConfig.Add_Click({
    Set-MenuHighlight $NavConfig
    $MainTitle.Text = "Configuration & Settings"
    Hide-AllPanels
    $PanelConfig.Visibility = "Visible"
})

$BtnInstallScoop.Add_Click({
    $BtnInstallScoop.Content = "Installing..."
    $BtnInstallScoop.IsEnabled = $false
    
    # Force UI to update text before blocking the thread
    [System.Windows.Forms.Application]::DoEvents()

    try {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction Stop
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
        $BtnInstallScoop.Content = "Scoop Installed"
    } catch {
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
        } catch { }
    }

    # Gather selected apps
    $scoopApps = @()
    $wingetApps = @()

    foreach ($cb in $global:AppCheckboxes) {
        if ($cb.IsChecked) {
            $appData = $cb.Tag
            if ($appData.type -eq "scoop") {
                $scoopApps += $appData.id
            } elseif ($appData.type -eq "winget") {
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
        } catch {
            Write-Host "Failed to install or update WSL. Manual setup may be required." -ForegroundColor Red
            Write-Host $_ -ForegroundColor Red
        }
    }

    $BtnInstallSelected.Content = "Install Selected"
    $BtnInstallSelected.IsEnabled = $true
})

# Display the application frame
$Form.ShowDialog() | Out-Null
