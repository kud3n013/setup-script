# Load WPF and WinForms assemblies
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# Define the XAML layout for the Windows Setup Utility
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Windows Setup Utility" Height="700" Width="1050" 
        MinWidth="920" MinHeight="550"
        WindowStartupLocation="CenterScreen" Background="{DynamicResource WindowBg}">
    
    <Window.Resources>
        <!-- Color Palette (Slate scale) -->
        <SolidColorBrush x:Key="WindowBg" Color="#F8FAFC"/>
        <SolidColorBrush x:Key="SidebarBg" Color="#F1F5F9"/>
        <SolidColorBrush x:Key="SidebarBorder" Color="#E2E8F0"/>
        <SolidColorBrush x:Key="PanelBg" Color="White"/>
        <SolidColorBrush x:Key="CardBg" Color="#F8FAFC"/>
        <SolidColorBrush x:Key="CardBorder" Color="#E2E8F0"/>
        
        <SolidColorBrush x:Key="TextHeader" Color="#0F172A"/>
        <SolidColorBrush x:Key="TextLabel" Color="#334155"/>
        <SolidColorBrush x:Key="TextBody" Color="#475569"/>
        <SolidColorBrush x:Key="TextMuted" Color="#94A3B8"/>
        
        <SolidColorBrush x:Key="NavBtnFg" Color="#334155"/>
        <SolidColorBrush x:Key="NavBtnActiveBg" Color="#E2E8F0"/>
        <SolidColorBrush x:Key="SeparatorBg" Color="#E2E8F0"/>
        <SolidColorBrush x:Key="StatusBarBg" Color="#F1F5F9"/>
        <SolidColorBrush x:Key="SearchBg" Color="#F1F5F9"/>
        <SolidColorBrush x:Key="SearchBorder" Color="#CBD5E1"/>
    </Window.Resources>

    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto" />
            <RowDefinition Height="*" />
            <RowDefinition Height="Auto" />
        </Grid.RowDefinitions>

        <!-- ═══ Top Navigation Bar ═══ -->
        <Border Grid.Row="0" Background="{DynamicResource SidebarBg}" BorderBrush="{DynamicResource SidebarBorder}" BorderThickness="0,0,0,1">
            <Grid Margin="20,8,20,8">
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="Auto"/>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>

                <!-- App Title -->
                <TextBlock Grid.Column="0" Text="Setup Utility" FontWeight="Bold" FontSize="17" 
                           Foreground="{DynamicResource TextHeader}" VerticalAlignment="Center" Margin="0,0,20,0"/>

                <!-- Center Nav Buttons -->
                <StackPanel Grid.Column="1" Orientation="Horizontal" HorizontalAlignment="Center" VerticalAlignment="Center">
                    <Button Name="NavInstall" Content="Apps" Height="34" Margin="2,0" 
                            Background="Transparent" BorderThickness="0" FontSize="13" FontWeight="SemiBold"
                            Padding="18,0" Foreground="{DynamicResource NavBtnFg}">
                        <Button.Resources>
                            <Style TargetType="{x:Type Border}">
                                <Setter Property="CornerRadius" Value="6"/>
                            </Style>
                        </Button.Resources>
                    </Button>
                    
                    <Button Name="NavUserConfigs" Content="Configure" Height="34" Margin="2,0" 
                            Background="Transparent" BorderThickness="0" FontSize="13" FontWeight="SemiBold"
                            Padding="18,0" Foreground="{DynamicResource NavBtnFg}">
                        <Button.Resources>
                            <Style TargetType="{x:Type Border}">
                                <Setter Property="CornerRadius" Value="6"/>
                            </Style>
                        </Button.Resources>
                    </Button>

                    <Button Name="NavAdvancedTools" Content="Tools" Height="34" Margin="2,0" 
                            Background="Transparent" BorderThickness="0" FontSize="13" FontWeight="SemiBold"
                            Padding="18,0" Foreground="{DynamicResource NavBtnFg}">
                        <Button.Resources>
                            <Style TargetType="{x:Type Border}">
                                <Setter Property="CornerRadius" Value="6"/>
                            </Style>
                        </Button.Resources>
                    </Button>

                    <Button Name="NavShortcutsKreation" Content="Shortcuts" Height="34" Margin="2,0" 
                            Background="Transparent" BorderThickness="0" FontSize="13" FontWeight="SemiBold"
                            Padding="18,0" Foreground="{DynamicResource NavBtnFg}">
                        <Button.Resources>
                            <Style TargetType="{x:Type Border}">
                                <Setter Property="CornerRadius" Value="6"/>
                            </Style>
                        </Button.Resources>
                    </Button>

                    <Button Name="NavDebloat" Content="Debloat" Height="34" Margin="2,0" 
                            Background="Transparent" BorderThickness="0" FontSize="13" FontWeight="SemiBold"
                            Padding="18,0" Foreground="{DynamicResource NavBtnFg}">
                        <Button.Resources>
                            <Style TargetType="{x:Type Border}">
                                <Setter Property="CornerRadius" Value="6"/>
                            </Style>
                        </Button.Resources>
                    </Button>
                </StackPanel>

                <!-- Right Utility Buttons -->
                <StackPanel Grid.Column="2" Orientation="Horizontal" VerticalAlignment="Center">
                    <Button Name="BtnToggleSidebar" Content="Panel" Height="30" Margin="0,0,6,0" 
                            Background="Transparent" BorderThickness="0" FontSize="12" FontWeight="SemiBold"
                            Padding="12,0" Foreground="{DynamicResource TextMuted}">
                        <Button.Resources>
                            <Style TargetType="{x:Type Border}">
                                <Setter Property="CornerRadius" Value="6"/>
                            </Style>
                        </Button.Resources>
                    </Button>

                    <Border Width="1" Height="18" Margin="4,0,10,0" Background="{DynamicResource SeparatorBg}" />

                    <Button Name="BtnToggleTheme" Content="Theme" Height="30" 
                            Background="Transparent" BorderThickness="0" FontSize="12" FontWeight="SemiBold"
                            Padding="12,0" Foreground="{DynamicResource TextMuted}">
                        <Button.Resources>
                            <Style TargetType="{x:Type Border}">
                                <Setter Property="CornerRadius" Value="6"/>
                            </Style>
                        </Button.Resources>
                    </Button>
                </StackPanel>
            </Grid>
        </Border>

        <!-- ═══ Content Area (Sidebar + Main) ═══ -->
        <Grid Grid.Row="1">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Name="SidebarColumn" Width="230" />
                <ColumnDefinition Width="*" />
            </Grid.ColumnDefinitions>

            <!-- ─── Side Panel ─── -->
            <Border Name="SidebarBorder" Grid.Column="0" Background="{DynamicResource SidebarBg}" BorderBrush="{DynamicResource SidebarBorder}" BorderThickness="0,0,1,0">
                <Grid Margin="18,20,18,20">
                    <!-- Default Side Panel -->
                    <StackPanel Name="SidePanelDefault" Visibility="Visible">
                        <TextBlock Text="Quick Info" FontWeight="Bold" FontSize="16" Margin="0,0,0,15" Foreground="{DynamicResource TextHeader}" />
                        <TextBlock Text="Select a tab to see context-specific options." FontSize="13" Foreground="{DynamicResource TextBody}" TextWrapping="Wrap" />
                    </StackPanel>

                    <!-- Install/Apps Side Panel -->
                    <StackPanel Name="SidePanelInstall" Visibility="Collapsed">
                        <TextBlock Text="App Settings" FontWeight="Bold" FontSize="16" Margin="0,0,0,12" Foreground="{DynamicResource TextHeader}" />
                        
                        <!-- Package Manager -->
                        <TextBlock Text="PACKAGE MANAGER" FontWeight="Bold" FontSize="10" Margin="0,0,0,6" Foreground="{DynamicResource TextMuted}" />
                        <Button Name="BtnInstallScoop" Content="Install Scoop" Height="32" Background="#E0E7FF" Foreground="#4338CA" BorderThickness="0" FontWeight="SemiBold" FontSize="12" Margin="0,0,0,15">
                            <Button.Resources>
                                <Style TargetType="{x:Type Border}">
                                    <Setter Property="CornerRadius" Value="4"/>
                                </Style>
                            </Button.Resources>
                        </Button>
                        
                        <!-- Scoop Buckets -->
                        <TextBlock Text="BUCKETS" FontWeight="Bold" FontSize="10" Margin="0,0,0,6" Foreground="{DynamicResource TextMuted}" />
                        <ScrollViewer VerticalScrollBarVisibility="Auto" MaxHeight="200" Margin="0,0,0,12">
                            <WrapPanel Name="BucketListPanel" Orientation="Horizontal" Margin="0">
                                <WrapPanel.Resources>
                                    <Style TargetType="{x:Type ToggleButton}">
                                        <Setter Property="Margin" Value="0,0,4,6"/>
                                        <Setter Property="Padding" Value="6,3"/>
                                        <Setter Property="FontSize" Value="11"/>
                                        <Setter Property="FontWeight" Value="SemiBold"/>
                                        <Setter Property="BorderThickness" Value="0"/>
                                        <Setter Property="Background" Value="#E5E7EB"/>
                                        <Setter Property="Foreground" Value="#374151"/>
                                        <Setter Property="IsChecked" Value="True"/>
                                        <Setter Property="Template">
                                            <Setter.Value>
                                                <ControlTemplate TargetType="{x:Type ToggleButton}">
                                                    <Border CornerRadius="4" Background="{TemplateBinding Background}" Padding="{TemplateBinding Padding}">
                                                        <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                                                    </Border>
                                                    <ControlTemplate.Triggers>
                                                        <Trigger Property="IsChecked" Value="True">
                                                            <Setter Property="Background" Value="#D1FAE5" />
                                                            <Setter Property="Foreground" Value="#065F46" />
                                                        </Trigger>
                                                        <Trigger Property="IsChecked" Value="False">
                                                            <Setter Property="Background" Value="#FEE2E2" />
                                                            <Setter Property="Foreground" Value="#991B1B" />
                                                        </Trigger>
                                                    </ControlTemplate.Triggers>
                                                </ControlTemplate>
                                            </Setter.Value>
                                        </Setter>
                                    </Style>
                                </WrapPanel.Resources>
                                <ToggleButton Name="BucketMain" Content="main" Uid="main" Tag="main" />
                                <ToggleButton Name="BucketExtras" Content="extras" Uid="extras" Tag="extras" />
                                <ToggleButton Name="BucketVersions" Content="versions" Uid="versions" Tag="versions" />
                                <ToggleButton Name="BucketNirsoft" Content="nirsoft" Uid="nirsoft" Tag="nirsoft" />
                                <ToggleButton Name="BucketSysinternals" Content="sysinternals" Uid="sysinternals" Tag="sysinternals" />
                                <ToggleButton Name="BucketPhp" Content="php" Uid="php" Tag="php" />
                                <ToggleButton Name="BucketNerdfonts" Content="nerd-fonts" Uid="nerd-fonts" Tag="nerd-fonts" />
                                <ToggleButton Name="BucketNonportable" Content="nonportable" Uid="nonportable" Tag="nonportable" />
                                <ToggleButton Name="BucketJava" Content="java" Uid="java" Tag="java" />
                                <ToggleButton Name="BucketGames" Content="games" Uid="games" Tag="games" />
                                <ToggleButton Name="BucketDEVtools" Content="DEV-tools" Uid="DEV-tools" Tag="anderlli0053_DEV-tools|https://github.com/anderlli0053/DEV-tools" IsChecked="False" />
                                <ToggleButton Name="BucketIcekream" Content="icekream" Uid="icekream" Tag="kud3n013_icekream|https://github.com/kud3n013/icekream" IsChecked="True" />
                            </WrapPanel>
                        </ScrollViewer>

                        <!-- Selection Controls -->
                        <TextBlock Text="SELECTION" FontWeight="Bold" FontSize="10" Margin="0,0,0,6" Foreground="{DynamicResource TextMuted}" />
                        <Button Name="BtnSelectAll" Content="Select All" Height="30" Background="#D1FAE5" Foreground="#065F46" BorderThickness="0" FontWeight="SemiBold" FontSize="12" Margin="0,0,0,4">
                            <Button.Resources>
                                <Style TargetType="{x:Type Border}">
                                    <Setter Property="CornerRadius" Value="4"/>
                                </Style>
                            </Button.Resources>
                        </Button>
                        <Button Name="BtnDeselectAll" Content="Deselect All" Height="30" Background="#FEE2E2" Foreground="#991B1B" BorderThickness="0" FontWeight="SemiBold" FontSize="12" Margin="0,0,0,15">
                            <Button.Resources>
                                <Style TargetType="{x:Type Border}">
                                    <Setter Property="CornerRadius" Value="4"/>
                                </Style>
                            </Button.Resources>
                        </Button>

                        <!-- Legend -->
                        <TextBlock Text="LEGEND" FontWeight="Bold" FontSize="10" Margin="0,0,0,8" Foreground="{DynamicResource TextMuted}" />
                        <StackPanel Margin="2,0,0,0">
                            <StackPanel Orientation="Horizontal" Margin="0,0,0,5">
                                <Border Width="10" Height="10" CornerRadius="2" Background="#059669" Margin="0,0,8,0" VerticalAlignment="Center"/>
                                <TextBlock Text="Official Bucket" FontSize="12" Foreground="{DynamicResource TextBody}" VerticalAlignment="Center"/>
                            </StackPanel>
                            <StackPanel Orientation="Horizontal" Margin="0,0,0,5">
                                <Border Width="10" Height="10" CornerRadius="2" Background="#2563EB" Margin="0,0,8,0" VerticalAlignment="Center"/>
                                <TextBlock Text="Community Bucket" FontSize="12" Foreground="{DynamicResource TextBody}" VerticalAlignment="Center"/>
                            </StackPanel>
                            <StackPanel Orientation="Horizontal">
                                <Border Width="10" Height="10" CornerRadius="2" Background="#94A3B8" Margin="0,0,8,0" VerticalAlignment="Center"/>
                                <TextBlock Text="Upcoming" FontSize="12" Foreground="{DynamicResource TextBody}" VerticalAlignment="Center"/>
                            </StackPanel>
                        </StackPanel>
                    </StackPanel>

                    <!-- Shortcuts Side Panel -->
                    <StackPanel Name="SidePanelShortcuts" Visibility="Collapsed">
                        <TextBlock Text="Options" FontWeight="Bold" FontSize="16" Margin="0,0,0,12" Foreground="{DynamicResource TextHeader}" />
                        
                        <TextBlock Text="SHELL TARGET" FontWeight="Bold" FontSize="10" Margin="0,0,0,6" Foreground="{DynamicResource TextMuted}" />
                        <StackPanel Margin="0,0,0,15">
                            <RadioButton Name="RbShellPowershell" Content="powershell" IsChecked="True" Margin="0,0,0,6" Foreground="{DynamicResource TextBody}" FontSize="13"/>
                            <RadioButton Name="RbShellPwsh" Content="pwsh" Margin="0,0,0,6" Foreground="{DynamicResource TextBody}" FontSize="13"/>
                        </StackPanel>
                    </StackPanel>

                    <!-- Debloat Side Panel -->
                    <StackPanel Name="SidePanelDebloat" Visibility="Collapsed">
                        <TextBlock Text="Debloat Options" FontWeight="Bold" FontSize="16" Margin="0,0,0,12" Foreground="{DynamicResource TextHeader}" />
                        
                        <TextBlock Text="INFO" FontWeight="Bold" FontSize="10" Margin="0,0,0,6" Foreground="{DynamicResource TextMuted}" />
                        <TextBlock Text="Remove pre-installed bloatware and disable unwanted Windows services and telemetry." 
                                   FontSize="12" Foreground="{DynamicResource TextBody}" TextWrapping="Wrap" Margin="0,0,0,15"/>
                        
                        <TextBlock Text="QUICK ACTIONS" FontWeight="Bold" FontSize="10" Margin="0,0,0,6" Foreground="{DynamicResource TextMuted}" />
                        <Button Name="BtnDebloatSelectAll" Content="Select All" Height="30" Background="#D1FAE5" Foreground="#065F46" BorderThickness="0" FontWeight="SemiBold" FontSize="12" Margin="0,0,0,4">
                            <Button.Resources>
                                <Style TargetType="{x:Type Border}">
                                    <Setter Property="CornerRadius" Value="4"/>
                                </Style>
                            </Button.Resources>
                        </Button>
                        <Button Name="BtnDebloatDeselectAll" Content="Deselect All" Height="30" Background="#FEE2E2" Foreground="#991B1B" BorderThickness="0" FontWeight="SemiBold" FontSize="12" Margin="0,0,0,4">
                            <Button.Resources>
                                <Style TargetType="{x:Type Border}">
                                    <Setter Property="CornerRadius" Value="4"/>
                                </Style>
                            </Button.Resources>
                        </Button>
                    </StackPanel>

                    <!-- Version -->
                    <TextBlock Text="v26.4.16" 
                               FontSize="11" 
                               FontWeight="Medium"
                               Foreground="{DynamicResource TextMuted}" 
                               VerticalAlignment="Bottom" 
                               HorizontalAlignment="Left" />
                </Grid>
            </Border>

            <!-- ─── Main Content Area ─── -->
            <Border Grid.Column="1" Background="{DynamicResource PanelBg}" Padding="30,25,30,20">
                <Grid Name="ContentArea">
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                    </Grid.RowDefinitions>
                    
                    <!-- Title Row -->
                    <Grid Grid.Row="0" Margin="0,0,0,12">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="Auto"/>
                        </Grid.ColumnDefinitions>
                        <TextBlock Name="MainTitle" Grid.Column="0" Text="Welcome" FontSize="24" FontWeight="Bold" Foreground="{DynamicResource TextHeader}" VerticalAlignment="Center"/>
                        <TextBlock Name="SubTitle" Grid.Column="1" Text="" FontSize="13" Foreground="{DynamicResource TextMuted}" VerticalAlignment="Center"/>
                    </Grid>
                    
                    <!-- Search Bar (visible only on Apps tab) -->
                    <Border Name="SearchBarBorder" Grid.Row="1" Visibility="Collapsed" 
                            CornerRadius="6" Background="{DynamicResource SearchBg}" 
                            BorderBrush="{DynamicResource SearchBorder}" BorderThickness="1" 
                            Margin="0,0,0,15" Padding="0">
                        <Grid>
                            <Grid.ColumnDefinitions>
                                <ColumnDefinition Width="Auto"/>
                                <ColumnDefinition Width="*"/>
                            </Grid.ColumnDefinitions>
                            <TextBlock Grid.Column="0" Text="Search" FontSize="12" VerticalAlignment="Center" Margin="12,0,8,0" Foreground="{DynamicResource TextMuted}"/>
                            <TextBox Name="SearchBox" Grid.Column="1" 
                                     Background="Transparent" BorderThickness="0" 
                                     FontSize="13" Padding="4,8" 
                                     Foreground="{DynamicResource TextLabel}"
                                     VerticalContentAlignment="Center"/>
                        </Grid>
                    </Border>

                    <!-- Separator (visible when search is hidden) -->
                    <Separator Name="MainSeparator" Grid.Row="1" Margin="0,0,0,15" Background="{DynamicResource SeparatorBg}" />
                    
                    <!-- ═══ Apps Panel ═══ -->
                    <Grid Name="PanelInstall" Grid.Row="2" Visibility="Collapsed">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>
                        
                        <ScrollViewer Grid.Row="0" VerticalScrollBarVisibility="Auto" Margin="0,0,0,15">
                            <WrapPanel Name="AppListPanel" Orientation="Horizontal" />
                        </ScrollViewer>

                        <!-- Action Bar -->
                        <Border Grid.Row="1" CornerRadius="8" Background="{DynamicResource SidebarBg}" Padding="15,10">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>

                                <!-- Safe Actions (Left) -->
                                <StackPanel Grid.Column="0" Orientation="Horizontal">
                                    <Button Name="BtnInstallSelected" Content="Install Selected" Height="36" Background="#10B981" Foreground="White" FontWeight="Bold" FontSize="13" BorderThickness="0" Margin="0,0,8,0" Padding="16,0">
                                        <Button.Resources><Style TargetType="{x:Type Border}"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                                    </Button>
                                    <Button Name="BtnUpdateSelected" Content="Update Selected" Height="36" Background="#6366F1" Foreground="White" FontWeight="Bold" FontSize="13" BorderThickness="0" Margin="0,0,8,0" Padding="16,0">
                                        <Button.Resources><Style TargetType="{x:Type Border}"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                                    </Button>
                                    <Button Name="BtnUpdateAll" Content="Update All" Height="36" Background="#8B5CF6" Foreground="White" FontWeight="Bold" FontSize="13" BorderThickness="0" Padding="16,0">
                                        <Button.Resources><Style TargetType="{x:Type Border}"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                                    </Button>
                                </StackPanel>

                                <!-- Destructive Action (Right) -->
                                <Button Name="BtnUninstallSelected" Grid.Column="1" Content="Uninstall Selected" Height="36" Background="#FEE2E2" Foreground="#991B1B" FontWeight="Bold" FontSize="13" BorderThickness="0" Padding="16,0">
                                    <Button.Resources><Style TargetType="{x:Type Border}"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                                </Button>
                            </Grid>
                        </Border>
                    </Grid>

                    <!-- ═══ Configure Panel ═══ -->
                    <ScrollViewer Name="PanelUserConfigs" Grid.Row="2" Visibility="Collapsed" VerticalScrollBarVisibility="Auto">
                        <StackPanel>
                            <TextBlock Text="Configuration tools for installed applications." 
                                       FontSize="14" Foreground="{DynamicResource TextBody}" TextWrapping="Wrap" Margin="0,0,0,20"/>
                            
                            <!-- GlazeWM Card -->
                            <Border CornerRadius="8" BorderBrush="{DynamicResource CardBorder}" BorderThickness="1" Background="{DynamicResource CardBg}" Padding="20" Margin="0,0,0,12">
                                <Grid>
                                    <Grid.ColumnDefinitions>
                                        <ColumnDefinition Width="*"/>
                                        <ColumnDefinition Width="Auto"/>
                                    </Grid.ColumnDefinitions>
                                    <StackPanel Grid.Column="0" Margin="0,0,20,0">
                                        <TextBlock Text="GlazeWM Configurator" FontWeight="Bold" FontSize="15" Foreground="{DynamicResource TextHeader}" Margin="0,0,0,4"/>
                                        <TextBlock Text="Launch the GUI configurator for GlazeWM tiling window manager. Edit keybindings, gaps, rules, and more." 
                                                   FontSize="13" Foreground="{DynamicResource TextBody}" TextWrapping="Wrap"/>
                                    </StackPanel>
                                    <Button Name="BtnRunGlazeWMKonfig" Grid.Column="1" Content="Launch" Height="36" Width="100" 
                                            Background="#8B5CF6" Foreground="White" FontWeight="Bold" FontSize="13" BorderThickness="0" VerticalAlignment="Center">
                                        <Button.Resources><Style TargetType="{x:Type Border}"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                                    </Button>
                                </Grid>
                            </Border>

                            <!-- Placeholder -->
                            <Border CornerRadius="8" BorderBrush="{DynamicResource CardBorder}" BorderThickness="1" Background="{DynamicResource CardBg}" Padding="20" Margin="0,0,0,12" Opacity="0.5">
                                <StackPanel>
                                    <TextBlock Text="More configurators coming soon..." FontWeight="SemiBold" FontSize="14" Foreground="{DynamicResource TextMuted}"/>
                                    <TextBlock Text="PowerShell profile, Windows Terminal, and more." FontSize="13" Foreground="{DynamicResource TextMuted}" Margin="0,4,0,0"/>
                                </StackPanel>
                            </Border>
                        </StackPanel>
                    </ScrollViewer>

                    <!-- ═══ Tools Panel ═══ -->
                    <Grid Name="PanelAdvancedTools" Grid.Row="2" Visibility="Collapsed">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="*"/>
                        </Grid.RowDefinitions>
                        
                        <TextBlock Grid.Row="0" Text="Install and manage development tools and services." FontSize="14" Foreground="{DynamicResource TextBody}" Margin="0,0,0,15"/>
                        
                        <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
                            <WrapPanel Name="AdvancedListPanel" Orientation="Horizontal" />
                        </ScrollViewer>
                    </Grid>
                    
                    <!-- ═══ Shortcuts Panel ═══ -->
                    <ScrollViewer Name="PanelShortcutsKreation" Grid.Row="2" Visibility="Collapsed" VerticalScrollBarVisibility="Auto">
                        <StackPanel>
                            <TextBlock Text="Create desktop shortcuts for quick access to tools." 
                                       FontSize="14" Foreground="{DynamicResource TextBody}" TextWrapping="Wrap" Margin="0,0,0,20"/>
                            
                            <!-- Setup Utility Shortcut Card -->
                            <Border CornerRadius="8" BorderBrush="{DynamicResource CardBorder}" BorderThickness="1" Background="{DynamicResource CardBg}" Padding="20" Margin="0,0,0,12">
                                <Grid>
                                    <Grid.ColumnDefinitions>
                                        <ColumnDefinition Width="*"/>
                                        <ColumnDefinition Width="Auto"/>
                                    </Grid.ColumnDefinitions>
                                    <StackPanel Grid.Column="0" Margin="0,0,20,0">
                                        <TextBlock Text="Windows Setup Utility" FontWeight="Bold" FontSize="15" Foreground="{DynamicResource TextHeader}" Margin="0,0,0,4"/>
                                        <TextBlock Text="Create a desktop shortcut (.lnk) to launch this setup utility directly from GitHub." 
                                                   FontSize="13" Foreground="{DynamicResource TextBody}" TextWrapping="Wrap"/>
                                    </StackPanel>
                                    <Button Name="BtnCreateMainShortcut" Grid.Column="1" Content="Create Shortcut" Height="36" Width="130" 
                                            Background="#3B82F6" Foreground="White" FontWeight="Bold" FontSize="13" BorderThickness="0" VerticalAlignment="Center">
                                        <Button.Resources><Style TargetType="{x:Type Border}"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                                    </Button>
                                </Grid>
                            </Border>
                            
                            <!-- GlazeWM Shortcut Card -->
                            <Border CornerRadius="8" BorderBrush="{DynamicResource CardBorder}" BorderThickness="1" Background="{DynamicResource CardBg}" Padding="20" Margin="0,0,0,12">
                                <Grid>
                                    <Grid.ColumnDefinitions>
                                        <ColumnDefinition Width="*"/>
                                        <ColumnDefinition Width="Auto"/>
                                    </Grid.ColumnDefinitions>
                                    <StackPanel Grid.Column="0" Margin="0,0,20,0">
                                        <TextBlock Text="GlazeWM Configurator" FontWeight="Bold" FontSize="15" Foreground="{DynamicResource TextHeader}" Margin="0,0,0,4"/>
                                        <TextBlock Text="Create a desktop shortcut (.lnk) for the GlazeWM configuration tool." 
                                                   FontSize="13" Foreground="{DynamicResource TextBody}" TextWrapping="Wrap"/>
                                    </StackPanel>
                                    <Button Name="BtnCreateGlazeWMShortcut" Grid.Column="1" Content="Create Shortcut" Height="36" Width="130" 
                                            Background="#8B5CF6" Foreground="White" FontWeight="Bold" FontSize="13" BorderThickness="0" VerticalAlignment="Center">
                                        <Button.Resources><Style TargetType="{x:Type Border}"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                                    </Button>
                                </Grid>
                            </Border>
                        </StackPanel>
                    </ScrollViewer>

                    <!-- ═══ Debloat Panel ═══ -->
                    <Grid Name="PanelDebloat" Grid.Row="2" Visibility="Collapsed">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>
                        
                        <ScrollViewer Grid.Row="0" VerticalScrollBarVisibility="Auto" Margin="0,0,0,15">
                            <StackPanel>
                                <TextBlock Text="Remove pre-installed bloatware and disable unwanted Windows services." 
                                           FontSize="14" Foreground="{DynamicResource TextBody}" TextWrapping="Wrap" Margin="0,0,0,20"/>
                                
                                <WrapPanel Name="DebloatListPanel" Orientation="Horizontal" />
                            </StackPanel>
                        </ScrollViewer>

                        <!-- Action Bar -->
                        <Border Grid.Row="1" CornerRadius="8" Background="{DynamicResource SidebarBg}" Padding="15,10">
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/>
                                    <ColumnDefinition Width="Auto"/>
                                </Grid.ColumnDefinitions>
                                <Button Name="BtnRunDebloat" Grid.Column="0" Content="Remove Selected" Height="36" Background="#EF4444" Foreground="White" FontWeight="Bold" FontSize="13" BorderThickness="0" Padding="16,0" HorizontalAlignment="Left">
                                    <Button.Resources><Style TargetType="{x:Type Border}"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                                </Button>
                            </Grid>
                        </Border>
                    </Grid>
                    
                    <!-- ═══ Welcome/Home Panel ═══ -->
                    <StackPanel Name="PanelWelcome" Grid.Row="2" Visibility="Visible">
                        <TextBlock Text="Get started by selecting a tab from the navigation above." 
                                   FontSize="14" Foreground="{DynamicResource TextBody}" TextWrapping="Wrap" Margin="0,0,0,25"/>
                        
                        <!-- System Info Cards -->
                        <WrapPanel Name="DashboardPanel" Orientation="Horizontal" Margin="0,0,0,20"/>
                        
                        <!-- Quick Actions -->
                        <TextBlock Text="QUICK ACTIONS" FontWeight="Bold" FontSize="11" Foreground="{DynamicResource TextMuted}" Margin="0,10,0,12"/>
                        <WrapPanel Orientation="Horizontal">
                            <Button Name="BtnQuickApps" Content="Browse Apps" Height="36" Background="#E0E7FF" Foreground="#4338CA" FontWeight="SemiBold" FontSize="13" BorderThickness="0" Margin="0,0,8,8" Padding="18,0">
                                <Button.Resources><Style TargetType="{x:Type Border}"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                            </Button>
                            <Button Name="BtnQuickTools" Content="Setup Tools" Height="36" Background="#ECFDF5" Foreground="#065F46" FontWeight="SemiBold" FontSize="13" BorderThickness="0" Margin="0,0,8,8" Padding="18,0">
                                <Button.Resources><Style TargetType="{x:Type Border}"><Setter Property="CornerRadius" Value="6"/></Style></Button.Resources>
                            </Button>
                        </WrapPanel>
                    </StackPanel>
                </Grid>
            </Border>
        </Grid>

        <!-- ═══ Status Bar ═══ -->
        <Border Grid.Row="2" Background="{DynamicResource StatusBarBg}" BorderBrush="{DynamicResource SidebarBorder}" BorderThickness="0,1,0,0" Padding="20,6">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                <TextBlock Name="StatusBarText" Grid.Column="0" Text="Ready" FontSize="12" Foreground="{DynamicResource TextMuted}" VerticalAlignment="Center"/>
                <TextBlock Name="StatusBarRight" Grid.Column="1" Text="" FontSize="11" Foreground="{DynamicResource TextMuted}" VerticalAlignment="Center"/>
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
$NavAdvancedTools = $Form.FindName("NavAdvancedTools")
$NavShortcutsKreation = $Form.FindName("NavShortcutsKreation")
$NavDebloat = $Form.FindName("NavDebloat")
$BtnToggleTheme = $Form.FindName("BtnToggleTheme")
$MainTitle = $Form.FindName("MainTitle")
$SubTitle = $Form.FindName("SubTitle")

