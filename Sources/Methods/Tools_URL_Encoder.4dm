//%attributes = {"shared":true,"preemptive":"capable"}
  //   ******  the following routine may be useful if you need to encode your URL
  // example:  "www.test.com/my method"  contains a blank, so needs to be converted to "www.test.com/my%20method"
  // call it like $encodedurl:=Tools_URL_Encoder";$url;$Format)
  // $format could be UTF-8 or ISO-8859-1
  // characters > 127 will be encoded using this format. 

  //  encodes umlauts, blanks and other special chars in an URL

$result:=""
$WSPI_MyString:=$1
If (Count parameters:C259>1)
	$format:=$2
Else 
	$format:="ISO-8859-1"
End if 
C_BLOB:C604($blob)

  // If the charset is different than Latin-1 please add your translation below
  // Parse the string and translate the special characters
For ($WSPI_parser;1;Length:C16($WSPI_MyString))
	$WSPI_MyChar:=Substring:C12($WSPI_MyString;$WSPI_parser;1)
	$WSPI_ascii:=Character code:C91($WSPI_MyChar)
	If ((($WSPI_ascii>=Character code:C91("a'")) & ($WSPI_ascii<=Character code:C91("z'"))) | (($WSPI_ascii>=Character code:C91("A")) & ($WSPI_ascii<=Character code:C91("Z"))) | (($WSPI_ascii>=Character code:C91("0")) & ($WSPI_ascii<=Character code:C91("9"))) | ($WSPI_MyChar="*") | ($WSPI_MyChar="-") | ($WSPI_MyChar=".") | ($WSPI_MyChar="_") | ($WSPI_MyChar="/"))
		$result:=$result+$WSPI_MyChar
	Else 
		SET BLOB SIZE:C606($blob;0)
		CONVERT FROM TEXT:C1011($WSPI_MyChar;$format;$blob)
		For ($i;1;BLOB size:C605($blob))
			$result:=$result+Tools_URL_Encoder2 ($blob{$i-1})
		End for 
	End if 
End for 
$0:=$result