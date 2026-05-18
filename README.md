# BloatPurge.ps1

A PowerShell script for removing pre-installed Windows bloatware, disabling telemetry, and cleaning up unnecessary features on Windows 10/11 machines.

## Application Tier

**Tier 4 — Standard**

See the [AZZ Engineering Guide — Application Tiers](https://github.com/azzincr/AZZ-Engineering-Guide/blob/main/chapters/02-application-tiers.md) for tier definitions and requirements.

## Ownership

| Role | Name / Team |
|---|---|
| System owner | Johnny Elliott |
| Development team | IT Infrastructure Admins |

## Getting Started

### Prerequisites

- PowerShell 5.1 or later (PowerShell 7+ recommended)
- Must be run as **Administrator**

### Setup

```bash
git clone https://github.com/azzincr/vdi.git
cd vdi
```

### Running Locally

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\BloatPurge.ps1
```

## Architecture

Standalone PowerShell script — no external dependencies, services, or build pipeline. Operates entirely via local registry edits, Appx package removal, and Windows service management.

**Key operations:**
- Appx package removal and deprovisioning
- Registry modifications across `HKLM` and `HKCU`
- Scheduled task disablement
- Windows service configuration

## Development

### Formatter / Linter

- **Formatter:** {tool and command}
- **Linter:** {tool and command}

### Running Tests

```bash
# {Command to run tests}
```

### Current Code Coverage

{Coverage percentage} — baseline established {date}

### Branch and PR Conventions

See the [AZZ Engineering Guide — Git Workflow](https://github.com/azzincr/AZZ-Engineering-Guide/blob/main/chapters/04-git-workflow.md).

## Deployment

Script is executed automatically during VDI provisioning via Terraform using the Azure VM Custom Script Extension. Terraform fetches BloatPurge.ps1 directly from this repository and executes it with Administrator privileges on the target machine during provisioning.

### Environments

| Environment | URL / Location | Deployment Trigger |
|---|---|---|
| N/A | Local machine | Manual execution |

## Observability

Script outputs status messages to the console via `Write-Output` at each major step. No external logging or monitoring integration.

| Resource | Location |
|---|---|
| Logs | Console output (stdout) |
| Dashboard | N/A |
| Health check | N/A |

## Configuration

No external configuration required. All settings are hardcoded within the script.

| Variable | Description | Required | Default |
|---|---|---|---|
| N/A | No configurable variables | — | — |

> **Note:** Never include secret values in this table. Document variable names and purpose only.

## Troubleshooting

| Problem | Solution |
|---|---|
| Script errors on missing registry keys | Expected — `$ErrorActionPreference = 'SilentlyContinue'` suppresses these by design |
| Appx packages return after removal | Ensure the script is run as Administrator so deprovisioning (`Remove-AppxProvisionedPackage`) completes |
| Search box / taskbar changes not applying | Some `HKCU` keys require a sign-out or Explorer restart to take effect |
| Settings not applying on new user profiles | `HKCU` changes only affect the current user; apply via Default User hive or GPO for new profiles |