$PanelInstall = $Form.FindName("PanelInstall")
$PanelUserConfigs = $Form.FindName("PanelUserConfigs")
$PanelAdvancedTools = $Form.FindName("PanelAdvancedTools")
$PanelShortcutsKreation = $Form.FindName("PanelShortcutsKreation")
$PanelDebloat = $Form.FindName("PanelDebloat")
$PanelWelcome = $Form.FindName("PanelWelcome")
$SidePanelDefault = $Form.FindName("SidePanelDefault")
$SidePanelInstall = $Form.FindName("SidePanelInstall")
$SidePanelShortcuts = $Form.FindName("SidePanelShortcuts")
$SidePanelDebloat = $Form.FindName("SidePanelDebloat")
$DebloatListPanel = $Form.FindName("DebloatListPanel")
$BtnRunDebloat = $Form.FindName("BtnRunDebloat")
$BtnDebloatSelectAll = $Form.FindName("BtnDebloatSelectAll")
$BtnDebloatDeselectAll = $Form.FindName("BtnDebloatDeselectAll")

$BtnCreateMainShortcut = $Form.FindName("BtnCreateMainShortcut")
$BtnCreateGlazeWMShortcut = $Form.FindName("BtnCreateGlazeWMShortcut")
$BtnRunGlazeWMKonfig = $Form.FindName("BtnRunGlazeWMKonfig")
$RbShellPowershell = $Form.FindName("RbShellPowershell")
$RbShellPwsh = $Form.FindName("RbShellPwsh")
$BtnInstallScoop = $Form.FindName("BtnInstallScoop")

