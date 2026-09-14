//%attributes = {}
#DECLARE($params : Object)

var $splashWindowTitle : Text
$splashWindowTitle:=""

If (Count parameters:C259=0)
	
	ARRAY LONGINT($windows; 0)
	WINDOW LIST($windows)
	
	var $i; $window : Integer
	For ($i; 1; Size of array:C274($windows))
		$window:=$windows{$i}
		If (Window process($window)=1) && (Get window title($window)=$splashWindowTitle)
			var $x; $y; $bottom; $right : Integer
			GET WINDOW RECT($x; $y; $bottom; $right; $window)
			CALL FORM($window; Formula(SET WINDOW RECT($x; $y; $bottom; $right; $window)))
			return 
		End if 
	End for 
	
	CALL WORKER(1; Current method name:C684; {})
	
Else 
	
	SET MENU BAR(1)
	
	var $options : Object
	$options:=New object:C1471
	$options.title:=Localized string("HDI_Title")
	$options.blog:="blog.4d.com"
	$options.info:=Localized string("HDI_Info")
	$options.minimumVersion:="1700"  // 1650 means 16R5   1601 means 16.1 (do not use !)
	$options.license:=Null:C1517  // NO LICENSE NEEDED
	
	var $window : Integer
	$window:=Open form window:C675("HDI"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	SET WINDOW TITLE($splashWindowTitle; $window)
	DIALOG:C40("HDI"; $options; *)
	
End if 
