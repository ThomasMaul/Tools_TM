//%attributes = {"shared":true,"preemptive":"capable"}
  // newcolor := Tools_RGBColorLight(color;ratio)
  //  $color := Tools_RGBColorLight(0x4D7EC3;0.25)

C_LONGINT:C283($oldcolor;$r;$g;$b;$1;$0;$2)
C_LONGINT:C283($newcolor;$r2;$g2;$b2)
$oldcolor:=$1
$r:=$oldcolor\65536
$g:=$oldcolor-($r*65536)\256
$b:=$oldcolor%256


$r2:=$r+($2*(255-$r))
$g2:=$g+($2*(255-$g))
$b2:=$b+($2*(255-$b))
$0:=($r2*65536)+($g2*256)+$b2