$AppListPanel = $Form.FindName("AppListPanel")
$AdvancedListPanel = $Form.FindName("AdvancedListPanel")
$BtnInstallSelected = $Form.FindName("BtnInstallSelected")
$BtnUninstallSelected = $Form.FindName("BtnUninstallSelected")
$BtnUpdateSelected = $Form.FindName("BtnUpdateSelected")
$BtnUpdateAll = $Form.FindName("BtnUpdateAll")
$BtnDeselectAll = $Form.FindName("BtnDeselectAll")
$BtnSelectAll = $Form.FindName("BtnSelectAll")

# New UI elements
$SearchBox = $Form.FindName("SearchBox")
$SearchBarBorder = $Form.FindName("SearchBarBorder")
$MainSeparator = $Form.FindName("MainSeparator")
$StatusBarText = $Form.FindName("StatusBarText")
$StatusBarRight = $Form.FindName("StatusBarRight")
$DashboardPanel = $Form.FindName("DashboardPanel")
$BtnQuickApps = $Form.FindName("BtnQuickApps")
$BtnQuickTools = $Form.FindName("BtnQuickTools")

# ── Status Bar Info ───────────────────────────────────────────────────────
$StatusBarRight.Text = "$env:COMPUTERNAME | PowerShell $($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor)"

