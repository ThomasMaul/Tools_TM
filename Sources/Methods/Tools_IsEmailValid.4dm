//%attributes = {"shared":true,"preemptive":"capable"}
  // `check if email address in $1 is valid EMail Adresse in $1
  //  uses RegEx if Unicode is on, else do it manual, not as good.


$ergebnis:=False:C215


C_TEXT:C284($1;$emailAddress;$user_email_username;$user_email_domain)
C_BOOLEAN:C305($0)
C_TEXT:C284($pattern)

$emailAddress:=$1
$ergebnis:=False:C215
$pattern:="^([-a-zA-Z0-9_]+(?:\\.[-a-zA-Z0-9_]+)*)(?:@)([-a-zA-Z0-9\\._]+(?:\\.[a-zA-Z0-9]{2,4})+)$"  // Olivier
  //  $Pattern:="^([^@\\s]+)@((?:[-a-z0-9]{1,63}+\\.)+[a-z]{2,4})$"  ` Maurice
ARRAY LONGINT:C221($_position;0)
ARRAY LONGINT:C221($_length;0)
If (Match regex:C1019($pattern;$emailAddress;1;$_position;$_length))
	If ($_length{0}=Length:C16($emailAddress))
		$email_username:=Substring:C12($emailAddress;$_position{1};$_length{1})
		$email_domain:=Substring:C12($emailAddress;$_position{2};$_length{2})
		$ergebnis:=True:C214
	End if 
End if 

$0:=$ergebnis