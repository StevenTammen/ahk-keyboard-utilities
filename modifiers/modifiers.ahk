; Aliases for the backend virtual keys
global ctrlLeader := "VK8C"
global altLeader := "VK8D"
global winLeader := "VK8E"

global ctrlLeaderDn := "VK8C Down"
global altLeaderDn := "VK8D Down"
global winLeaderDn := "VK8E Down"

global ctrlLeaderUp := "VK8C Up"
global altLeaderUp := "VK8D Up"
global winLeaderUp := "VK8E Up"


; Track key downs to deal with GetKeyState() being unreliable when handling dual-role keys' down states
; for times close to initial actuation
global shiftDownNoUp := false
global numDownNoUp := false
global ctrlDownNoUp := false
global altDownNoUp := false
global winDownNoUp := false


; Implements layer-independent hold behavior for modifiers.
; Assumes no separate number layer. This is the simplest case.
modifiers(label, key)
{
	
	; Always arrange modifiers in the order of Ctrl > Alt > Shift > Win
	; Will allow for a dynamic function call below
	
	mods := ""
	
	if(ctrlDownNoUp)
	{
		mods := mods . "Ctrl"
	}
	
	if(altDownNoUp)
	{
		mods := mods . "Alt"
	}
	
	if(shiftDownNoUp)
	{
		mods := mods . "Shift"
	}
	
	if(winDownNoUp)
	{
		mods := mods . "Win"
	}
	
	; This function should not do things if shift is the only modifier. Only when shift is combined
	; with other modifiers, or when other modifiers are used without shift.
	if(mods = "Shift")
	{
		return false
	}
	else if(mods = "")
	{
		return false
	}
	else
	{
		%mods%_%label%(key)
		return true
	}
}


; Implements layer-independent hold behavior for modifiers.
; Assumes a separate number layer.
modifiers_num(label, regKey, numKey)
{
	
	; Always arrange modifiers in the order of Ctrl > Alt > Shift > Win
	; Will allow for a dynamic function call below
	
	mods := ""
	
	if(ctrlDownNoUp)
	{
		mods := mods . "Ctrl"
	}
	
	if(altDownNoUp)
	{
		mods := mods . "Alt"
	}
	
	if(shiftDownNoUp)
	{
		mods := mods . "Shift"
	}
	
	if(winDownNoUp)
	{
		mods := mods . "Win"
	}
	
	; This function should not do things if shift is the only modifier. Only when shift is combined
	; with other modifiers, or when other modifiers are used without shift.
	if(mods = "Shift")
	{
		return false
	}
	else if(mods = "")
	{
		return false
	}
	else
	{
	
		if(GetKeyState(numLeader))
		{
			key := numKey
			SendInput {%numLeaderUp%}		
		}
		else if(numDownNoUp)
		{
			key := numKey	
		}
		else
		{
			key := regKey
		}
		
		%mods%_%label%(key)
		return true
	}
}


; Implements layer-independent single-use prefix and hold behavior for modifiers
; Assumes no separate number layer.
modifiers_prefix(label, key)
{
	
	; Always arrange modifiers in the order of Ctrl > Alt > Shift > Win
	; Will allow for a dynamic function call below
	
	mods := ""
	
	if(GetKeyState(ctrlLeader))
	{
		mods := mods . "Ctrl"
		SendInput {%ctrlLeaderUp%}
	}
	else if(ctrlDownNoUp)
	{
		mods := mods . "Ctrl"
	}
	
	if(GetKeyState(altLeader))
	{
		mods := mods . "Alt"
		SendInput {%altLeaderUp%}
	}
	else if(altDownNoUp)
	{
		mods := mods . "Alt"
	}
	
	sendLeaderUp := false
	if(GetKeyState(shiftLeader))
	{
		mods := mods . "Shift"
		sendLeaderUp := true
	}
	else if(shiftDownNoUp)
	{
		mods := mods . "Shift"
	}
	
	if(GetKeyState(winLeader))
	{
		mods := mods . "Win"
		SendInput {%winLeaderUp%}
	}
	else if(winDownNoUp)
	{
		mods := mods . "Win"
	}
	
	; This function should not do things if shift is the only modifier. Only when shift is combined
	; with other modifiers, or when other modifiers are used without shift.
	if(mods = "Shift")
	{
		return false
	}
	else if(mods = "")
	{
		return false
	}
	else
	{
		if(sendLeaderUp)
		{
			SendInput {%shiftLeaderUp%}
		}
		
		%mods%_%label%(key)
		return true
	}
}


; Implements layer-independent single-use prefix and hold behavior for modifiers.
; Assumes a separate number layer. This is the most complex case.
modifiers_num_prefix(label, regKey, numKey)
{
	
	; Always arrange modifiers in the order of Ctrl > Alt > Shift > Win
	; Will allow for a dynamic function call below
	
	mods := ""
	
	if(GetKeyState(ctrlLeader))
	{
		mods := mods . "Ctrl"
		SendInput {%ctrlLeaderUp%}
	}
	else if(ctrlDownNoUp)
	{
		mods := mods . "Ctrl"
	}
	
	if(GetKeyState(altLeader))
	{
		mods := mods . "Alt"
		SendInput {%altLeaderUp%}
	}
	else if(altDownNoUp)
	{
		mods := mods . "Alt"
	}
	
	sendLeaderUp := false
	if(GetKeyState(shiftLeader))
	{
		mods := mods . "Shift"
		sendLeaderUp := true
	}
	else if(shiftDownNoUp)
	{
		mods := mods . "Shift"
	}
	
	if(GetKeyState(winLeader))
	{
		mods := mods . "Win"
		SendInput {%winLeaderUp%}
	}
	else if(winDownNoUp)
	{
		mods := mods . "Win"
	}
	
	; This function should not do things if shift is the only modifier. Only when shift is combined
	; with other modifiers, or when other modifiers are used without shift.
	if(mods = "Shift")
	{
		return false
	}
	else if(mods = "")
	{
		return false
	}
	else
	{
	
		if(GetKeyState(numLeader))
		{
			key := numKey
			SendInput {%numLeaderUp%}		
		}
		else if(numDownNoUp)
		{
			key := numKey	
		}
		else
		{
			key := regKey
		}
		
		if(sendLeaderUp)
		{
			SendInput {%shiftLeaderUp%}
		}
		
		%mods%_%label%(key)
		return true
	}
}
