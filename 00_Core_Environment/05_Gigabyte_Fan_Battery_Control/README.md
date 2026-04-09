# Gigabyte Fan Battery Control (GFBC) prereq guide

This guide is for my laptop: **Gigabyte Aorus 15 9MF**.

## Quick path (known users)

1. Install required drivers (Aorus 15 9MF):
   - Audio: `Realtek Audio driver` (for DTS)
   - Chipset (install all):
     - `Intel Serial IO`
     - `Intel Management Engine Software`
     - `Intel Innovation Platform Framework Processor Participant`
     - `Intel Chipset Software`
2. Do **not** install GCC (Gigabyte Control Center). I skip GCC because it is bloated and adds unnecessary background load.
3. Download GFBC: [Gigabyte Fan Battery Control (GitHub)](https://github.com/Ixmoon/Gigabyte-Fan-Battery-Center)
4. Use local DLL + script from this folder:
   - DLL: [`acpimof.dll`](acpimof.dll)
   - Script: [`Inject-WMI_put_me_in_extracted_GCC_installer.ps1`](Inject-WMI_put_me_in_extracted_GCC_installer.ps1)
5. Run the script as Administrator, reboot, then run GFBC.

## Detailed guide (new users)

### 1) Install driver baseline (Gigabyte Aorus 15 9MF)

Official support page: [AORUS 15 (2023) utilities and drivers](https://www.gigabyte.com/Laptop/AORUS-15--2023/support#support-dl-utility-pid8785)

Install only these vendor drivers:

- Audio:
  - Realtek Audio driver (for DTS support)
- Chipset (install all):
  - Intel Serial IO
  - Intel Management Engine Software
  - Intel Innovation Platform Framework Processor Participant
  - Intel Chipset Software

These are the minimum vendor drivers I use for this laptop profile.

### 2) Avoid GCC, use GFBC

Do this only if you do not install Gigabyte Control Center (GCC).  
I intentionally avoid GCC because it is bloated and adds unnecessary background load.

Download GFBC: [Gigabyte Fan Battery Control (GitHub)](https://github.com/Ixmoon/Gigabyte-Fan-Battery-Center)

### 3) Install WMI prereq (`acpimof.dll`) for GFBC

If GCC was never installed, the WMI provider is usually missing.  
GFBC needs `acpimof.dll` registered through the `WmiAcpi` service path to control fan/battery features correctly.

Because `acpimof.dll` is a sensitive system-level file, new users who do not trust repo-provided binaries should download GCC themselves and extract `acpimof.dll` from the official package.

Use these files in this folder:

- DLL: [`acpimof.dll`](acpimof.dll)
- Script: [`Inject-WMI_put_me_in_extracted_GCC_installer.ps1`](Inject-WMI_put_me_in_extracted_GCC_installer.ps1)

What the script automates:

1. Verifies it is running as Administrator.
2. Checks that `acpimof.dll` exists in the same folder.
3. Copies `acpimof.dll` to `C:\Windows\SysWOW64`.
4. Creates/uses `HKLM:\SYSTEM\CurrentControlSet\Services\WmiAcpi`.
5. Writes `MofImagePath` to `C:\Windows\SysWOW64\acpimof.dll`.
6. Prompts for reboot so Windows can load the WMI provider.

### 4) Optional source alternative

If you prefer extracting from official GCC package instead of using local DLL (recommended for strict trust verification):

- [Gigabyte Control Center download](https://www.gigabyte.com/Support/Utility?kw=GIGABYTE+Control+Center&p=1)