# ── Dashboard Info Cards ──────────────────────────────────────────────────
function New-InfoCard {
    param([string]$Label, [string]$Value)
    $card = New-Object System.Windows.Controls.Border
    $card.CornerRadius = [System.Windows.CornerRadius]::new(8)
    $card.Padding = [System.Windows.Thickness]::new(18, 14, 18, 14)
    $card.Margin = [System.Windows.Thickness]::new(0, 0, 12, 12)
    $card.MinWidth = 160
    $card.SetResourceReference([System.Windows.Controls.Border]::BorderBrushProperty, "CardBorder")
    $card.BorderThickness = [System.Windows.Thickness]::new(1)
    $card.SetResourceReference([System.Windows.Controls.Border]::BackgroundProperty, "CardBg")
    
    $stack = New-Object System.Windows.Controls.StackPanel
    
    $labelTb = New-Object System.Windows.Controls.TextBlock
    $labelTb.Text = $Label
    $labelTb.FontSize = 11
    $labelTb.FontWeight = "Bold"
    $labelTb.SetResourceReference([System.Windows.Controls.TextBlock]::ForegroundProperty, "TextMuted")
    $labelTb.Margin = [System.Windows.Thickness]::new(0, 0, 0, 4)
    
    $valueTb = New-Object System.Windows.Controls.TextBlock
    $valueTb.Text = $Value
    $valueTb.FontSize = 16
    $valueTb.FontWeight = "Bold"
    $valueTb.SetResourceReference([System.Windows.Controls.TextBlock]::ForegroundProperty, "TextHeader")
    
    $stack.Children.Add($labelTb) | Out-Null
    $stack.Children.Add($valueTb) | Out-Null
    $card.Child = $stack
    
    return $card
}

$hostname = $env:COMPUTERNAME
$osCaption = try { (Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop).Caption -replace 'Microsoft ', '' } catch { "Windows" }
$scoopStatus = if (Get-Command scoop -ErrorAction SilentlyContinue) { "Installed" } else { "Not Found" }

$DashboardPanel.Children.Add((New-InfoCard -Label "HOSTNAME" -Value $hostname)) | Out-Null
$DashboardPanel.Children.Add((New-InfoCard -Label "OS" -Value $osCaption)) | Out-Null
$DashboardPanel.Children.Add((New-InfoCard -Label "SCOOP" -Value $scoopStatus)) | Out-Null

# ── Fuzzy Match Function ──────────────────────────────────────────────────
# Subsequence match: all query chars must appear in order within target.
# E.g. "firf" matches "Firefox", "vsc" matches "Visual Studio Code"
function Test-FuzzyMatch {
    param([string]$Text, [string]$Query)
    # Exact substring = always match
    if ($Text.Contains($Query)) { return $true }
    # Subsequence check
    $ti = 0
    for ($qi = 0; $qi -lt $Query.Length; $qi++) {
        $found = $false
        while ($ti -lt $Text.Length) {
            if ($Text[$ti] -eq $Query[$qi]) { $ti++; $found = $true; break }
            $ti++
        }
        if (-not $found) { return $false }
    }
    return $true
}

# ── Search Handler ────────────────────────────────────────────────────────
$SearchBox.Add_TextChanged({
    $query = $SearchBox.Text.Trim().ToLower()
    foreach ($group in $AppListPanel.Children) {
        if ($group -isnot [System.Windows.Controls.StackPanel]) { continue }
        if ([string]::IsNullOrEmpty($query)) {
            $group.Visibility = "Visible"
            foreach ($child in $group.Children) { $child.Visibility = "Visible" }
            continue
        }
        
        $anyMatch = $false
        foreach ($child in $group.Children) {
            # Category header (first TextBlock) — handle separately after loop
            if ($child -is [System.Windows.Controls.TextBlock] -and $child.FontWeight.ToString() -eq "SemiBold") {
                continue
            }
            $text = ""
            if ($child -is [System.Windows.Controls.CheckBox]) { $text = $child.Content.ToString() }
            elseif ($child -is [System.Windows.Controls.TextBlock]) { $text = $child.Text }
            
            if (-not [string]::IsNullOrEmpty($text) -and (Test-FuzzyMatch -Text $text.ToLower() -Query $query)) {
                $child.Visibility = "Visible"
                $anyMatch = $true
            } else {
                $child.Visibility = "Collapsed"
            }
        }
        # Show/hide entire group (including header) based on whether any child matched
        $group.Visibility = if ($anyMatch) { "Visible" } else { "Collapsed" }
        # Keep header visible when group has matches
        if ($anyMatch) {
            foreach ($child in $group.Children) {
                if ($child -is [System.Windows.Controls.TextBlock] -and $child.FontWeight.ToString() -eq "SemiBold") {
                    $child.Visibility = "Visible"
                }
            }
        }
    }
})

# ── Select All Handler ────────────────────────────────────────────────────
$BtnSelectAll.Add_Click({
    foreach ($cb in $global:AppCheckboxes) {
        if ($cb.IsEnabled) { $cb.IsChecked = $true }
    }
})

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

}

# Load Applications Config and Generate UI Checkboxes
$global:AppCheckboxes = @()
$global:AdvancedHandlerCheckboxes = @{}
$appsConfigUrl = "https://raw.githubusercontent.com/kud3n013/setup-script/master/windows/configs/applications.json"

