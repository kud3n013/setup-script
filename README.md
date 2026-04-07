# setup-sKript
*Yes, I know, it's a typo.*

A collection of scripts and utilities to automate and manage the setup of my Windows (and maybe Linux) environments.

## Windows Setup Utility

A robust, WPF-based graphical user interface (GUI) written in PowerShell for managing Windows application installations and user configurations. 

### Features

- **Software Installation Manager:**
  - Dynamically loads and categorizes software from `windows/configs/applications.json`.
  - Seamlessly handles installations across multiple package managers (`scoop` and `winget`).
  - Automatically installs Scoop package manager if not found.
  - Handles WSL (Windows Subsystem for Linux) setup automatically when Docker is selected.
  
- **Advanced Application Deployments:**
  - **Microsoft Office:** Granular component selection, customizable language options (e.g., Vietnamese), and automated deployment using the Office Deployment Tool (ODT). Includes built-in integration with Microsoft Activation Scripts (MAS) for easy activation (including MAS Online).
  - **SearxNG:** Automated deployment of a privacy-respecting metasearch engine via Docker, running automatically on system boot.

- **User Preferences and Theming:**
  - Built-in Dark and Light themes.
  - Automatically synchronizes with the Windows system theme on startup.
  - "User Configs" tab to handle importing and exporting of personal configuration files.
  
### Usage

**The Easiest Way: Run Directly from the Internet**

You can run the setup utility directly without downloading the repository.
1. Press `Windows Key + X` and select **Terminal (Admin)** or **Windows PowerShell (Admin)**.
2. Run the following command:

```powershell
irm "https://raw.githubusercontent.com/kud3n013/sKript/master/windows/main.ps1" | iex
```

**Alternative: Run Locally**

If you have cloned the repository, execute `main.ps1` in a PowerShell terminal:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\windows\main.ps1
```

### Configuration

The software list is fully customizable. Add or modify applications by editing `windows/configs/applications.json`. Apps support `scoop`, `winget`, and advanced `handler` types (e.g., `odt`, `searxng`).
