#SingleInstance

A_IconTip     := "RDP Guest Keys"
A_MenuMaskKey := ""

ExplorerExe := Format('"{1}\explorer.exe"', A_WinDir)

!F24::Run(ExplorerExe)
!F23::Run(ExplorerExe ' Shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}') ; Run...
!F22::Run(ExplorerExe ' Shell:::{3080F90D-D7AD-11D9-BD98-0000947B0257}') ; Show Desktop