try {
    $appsConfigPath = if ([string]::IsNullOrEmpty($PSScriptRoot)) { $null } else { Join-Path $PSScriptRoot "configs\applications.json" }

    if ($null -ne $appsConfigPath -and (Test-Path $appsConfigPath)) {
        $appsConfig = Get-Content -Raw $appsConfigPath | ConvertFrom-Json
    }
    else {
        $appsConfig = (Invoke-WebRequest -Uri $appsConfigUrl -UseBasicParsing).Content | ConvertFrom-Json
    }
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
                    handler    = $app.handler
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
                $masOnlineBtn = New-Object System.Windows.Controls.Button
                $masOnlineBtn.Content = "Activate Office (MAS)"
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

            else {
                # Standard apps render as checkboxes
                $cb = New-Object System.Windows.Controls.CheckBox
                $cb.Content = $app.name
                    
                # Tag metadata for install process
                $tagObj = New-Object PSObject -Property @{ id = $app.id; type = $app.type }
                $cb.Tag = $tagObj
                    
                $cb.Margin = "0,4,0,4"
                $cb.FontSize = 14
                    
                if ([string]::IsNullOrWhiteSpace($app.id)) {
                    $cb.IsEnabled = $false
                    $cb.Opacity = 0.5
                    $cb.SetResourceReference([System.Windows.Controls.Control]::ForegroundProperty, "TextBody")
                }
                elseif ($app.type -eq "scoop") {
                    $bucketName = $app.id.Split("/")[0]
                    $officialBuckets = @("main", "extras", "versions", "nirsoft", "sysinternals", "php", "nerd-fonts", "nonportable", "java", "games")
                        
                    if ($officialBuckets -contains $bucketName) {
                        $cb.Foreground = "#059669" # Emerald/Green
                    }
                    else {
                        $cb.Foreground = "#2563EB" # Blue
                    }
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

        if ($category.Name -in @("Useful Tools", "Server Tools")) {
            $AdvancedListPanel.Children.Add($groupStack) | Out-Null
        }
        else {
            $AppListPanel.Children.Add($groupStack) | Out-Null
        }
    }
}
catch {
    Write-Host "Failed to load or parse applications.json config!" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
}

# ── Debloat Items ─────────────────────────────────────────────────────────
$global:DebloatCheckboxes = @()

$debloatCategories = [ordered]@{
    "Microsoft Bloatware" = @(
        @{ name = "3D Viewer"; pkg = "Microsoft.Microsoft3DViewer" },
        @{ name = "Bing News"; pkg = "Microsoft.BingNews" },
        @{ name = "Bing Weather"; pkg = "Microsoft.BingWeather" },
        @{ name = "Clipchamp"; pkg = "Clipchamp.Clipchamp" },
        @{ name = "Cortana"; pkg = "Microsoft.549981C3F5F10" },
        @{ name = "Feedback Hub"; pkg = "Microsoft.WindowsFeedbackHub" },
        @{ name = "Get Help"; pkg = "Microsoft.GetHelp" },
        @{ name = "Mail and Calendar"; pkg = "microsoft.windowscommunicationsapps" },
        @{ name = "Maps"; pkg = "Microsoft.WindowsMaps" },
        @{ name = "Microsoft News"; pkg = "Microsoft.News" },
        @{ name = "Microsoft Solitaire"; pkg = "Microsoft.MicrosoftSolitaireCollection" },
        @{ name = "Microsoft To Do"; pkg = "Microsoft.Todos" },
        @{ name = "Mixed Reality Portal"; pkg = "Microsoft.MixedReality.Portal" },
        @{ name = "Office Hub"; pkg = "Microsoft.MicrosoftOfficeHub" },
        @{ name = "OneNote (Store)"; pkg = "Microsoft.Office.OneNote" },
        @{ name = "Paint 3D"; pkg = "Microsoft.MSPaint" },
        @{ name = "People"; pkg = "Microsoft.People" },
        @{ name = "Power Automate"; pkg = "Microsoft.PowerAutomateDesktop" },
        @{ name = "Skype"; pkg = "Microsoft.SkypeApp" },
        @{ name = "Sticky Notes"; pkg = "Microsoft.MicrosoftStickyNotes" },
        @{ name = "Tips"; pkg = "Microsoft.Getstarted" },
        @{ name = "Voice Recorder"; pkg = "Microsoft.WindowsSoundRecorder" },
        @{ name = "Widgets"; pkg = "MicrosoftWindows.Client.WebExperience" },
        @{ name = "Your Phone"; pkg = "Microsoft.YourPhone" }
    )
    "Xbox & Gaming" = @(
        @{ name = "Xbox"; pkg = "Microsoft.XboxGamingOverlay"; handler = "xbox" }
    )
    "Third-Party Bloat" = @(
        @{ name = "Disney+"; pkg = "Disney.37853FC22B2CE" },
        @{ name = "Spotify"; pkg = "SpotifyAB.SpotifyMusic" },
        @{ name = "TikTok"; pkg = "BytedancePte.Ltd.TikTok" },
        @{ name = "Instagram"; pkg = "Facebook.InstagramBeta" },
        @{ name = "LinkedIn"; pkg = "7EE7776C.LinkedInforWindows" },
        @{ name = "Amazon Prime Video"; pkg = "AmazonVideo.PrimeVideo" }
    )
}

foreach ($catName in $debloatCategories.Keys) {
    $groupStack = New-Object System.Windows.Controls.StackPanel
    $groupStack.Margin = "0,0,20,30"
    $groupStack.Width = 220

    $header = New-Object System.Windows.Controls.TextBlock
    $header.Text = $catName
    $header.FontWeight = "SemiBold"
    $header.FontSize = 16
    $header.SetResourceReference([System.Windows.Controls.TextBlock]::ForegroundProperty, "TextLabel")
    $header.Margin = "0,0,0,10"
    $groupStack.Children.Add($header) | Out-Null

    foreach ($item in $debloatCategories[$catName]) {
        $cb = New-Object System.Windows.Controls.CheckBox
        $cb.Content = $item.name
        $cb.Tag = [PSCustomObject]@{ pkg = $item.pkg; handler = $item.handler }
        $cb.Margin = "0,4,0,4"
        $cb.FontSize = 14
        $cb.Foreground = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#EF4444"))
        $global:DebloatCheckboxes += $cb
        $groupStack.Children.Add($cb) | Out-Null
    }

    $DebloatListPanel.Children.Add($groupStack) | Out-Null
}

# Debloat Select/Deselect All
$BtnDebloatSelectAll.Add_Click({
    foreach ($cb in $global:DebloatCheckboxes) { $cb.IsChecked = $true }
})
$BtnDebloatDeselectAll.Add_Click({
    foreach ($cb in $global:DebloatCheckboxes) { $cb.IsChecked = $false }
})

# Debloat Remove Handler
$BtnRunDebloat.Add_Click({
    $selected = @($global:DebloatCheckboxes | Where-Object { $_.IsChecked })
    if ($selected.Count -eq 0) {
        $StatusBarText.Text = "No bloatware selected for removal."
        return
    }

    $confirm = [System.Windows.MessageBox]::Show(
        "Remove $($selected.Count) selected app(s)?`nThis will uninstall them for the current user.",
        "Confirm Debloat",
        "YesNo", "Warning"
    )
    if ($confirm -ne "Yes") { return }

    $BtnRunDebloat.Content = "Removing..."
    $BtnRunDebloat.IsEnabled = $false
    [System.Windows.Forms.Application]::DoEvents()

    $removed = 0
    $failed = 0
    foreach ($cb in $selected) {
        $pkg = $cb.Tag.pkg
        $handler = $cb.Tag.handler
        Write-Host "Removing $($cb.Content) ($pkg)..." -ForegroundColor Yellow
        try {
            Get-AppxPackage $pkg -ErrorAction SilentlyContinue | Remove-AppxPackage -ErrorAction Stop
            
            # Special handler for Xbox: disable GameDVR popup via registry
            if ($handler -eq "xbox") {
                Write-Host "  Disabling GameDVR..." -ForegroundColor Cyan
                reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /f /t REG_DWORD /v "AppCaptureEnabled" /d 0 | Out-Null
                reg add "HKEY_CURRENT_USER\System\GameConfigStore" /f /t REG_DWORD /v "GameDVR_Enabled" /d 0 | Out-Null
                Write-Host "  GameDVR disabled" -ForegroundColor Green
            }
            
            Write-Host "  Removed $($cb.Content)" -ForegroundColor Green
            $cb.IsChecked = $false
            $cb.IsEnabled = $false
            $cb.Opacity = 0.4
            $removed++
        }
        catch {
            Write-Host "  Failed to remove $($cb.Content): $_" -ForegroundColor Red
            $failed++
        }
        [System.Windows.Forms.Application]::DoEvents()
    }

    $BtnRunDebloat.Content = "Remove Selected"
    $BtnRunDebloat.IsEnabled = $true
    $StatusBarText.Text = "Debloat complete: $removed removed, $failed failed."
})

# ── Docker CLI Resolution ─────────────────────────────────────────────────
# Resolve the real docker.exe from Docker Desktop (Program Files) to avoid
# broken scoop shims that shadow it in PATH.
function Resolve-DockerExe {
    $candidates = @(
        "$env:ProgramFiles\Docker\Docker\resources\bin\docker.exe"
        "${env:ProgramFiles(x86)}\Docker\Docker\resources\bin\docker.exe"
        "$env:LOCALAPPDATA\Docker\resources\bin\docker.exe"
    )
    foreach ($p in $candidates) {
        if (Test-Path $p) { return $p }
    }
    # Fallback: resolve from PATH but skip scoop shims
    $cmds = Get-Command docker.exe -All -ErrorAction SilentlyContinue
    foreach ($c in $cmds) {
        if ($c.Source -notlike '*\scoop\*') { return $c.Source }
    }
    return $null
}

$global:DockerExePath = Resolve-DockerExe

# Ensure Docker Desktop daemon is running before issuing commands
function Ensure-DockerRunning {
    if (-not $global:DockerExePath) { return }
    # Quick check: is the daemon responsive?
    & $global:DockerExePath info *>$null 2>$null
    if ($LASTEXITCODE -eq 0) { return }

    Write-Host "  Docker Desktop is not running. Starting it..." -ForegroundColor Yellow
    # Find and launch Docker Desktop
    $ddPaths = @(
        "$env:ProgramFiles\Docker\Docker\Docker Desktop.exe"
        "${env:ProgramFiles(x86)}\Docker\Docker\Docker Desktop.exe"
    )
    $launched = $false
    foreach ($ddPath in $ddPaths) {
        if (Test-Path $ddPath) {
            Start-Process $ddPath
            $launched = $true
            break
        }
    }
    if (-not $launched) {
        Write-Host "  Could not find Docker Desktop executable to start." -ForegroundColor Red
        throw "Docker Desktop is not running and could not be started."
    }

    # Wait for daemon to become responsive (up to 60s)
    $timeout = 60
    $elapsed = 0
    while ($elapsed -lt $timeout) {
        Start-Sleep -Seconds 3
        $elapsed += 3
        [System.Windows.Forms.Application]::DoEvents()
        & $global:DockerExePath info *>$null 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  Docker Desktop is ready." -ForegroundColor Green
            return
        }
        Write-Host "  Waiting for Docker Desktop... ($elapsed/$timeout s)" -ForegroundColor DarkGray
    }
    throw "Docker Desktop did not start within $timeout seconds."
}

# Wrapper to invoke docker with the resolved path and check exit code
function Invoke-Docker {
    $DockerArgs = $args
    if (-not $global:DockerExePath) {
        throw "docker.exe not found. Is Docker Desktop installed?"
    }
    Ensure-DockerRunning

    # Temporarily prepend Docker Desktop's bin dir to PATH so that
    # docker-credential-desktop.exe and other helpers are found
    $dockerBinDir = Split-Path $global:DockerExePath -Parent
    $origPath = $env:PATH
    $env:PATH = "$dockerBinDir;$env:PATH"

    $argStr = $DockerArgs -join ' '
    Write-Host "  > docker $argStr" -ForegroundColor DarkGray
    try {
        & $global:DockerExePath @DockerArgs
        if ($LASTEXITCODE -ne 0) {
            throw "docker $argStr failed with exit code $LASTEXITCODE"
        }
    }
    finally {
        $env:PATH = $origPath
    }
}

# ── Docker Desktop Section (Advanced Tools) ──────────────────────────────
$dockerGroup = New-Object System.Windows.Controls.StackPanel
$dockerGroup.Margin = "0,0,20,30"
$dockerGroup.Width = 220

$dockerHeader = New-Object System.Windows.Controls.TextBlock
$dockerHeader.Text = "Docker Desktop"
$dockerHeader.FontWeight = "SemiBold"
$dockerHeader.FontSize = 16
$dockerHeader.SetResourceReference([System.Windows.Controls.TextBlock]::ForegroundProperty, "TextLabel")
$dockerHeader.Margin = "0,0,0,10"
$dockerGroup.Children.Add($dockerHeader) | Out-Null

# Status indicator
$dockerStatus = New-Object System.Windows.Controls.TextBlock
$dockerStatus.Text = "Status: Checking..."
$dockerStatus.FontSize = 12
$dockerStatus.FontStyle = "Italic"
$dockerStatus.SetResourceReference([System.Windows.Controls.TextBlock]::ForegroundProperty, "TextBody")
$dockerStatus.Margin = "0,0,0,10"
$dockerGroup.Children.Add($dockerStatus) | Out-Null

function Update-DockerStatus {
    param($StatusBlock)
    $global:DockerExePath = Resolve-DockerExe
    $installed = ($null -ne $global:DockerExePath) -or (winget list --id Docker.DockerDesktop 2>$null | Select-String 'Docker.DockerDesktop')
    if ($installed) {
        $svc = Get-Service -Name 'com.docker.service' -ErrorAction SilentlyContinue
        if ($svc) {
            $StatusBlock.Text = "Status: Installed ($($svc.Status))"
        }
        else {
            $StatusBlock.Text = "Status: Installed"
        }
    }
    else {
        $StatusBlock.Text = "Status: Not Installed"
    }
}

Update-DockerStatus -StatusBlock $dockerStatus

# Helper to create styled buttons
function New-DockerButton {
    param([string]$Label, [string]$BgColor, [string]$FgColor)
    $btn = New-Object System.Windows.Controls.Button
    $btn.Content = $Label
    $btn.Height = 32
    $btn.Margin = "0,0,0,6"
    $btn.Padding = "10,4"
    $btn.FontSize = 13
    $btn.FontWeight = "SemiBold"
    $btn.Background = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString($BgColor))
    $btn.Foreground = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString($FgColor))
    $btn.BorderThickness = "0"
    return $btn
}

$BtnDockerInstall = New-DockerButton -Label "Install Docker Desktop"   -BgColor "#10B981" -FgColor "White"
$BtnDockerUninstall = New-DockerButton -Label "Uninstall Docker Desktop" -BgColor "#EF4444" -FgColor "White"
$BtnDockerEnable = New-DockerButton -Label "Enable Docker Desktop"    -BgColor "#3B82F6" -FgColor "White"
$BtnDockerDisable = New-DockerButton -Label "Disable Docker Desktop"   -BgColor "#F59E0B" -FgColor "White"

$dockerGroup.Children.Add($BtnDockerInstall)   | Out-Null
$dockerGroup.Children.Add($BtnDockerUninstall) | Out-Null
$dockerGroup.Children.Add($BtnDockerEnable)    | Out-Null
$dockerGroup.Children.Add($BtnDockerDisable)   | Out-Null

