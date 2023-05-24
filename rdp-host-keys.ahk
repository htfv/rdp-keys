#SingleInstance

A_IconTip     := "RDP Host Keys"
A_MenuMaskKey := ""

VK_D := GetKeyVK("d")
VK_E := GetKeyVK("e")
VK_R := GetKeyVK("r")

RdpWindowActive() {
	return WinActive("ahk_class TscShellContainerClass")
}

#HotIf RdpWindowActive()

AltTabActive := 0

!Tab::{
	global AltTabActive := 1
	SendInput("{LAlt Down}{PgUp}")
}

!+Tab::{
	global AltTabActive := 1
	SendInput("{LAlt Down}{PgDn}")
}

#HotIf RdpWindowActive() and AltTabActive

!Left::{
	SendInput("{LAlt Down}{PgDn}")
}

!Right::{
	SendInput("{LAlt Down}{PgUp}")
}

#HotIf

~Alt Up::{
	global AltTabActive := 0
}

#HotIf RdpWindowActive()

WinComboActivated := 0
WinComboKeys      := Map()

LWin::
RWin::{
	global WinComboActivated
	global WinComboKeys

	ih := InputHook("L0")

	ih.NotifyNonText := true
	ih.OnKeyDown     := OnRdpWinKeyDown
	ih.OnKeyUp       := OnRdpWinKeyUp

	ih.KeyOpt("{All}", "N")
	ih.Start()

	KeyWait(A_ThisHotKey)
	ih.Stop()

	if (not WinComboActivated) {
		SendInput "!{Home}"
	}

	WinComboActivated := 0
	WinComboKeys.Clear()
}

OnRdpWinKeyDown(ih, vk, sc) {
	global WinComboActivated := 1
	global WinComboKeys

	count := WinComboKeys.Count
	state := WinComboKeys.Get(vk, 0)

	WinComboKeys.Set(vk, state + 1)

	if (count = 0 and state = 0) {
		switch (vk) {
		case VK_D:
			SendInput("!{F22}")
		case VK_E:
			SendInput("!{F24}")
		case VK_R:
			SendInput("!{F23}")
		}
	}
}

OnRdpWinKeyUp(ih, vk, sc) {
	global WinComboKeys

	if (WinComboKeys.Has(vk)) {
		WinComboKeys.Delete(vk)
	}
}