$AdvancedListPanel.Children.Add($dockerGroup) | Out-Null

# Docker Install Handler
$BtnDockerInstall.Add_Click({
        $BtnDockerInstall.Content = "Installing..."
        $BtnDockerInstall.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        try {
            Write-Host "Installing Docker Desktop via Winget..." -ForegroundColor Cyan
            winget install -e --id Docker.DockerDesktop --accept-package-agreements --accept-source-agreements
            if ($LASTEXITCODE -ne 0) { throw "winget install failed with exit code $LASTEXITCODE" }
            $global:DockerExePath = Resolve-DockerExe
            Write-Host "Docker Desktop installed successfully." -ForegroundColor Green
            $BtnDockerInstall.Content = "Installed!"
        }
        catch {
            Write-Host "Docker Desktop installation failed: $_" -ForegroundColor Red
            $BtnDockerInstall.Content = "Install Failed"
        }

        Update-DockerStatus -StatusBlock $dockerStatus
        $BtnDockerInstall.IsEnabled = $true
        Start-Sleep -Milliseconds 1500
        $BtnDockerInstall.Content = "Install Docker Desktop"
    })

# Docker Uninstall Handler
$BtnDockerUninstall.Add_Click({
        $BtnDockerUninstall.Content = "Uninstalling..."
        $BtnDockerUninstall.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        try {
            Write-Host "Uninstalling Docker Desktop via Winget..." -ForegroundColor Yellow
            winget uninstall -e --id Docker.DockerDesktop
            if ($LASTEXITCODE -ne 0) { throw "winget uninstall failed with exit code $LASTEXITCODE" }
            $global:DockerExePath = $null
            Write-Host "Docker Desktop uninstalled successfully." -ForegroundColor Green
            $BtnDockerUninstall.Content = "Uninstalled!"
        }
        catch {
            Write-Host "Docker Desktop uninstall failed: $_" -ForegroundColor Red
            $BtnDockerUninstall.Content = "Uninstall Failed"
        }

        Update-DockerStatus -StatusBlock $dockerStatus
        $BtnDockerUninstall.IsEnabled = $true
        Start-Sleep -Milliseconds 1500
        $BtnDockerUninstall.Content = "Uninstall Docker Desktop"
    })

# Docker Enable Handler
$BtnDockerEnable.Add_Click({
        $BtnDockerEnable.Content = "Enabling..."
        $BtnDockerEnable.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        try {
            Write-Host "Enabling Docker Desktop services..." -ForegroundColor Cyan
            $services = @('com.docker.service')
            foreach ($svcName in $services) {
                $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
                if ($svc) {
                    Set-Service -Name $svcName -StartupType Automatic -ErrorAction SilentlyContinue
                    Start-Service -Name $svcName -ErrorAction SilentlyContinue
                    Write-Host "  Started and enabled: $svcName" -ForegroundColor Green
                }
                else {
                    Write-Host "  Service not found: $svcName" -ForegroundColor Yellow
                }
            }
            $BtnDockerEnable.Content = "Enabled!"
        }
        catch {
            Write-Host "Failed to enable Docker Desktop: $_" -ForegroundColor Red
            $BtnDockerEnable.Content = "Enable Failed"
        }

        Update-DockerStatus -StatusBlock $dockerStatus
        $BtnDockerEnable.IsEnabled = $true
        Start-Sleep -Milliseconds 1500
        $BtnDockerEnable.Content = "Enable Docker Desktop"
    })

# Docker Disable Handler
$BtnDockerDisable.Add_Click({
        $BtnDockerDisable.Content = "Disabling..."
        $BtnDockerDisable.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        try {
            Write-Host "Disabling Docker Desktop services..." -ForegroundColor Yellow
            $services = @('com.docker.service')
            foreach ($svcName in $services) {
                $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
                if ($svc) {
                    Stop-Service -Name $svcName -Force -ErrorAction SilentlyContinue
                    Set-Service -Name $svcName -StartupType Disabled -ErrorAction SilentlyContinue
                    Write-Host "  Stopped and disabled: $svcName" -ForegroundColor Green
                }
                else {
                    Write-Host "  Service not found: $svcName" -ForegroundColor Yellow
                }
            }
            $BtnDockerDisable.Content = "Disabled!"
        }
        catch {
            Write-Host "Failed to disable Docker Desktop: $_" -ForegroundColor Red
            $BtnDockerDisable.Content = "Disable Failed"
        }

        Update-DockerStatus -StatusBlock $dockerStatus
        $BtnDockerDisable.IsEnabled = $true
        Start-Sleep -Milliseconds 1500
        $BtnDockerDisable.Content = "Disable Docker Desktop"
    })

# ── SearXNG Section (Advanced Tools) ─────────────────────────────────────
$searxGroup = New-Object System.Windows.Controls.StackPanel
$searxGroup.Margin = "0,0,20,30"
$searxGroup.Width = 220

$searxHeader = New-Object System.Windows.Controls.TextBlock
$searxHeader.Text = "SearXNG"
$searxHeader.FontWeight = "SemiBold"
$searxHeader.FontSize = 16
$searxHeader.SetResourceReference([System.Windows.Controls.TextBlock]::ForegroundProperty, "TextLabel")
$searxHeader.Margin = "0,0,0,10"
$searxGroup.Children.Add($searxHeader) | Out-Null

# Status indicator
$searxStatus = New-Object System.Windows.Controls.TextBlock
$searxStatus.Text = "Status: Checking..."
$searxStatus.FontSize = 12
$searxStatus.FontStyle = "Italic"
$searxStatus.SetResourceReference([System.Windows.Controls.TextBlock]::ForegroundProperty, "TextBody")
$searxStatus.Margin = "0,0,0,8"
$searxGroup.Children.Add($searxStatus) | Out-Null

function Update-SearxStatus {
    param($StatusBlock)
    if (-not $global:DockerExePath) {
        $StatusBlock.Text = "Status: Docker not found"
        return
    }
    try {
        $container = & $global:DockerExePath ps -a --filter "name=searxng" --format "{{.Status}}" 2>$null
        if ($container) {
            $StatusBlock.Text = "Status: $container"
        }
        else {
            $image = & $global:DockerExePath images searxng/searxng --format "{{.Repository}}" 2>$null
            if ($image) {
                $StatusBlock.Text = "Status: Image only (no container)"
            }
            else {
                $StatusBlock.Text = "Status: Not Installed"
            }
        }
    }
    catch {
        $StatusBlock.Text = "Status: Docker unavailable"
    }
}

Update-SearxStatus -StatusBlock $searxStatus

# Volume path label & input
$volLabel = New-Object System.Windows.Controls.TextBlock
$volLabel.Text = "Volume Path"
$volLabel.FontWeight = "SemiBold"
$volLabel.FontSize = 12
$volLabel.SetResourceReference([System.Windows.Controls.TextBlock]::ForegroundProperty, "TextLabel")
$volLabel.Margin = "0,0,0,4"
$searxGroup.Children.Add($volLabel) | Out-Null

$searxVolPath = New-Object System.Windows.Controls.TextBox
$searxVolPath.Text = (Join-Path $env:USERPROFILE ".searxng")
$searxVolPath.FontSize = 11
$searxVolPath.Padding = "6,4"
$searxVolPath.Margin = "0,0,0,10"
$searxGroup.Children.Add($searxVolPath) | Out-Null

# Port info
$portLabel = New-Object System.Windows.Controls.TextBlock
$portLabel.Text = "Port: 8888  ·  http://localhost:8888"
$portLabel.FontSize = 11
$portLabel.FontStyle = "Italic"
$portLabel.TextWrapping = "Wrap"
$portLabel.SetResourceReference([System.Windows.Controls.TextBlock]::ForegroundProperty, "TextBody")
$portLabel.Margin = "0,0,0,10"
$searxGroup.Children.Add($portLabel) | Out-Null

# Reuse the button helper from Docker section
$BtnSearxInstall = New-DockerButton -Label "Install SearXNG"   -BgColor "#10B981" -FgColor "White"
$BtnSearxUninstall = New-DockerButton -Label "Uninstall SearXNG" -BgColor "#EF4444" -FgColor "White"
$BtnSearxEnable = New-DockerButton -Label "Enable SearXNG"    -BgColor "#3B82F6" -FgColor "White"
$BtnSearxDisable = New-DockerButton -Label "Disable SearXNG"   -BgColor "#F59E0B" -FgColor "White"

$searxGroup.Children.Add($BtnSearxInstall)   | Out-Null
$searxGroup.Children.Add($BtnSearxUninstall) | Out-Null
$searxGroup.Children.Add($BtnSearxEnable)    | Out-Null
$searxGroup.Children.Add($BtnSearxDisable)   | Out-Null

$AdvancedListPanel.Children.Add($searxGroup) | Out-Null

# SearXNG Install Handler
$BtnSearxInstall.Add_Click({
        $BtnSearxInstall.Content = "Installing..."
        $BtnSearxInstall.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        try {
            # ── Step 1: Make sure Docker Engine is running ─────────────
            Write-Host "`n[Step 1/6] Ensuring Docker Engine is running..." -ForegroundColor Cyan
            if (-not $global:DockerExePath) {
                $global:DockerExePath = Resolve-DockerExe
            }
            if (-not $global:DockerExePath) {
                throw "Docker Desktop is not installed. Please install it first."
            }
            Ensure-DockerRunning
            Write-Host "  Docker Engine is running." -ForegroundColor Green

            # ── Step 2: Pull the SearXNG image ───────────────────────
            Write-Host "`n[Step 2/6] Pulling SearXNG image..." -ForegroundColor Cyan
            Invoke-Docker pull searxng/searxng:latest
            Write-Host "  Image pulled successfully." -ForegroundColor Green

            # ── Step 3: Set the container name ────────────────────────
            Write-Host "`n[Step 3/6] Container name: searxng" -ForegroundColor Cyan
            # Remove existing container if present (to avoid name conflict)
            $existing = & $global:DockerExePath ps -a --filter "name=searxng" --format "{{.ID}}" 2>$null
            if ($existing) {
                Write-Host "  Removing existing 'searxng' container..." -ForegroundColor Yellow
                Invoke-Docker rm -f searxng
            }

            # ── Step 4: Set the volume path ───────────────────────────
            $volDir = $searxVolPath.Text
            Write-Host "`n[Step 4/6] Volume path: $volDir" -ForegroundColor Cyan
            if (-not (Test-Path $volDir)) {
                New-Item -ItemType Directory -Path $volDir -Force | Out-Null
                Write-Host "  Created volume directory." -ForegroundColor Green
            } else {
                Write-Host "  Volume directory already exists." -ForegroundColor Green
            }

            # ── Step 5: Set the port to 8888 ─────────────────────────
            Write-Host "`n[Step 5/6] Port mapping: 8888 -> 8080 (container)" -ForegroundColor Cyan

            # ── Step 6: Run the container with restart policy ─────────
            Write-Host "`n[Step 6/6] Running container (restart: unless-stopped)..." -ForegroundColor Cyan
            Invoke-Docker run -d --name searxng --restart=unless-stopped --publish 8888:8080 -v "${volDir}:/etc/searxng" searxng/searxng:latest
            Write-Host "  Container started." -ForegroundColor Green

            Write-Host "`nSearXNG setup complete! Access it at http://localhost:8888" -ForegroundColor Green
            $BtnSearxInstall.Content = "Installed!"
        }
        catch {
            Write-Host "SearXNG installation failed: $_" -ForegroundColor Red
            $BtnSearxInstall.Content = "Install Failed"
        }

        Update-SearxStatus -StatusBlock $searxStatus
        $BtnSearxInstall.IsEnabled = $true
        Start-Sleep -Milliseconds 1500
        $BtnSearxInstall.Content = "Install SearXNG"
    })

# SearXNG Uninstall Handler
$BtnSearxUninstall.Add_Click({
        $BtnSearxUninstall.Content = "Uninstalling..."
        $BtnSearxUninstall.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        try {
            if (-not $global:DockerExePath) { throw "Docker not found" }

            Write-Host "Stopping and removing SearXNG container..." -ForegroundColor Yellow
            & $global:DockerExePath rm -f searxng 2>$null

            $volDir = $searxVolPath.Text
            if (Test-Path $volDir) {
                Write-Host "Removing volume directory: $volDir" -ForegroundColor Yellow
                Remove-Item -Path $volDir -Recurse -Force
            }

            Write-Host "Removing SearXNG image..." -ForegroundColor Yellow
            & $global:DockerExePath rmi searxng/searxng:latest 2>$null

            Write-Host "SearXNG fully uninstalled." -ForegroundColor Green
            $BtnSearxUninstall.Content = "Uninstalled!"
        }
        catch {
            Write-Host "SearXNG uninstall failed: $_" -ForegroundColor Red
            $BtnSearxUninstall.Content = "Uninstall Failed"
        }

        Update-SearxStatus -StatusBlock $searxStatus
        $BtnSearxUninstall.IsEnabled = $true
        Start-Sleep -Milliseconds 1500
        $BtnSearxUninstall.Content = "Uninstall SearXNG"
    })

# SearXNG Enable Handler
$BtnSearxEnable.Add_Click({
        $BtnSearxEnable.Content = "Enabling..."
        $BtnSearxEnable.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        try {
            if (-not $global:DockerExePath) { throw "Docker not found" }
            Write-Host "Starting SearXNG container..." -ForegroundColor Cyan
            Invoke-Docker start searxng
            Write-Host "SearXNG started at http://localhost:8888" -ForegroundColor Green
            $BtnSearxEnable.Content = "Enabled!"
        }
        catch {
            Write-Host "Failed to enable SearXNG: $_" -ForegroundColor Red
            $BtnSearxEnable.Content = "Enable Failed"
        }

        Update-SearxStatus -StatusBlock $searxStatus
        $BtnSearxEnable.IsEnabled = $true
        Start-Sleep -Milliseconds 1500
        $BtnSearxEnable.Content = "Enable SearXNG"
    })

# SearXNG Disable Handler
$BtnSearxDisable.Add_Click({
        $BtnSearxDisable.Content = "Disabling..."
        $BtnSearxDisable.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        try {
            if (-not $global:DockerExePath) { throw "Docker not found" }
            Write-Host "Stopping SearXNG container..." -ForegroundColor Yellow
            Invoke-Docker stop searxng
            Write-Host "SearXNG stopped." -ForegroundColor Green
            $BtnSearxDisable.Content = "Disabled!"
        }
        catch {
            Write-Host "Failed to disable SearXNG: $_" -ForegroundColor Red
            $BtnSearxDisable.Content = "Disable Failed"
        }

        Update-SearxStatus -StatusBlock $searxStatus
        $BtnSearxDisable.IsEnabled = $true
        Start-Sleep -Milliseconds 1500
        $BtnSearxDisable.Content = "Disable SearXNG"
    })

# Bind Bucket List Handlers
$BucketListPanel = $Form.FindName("BucketListPanel")
if ($null -ne $BucketListPanel) {
    foreach ($tb in $BucketListPanel.Children) {
        if ($tb -is [System.Windows.Controls.Primitives.ToggleButton]) {
            $tb.Add_Checked({
                    param($s, $e)
                    $tagStr = $s.Tag -as [string]
                    $s.Content = "..."
                    $s.IsEnabled = $false
                    [System.Windows.Forms.Application]::DoEvents()
                
                    try {
                        $parts = $tagStr.Split("|")
                        if ($parts.Count -eq 2) {
                            scoop bucket add $parts[0] $parts[1] | Out-Null
                        }
                        else {
                            scoop bucket add $tagStr | Out-Null
                        }
                    }
                    catch {}
                
                    $s.Content = $s.Uid
                    $s.IsEnabled = $true
                })
            
            $tb.Add_Unchecked({
                    param($s, $e)
                    $tagStr = $s.Tag -as [string]
                    $s.Content = "..."
                    $s.IsEnabled = $false
                    [System.Windows.Forms.Application]::DoEvents()
                
                    try {
                        $parts = $tagStr.Split("|")
                        $aliasName = $parts[0]
                        scoop bucket rm $aliasName | Out-Null
                    }
                    catch {}
                
                    $s.Content = $s.Uid
                    $s.IsEnabled = $true
                })
        }
    }
}

# Theming Logic
$global:IsDarkMode = $false

function Set-AppTheme {
    param([bool]$Dark)
    if ($Dark) {
        # Switch to Dark (Slate dark palette)
        $Form.Resources["WindowBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#0F172A"))
        $Form.Resources["SidebarBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#1E293B"))
        $Form.Resources["SidebarBorder"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#334155"))
        $Form.Resources["PanelBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#0F172A"))
        $Form.Resources["CardBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#1E293B"))
        $Form.Resources["CardBorder"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#334155"))
        $Form.Resources["TextHeader"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#F8FAFC"))
        $Form.Resources["TextLabel"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#E2E8F0"))
        $Form.Resources["TextBody"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#CBD5E1"))
        $Form.Resources["TextMuted"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#64748B"))
        $Form.Resources["NavBtnFg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#E2E8F0"))
        $Form.Resources["NavBtnActiveBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#334155"))
        $Form.Resources["SeparatorBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#334155"))
        $Form.Resources["StatusBarBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#1E293B"))
        $Form.Resources["SearchBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#1E293B"))
        $Form.Resources["SearchBorder"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#475569"))
        $global:IsDarkMode = $true
    }
    else {
        # Switch to Light (Slate light palette)
        $Form.Resources["WindowBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#F8FAFC"))
        $Form.Resources["SidebarBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#F1F5F9"))
        $Form.Resources["SidebarBorder"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#E2E8F0"))
        $Form.Resources["PanelBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("White"))
        $Form.Resources["CardBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#F8FAFC"))
        $Form.Resources["CardBorder"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#E2E8F0"))
        $Form.Resources["TextHeader"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#0F172A"))
        $Form.Resources["TextLabel"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#334155"))
        $Form.Resources["TextBody"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#475569"))
        $Form.Resources["TextMuted"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#94A3B8"))
        $Form.Resources["NavBtnFg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#334155"))
        $Form.Resources["NavBtnActiveBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#E2E8F0"))
        $Form.Resources["SeparatorBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#E2E8F0"))
        $Form.Resources["StatusBarBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#F1F5F9"))
        $Form.Resources["SearchBg"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#F1F5F9"))
        $Form.Resources["SearchBorder"] = [System.Windows.Media.SolidColorBrush]::new([System.Windows.Media.ColorConverter]::ConvertFromString("#CBD5E1"))
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

# Sidebar Toggle Logic
$BtnToggleSidebar = $Form.FindName("BtnToggleSidebar")
$SidebarBorderEl = $Form.FindName("SidebarBorder")
$SidebarColumnDef = $Form.FindName("SidebarColumn")
$global:SidebarVisible = $true

$BtnToggleSidebar.Add_Click({
        if ($global:SidebarVisible) {
            $SidebarBorderEl.Visibility = "Collapsed"
            $SidebarColumnDef.Width = [System.Windows.GridLength]::new(0)
            $global:SidebarVisible = $false
        } else {
            $SidebarBorderEl.Visibility = "Visible"
            $SidebarColumnDef.Width = [System.Windows.GridLength]::new(230)
            $global:SidebarVisible = $true
        }
    })

# Helper to hide all panels
function Hide-AllPanels {
    $PanelInstall.Visibility = "Collapsed"
    $PanelUserConfigs.Visibility = "Collapsed"
    $PanelAdvancedTools.Visibility = "Collapsed"
    $PanelShortcutsKreation.Visibility = "Collapsed"
    $PanelDebloat.Visibility = "Collapsed"
    $PanelWelcome.Visibility = "Collapsed"
    $SidePanelDefault.Visibility = "Collapsed"
    $SidePanelInstall.Visibility = "Collapsed"
    $SidePanelShortcuts.Visibility = "Collapsed"
    $SidePanelDebloat.Visibility = "Collapsed"
    $SearchBarBorder.Visibility = "Collapsed"
    $MainSeparator.Visibility = "Visible"
    $SubTitle.Text = ""
}

# Highlight Selected Menu Helper Function
function Set-MenuHighlight {
    param([System.Windows.Controls.Button]$SelectedButton)
    $NavInstall.Background = "Transparent"
    $NavUserConfigs.Background = "Transparent"
    $NavAdvancedTools.Background = "Transparent"
    $NavShortcutsKreation.Background = "Transparent"
    $NavDebloat.Background = "Transparent"
    $SelectedButton.SetResourceReference([System.Windows.Controls.Control]::BackgroundProperty, "NavBtnActiveBg")
}

# Event Handlers for Navigation
$NavInstall.Add_Click({
        Set-MenuHighlight $NavInstall
        $MainTitle.Text = "Apps"
        $SubTitle.Text = "$(@($global:AppCheckboxes).Count) apps available"
        Hide-AllPanels
        $PanelInstall.Visibility = "Visible"
        $SidePanelInstall.Visibility = "Visible"
        $SearchBarBorder.Visibility = "Visible"
        $MainSeparator.Visibility = "Collapsed"
    })

$NavUserConfigs.Add_Click({
        Set-MenuHighlight $NavUserConfigs
        $MainTitle.Text = "Configure"
        Hide-AllPanels
        $PanelUserConfigs.Visibility = "Visible"
        $SidePanelDefault.Visibility = "Visible"
    })

$NavAdvancedTools.Add_Click({
        Set-MenuHighlight $NavAdvancedTools
        $MainTitle.Text = "Tools"
        Hide-AllPanels
        $PanelAdvancedTools.Visibility = "Visible"
        $SidePanelDefault.Visibility = "Visible"
    })

$NavShortcutsKreation.Add_Click({
        Set-MenuHighlight $NavShortcutsKreation
        $MainTitle.Text = "Shortcuts"
        Hide-AllPanels
        $PanelShortcutsKreation.Visibility = "Visible"
        $SidePanelShortcuts.Visibility = "Visible"
    })

$NavDebloat.Add_Click({
        Set-MenuHighlight $NavDebloat
        $MainTitle.Text = "Debloat"
        $SubTitle.Text = "$(@($global:DebloatCheckboxes).Count) items"
        Hide-AllPanels
        $PanelDebloat.Visibility = "Visible"
        $SidePanelDebloat.Visibility = "Visible"
    })

# Quick Action Buttons (Welcome page)
$BtnQuickApps.Add_Click({
        Set-MenuHighlight $NavInstall
        $MainTitle.Text = "Apps"
        $SubTitle.Text = "$(@($global:AppCheckboxes).Count) apps available"
        Hide-AllPanels
        $PanelInstall.Visibility = "Visible"
        $SidePanelInstall.Visibility = "Visible"
        $SearchBarBorder.Visibility = "Visible"
        $MainSeparator.Visibility = "Collapsed"
    })

$BtnQuickTools.Add_Click({
        Set-MenuHighlight $NavAdvancedTools
        $MainTitle.Text = "Tools"
        Hide-AllPanels
        $PanelAdvancedTools.Visibility = "Visible"
        $SidePanelDefault.Visibility = "Visible"
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
                
                # Automatically add the icekream bucket during install
                scoop bucket add kud3n013_icekream https://github.com/kud3n013/icekream | Out-Null
                
                scoop install aria2
                scoop config aria2-warning-enabled false
                
                $BtnInstallScoop.Content = "Scoop Installed"
            }
        }
        catch {
            $BtnInstallScoop.Content = "Install Failed"
            $BtnInstallScoop.IsEnabled = $true
        }
    })

$BtnDeselectAll.Add_Click({
        foreach ($cb in $global:AppCheckboxes) {
            $cb.IsChecked = $false
        }
    })

$BtnUninstallSelected.Add_Click({
        $BtnUninstallSelected.Content = "Uninstalling..."
        $BtnUninstallSelected.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

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

        # Uninstall Scoop apps
        if ($scoopApps.Count -gt 0) {
            $scoopList = $scoopApps -join " "
            Write-Host "Uninstalling Scoop apps: $scoopList" -ForegroundColor Yellow
            Invoke-Expression "scoop uninstall $scoopList"
        }

        # Uninstall Winget apps
        if ($wingetApps.Count -gt 0) {
            foreach ($wa in $wingetApps) {
                Write-Host "Uninstalling Winget app: $wa" -ForegroundColor Yellow
                winget uninstall -e --id $wa
            }
        }

        $BtnUninstallSelected.Content = "Uninstall Selected"
        $BtnUninstallSelected.IsEnabled = $true
    })

$BtnInstallSelected.Add_Click({
        $BtnInstallSelected.Content = "Installing..."
        $BtnInstallSelected.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

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

        $BtnInstallSelected.Content = "Install Selected"
        $BtnInstallSelected.IsEnabled = $true
    })

$BtnUpdateSelected.Add_Click({
        $BtnUpdateSelected.Content = "Updating..."
        $BtnUpdateSelected.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        # Gather selected scoop apps
        $scoopApps = @()

        foreach ($cb in $global:AppCheckboxes) {
            if ($cb.IsChecked) {
                $appData = $cb.Tag
                if ($appData.type -eq "scoop") {
                    # Extract app name from bucket/app format
                    $appId = $appData.id
                    if ($appId -match '/') {
                        $appId = $appId.Split('/')[1]
                    }
                    $scoopApps += $appId
                }
            }
        }

        if ($scoopApps.Count -gt 0) {
            foreach ($app in $scoopApps) {
                Write-Host "Updating Scoop app: $app" -ForegroundColor Cyan
                Invoke-Expression "scoop update $app"
            }
        }
        else {
            Write-Host "No scoop apps selected to update." -ForegroundColor Yellow
        }

        $BtnUpdateSelected.Content = "Update Selected"
        $BtnUpdateSelected.IsEnabled = $true
    })

$BtnUpdateAll.Add_Click({
        $BtnUpdateAll.Content = "Updating All..."
        $BtnUpdateAll.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        Write-Host "Updating all Scoop apps..." -ForegroundColor Cyan
        Invoke-Expression "scoop update --all"
        Write-Host "All Scoop apps updated." -ForegroundColor Green

        $BtnUpdateAll.Content = "Update All"
        $BtnUpdateAll.IsEnabled = $true
    })

function New-ShortcutLink {
    param(
        [string]$ShortcutPath,
        [string]$FileNameBase,
        [string]$IrmUrl,
        [bool]$RequiresAdmin
    )
    $baseShell = "powershell.exe"
    if ($RbShellPwsh.IsChecked) { $baseShell = "pwsh.exe" }
    
    $appDataPath = Join-Path $env:LOCALAPPDATA "WindowsSetupUtility"
    if (-not (Test-Path $appDataPath)) { New-Item -ItemType Directory -Path $appDataPath -Force | Out-Null }
    
    $innerCmd = "irm $IrmUrl | iex"
    $adminArg = if ($RequiresAdmin) { " -Verb RunAs" } else { "" }
    
    $launcherPath = Join-Path $appDataPath "$($FileNameBase).ps1"
    $launcherContent = "Start-Process $baseShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command `"$innerCmd`"'$adminArg"
    Set-Content -Path $launcherPath -Value $launcherContent -Force
    
    $WshShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($ShortcutPath)
    $Shortcut.TargetPath = "$baseShell"
    $Shortcut.Arguments = "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$launcherPath`""
    $Shortcut.IconLocation = "$baseShell,0"
    $Shortcut.Save()
    
    # Set "Run as administrator" flag in the .lnk file (byte 0x15, bit 0x20)
    if ($RequiresAdmin) {
        $bytes = [System.IO.File]::ReadAllBytes($ShortcutPath)
        $bytes[0x15] = $bytes[0x15] -bor 0x20
        [System.IO.File]::WriteAllBytes($ShortcutPath, $bytes)
    }
}

$BtnCreateMainShortcut.Add_Click({
        $BtnCreateMainShortcut.Content = "Creating..."
        $BtnCreateMainShortcut.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        try {
            $desktopPath = [Environment]::GetFolderPath("Desktop")
            $shortcutPath = Join-Path $desktopPath "Windows Setup Utility.lnk"
            New-ShortcutLink -ShortcutPath $shortcutPath -FileNameBase "launcher" -IrmUrl "https://raw.githubusercontent.com/kud3n013/setup-script/master/windows/main.ps1" -RequiresAdmin $true
            
            Write-Host "Created shortcut at $shortcutPath" -ForegroundColor Green
            $BtnCreateMainShortcut.Content = "Shortcut Created"
        }
        catch {
            Write-Host "Failed to create shortcut: $_" -ForegroundColor Red
            $BtnCreateMainShortcut.Content = "Creation Failed"
        }
        
        # We start a runspace to reset the button after some time without blocking the UI thread
        $Runspace = [runspacefactory]::CreateRunspace()
        $Runspace.ThreadOptions = "ReuseThread"
        $Runspace.Open()
        $PowerShell = [powershell]::Create()
        $PowerShell.Runspace = $Runspace
        $PowerShell.AddScript({
                Start-Sleep -Seconds 2
                $Form.Dispatcher.Invoke({
                        $BtnCreateMainShortcut.Content = "Create Shortcut"
                        $BtnCreateMainShortcut.IsEnabled = $true
                    })
            }) | Out-Null
        $PowerShell.Runspace.SessionStateProxy.SetVariable("BtnCreateMainShortcut", $BtnCreateMainShortcut)
        $PowerShell.Runspace.SessionStateProxy.SetVariable("Form", $Form)
        $PowerShell.BeginInvoke() | Out-Null
    })

# GlazeWM Konfig Handler
$BtnRunGlazeWMKonfig.Add_Click({
        $BtnRunGlazeWMKonfig.Content = "Launching..."
        $BtnRunGlazeWMKonfig.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        try {
            Write-Host "Launching GlazeWM Konfig..." -ForegroundColor Cyan
            $cmdArgs = '-NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/kud3n013/glazewm-konfig/main/glazewm-konfig.ps1 | iex"'
            Start-Process powershell.exe -ArgumentList $cmdArgs
            Write-Host "Started GlazeWM Konfig process." -ForegroundColor Green
            $BtnRunGlazeWMKonfig.Content = "Launched"
        }
        catch {
            Write-Host "Failed to launch GlazeWM Konfig: $_" -ForegroundColor Red
            $BtnRunGlazeWMKonfig.Content = "Launch Failed"
        }
        
        # Reset the button after some time without blocking the UI thread
        $Runspace = [runspacefactory]::CreateRunspace()
        $Runspace.ThreadOptions = "ReuseThread"
        $Runspace.Open()
        $PowerShell = [powershell]::Create()
        $PowerShell.Runspace = $Runspace
        $PowerShell.AddScript({
                Start-Sleep -Seconds 2
                $Form.Dispatcher.Invoke({
                        $BtnRunGlazeWMKonfig.Content = "Launch"
                        $BtnRunGlazeWMKonfig.IsEnabled = $true
                    })
            }) | Out-Null
        $PowerShell.Runspace.SessionStateProxy.SetVariable("BtnRunGlazeWMKonfig", $BtnRunGlazeWMKonfig)
        $PowerShell.Runspace.SessionStateProxy.SetVariable("Form", $Form)
        $PowerShell.BeginInvoke() | Out-Null
    })

$BtnCreateGlazeWMShortcut.Add_Click({
        $BtnCreateGlazeWMShortcut.Content = "Creating..."
        $BtnCreateGlazeWMShortcut.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        try {
            $desktopPath = [Environment]::GetFolderPath("Desktop")
            $shortcutPath = Join-Path $desktopPath "GlazeWM Konfig.lnk"
            New-ShortcutLink -ShortcutPath $shortcutPath -FileNameBase "glazewm_launcher" -IrmUrl "https://raw.githubusercontent.com/kud3n013/glazewm-konfig/main/glazewm-konfig.ps1" -RequiresAdmin $true
            
            Write-Host "Created shortcut at $shortcutPath" -ForegroundColor Green
            $BtnCreateGlazeWMShortcut.Content = "Shortcut Created"
        }
        catch {
            Write-Host "Failed to create shortcut: $_" -ForegroundColor Red
            $BtnCreateGlazeWMShortcut.Content = "Creation Failed"
        }
        
        # We start a runspace to reset the button after some time without blocking the UI thread
        $Runspace = [runspacefactory]::CreateRunspace()
        $Runspace.ThreadOptions = "ReuseThread"
        $Runspace.Open()
        $PowerShell = [powershell]::Create()
        $PowerShell.Runspace = $Runspace
        $PowerShell.AddScript({
                Start-Sleep -Seconds 2
                $Form.Dispatcher.Invoke({
                        $BtnCreateGlazeWMShortcut.Content = "Create Shortcut"
                        $BtnCreateGlazeWMShortcut.IsEnabled = $true
                    })
            }) | Out-Null
        $PowerShell.Runspace.SessionStateProxy.SetVariable("BtnCreateGlazeWMShortcut", $BtnCreateGlazeWMShortcut)
        $PowerShell.Runspace.SessionStateProxy.SetVariable("Form", $Form)
        $PowerShell.BeginInvoke() | Out-Null
    })

# Display the application frame
$Form.ShowDialog() | Out-Null
