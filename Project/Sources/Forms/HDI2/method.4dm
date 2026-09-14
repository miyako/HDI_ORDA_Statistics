var $n; $i : Integer
var $json; $_json : Collection


Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY TEXT:C222(_TabTitles; 0)
		ARRAY TEXT:C222(_Descriptions; 0)
		ARRAY TEXT:C222(_Directions; 0)
		
		If (Get database localization:C1009(Current localization:K5:22)="ja")
			$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("INFO-ja.json").getText(); Is collection:K8:32)
		Else 
			$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("INFO-en.json").getText(); Is collection:K8:32)
		End if 
		
		$_json:=$json.query("PageNumber < :1"; 9).orderBy("PageNumber asc")
		COLLECTION TO ARRAY:C1562($_json; _TabTitles; "TabTitle"; _Descriptions; "Description")
		
		$_json:=$json.query("PageNumber >= :1"; 10).orderBy("PageNumber asc")
		COLLECTION TO ARRAY:C1562($_json; _Directions; "Description")
		
		If (Is Windows:C1573)
			ST SET ATTRIBUTES:C1093(_Descriptions{1}; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 14)
		End if 
		
		If (Is macOS:C1572)
			ST SET ATTRIBUTES:C1093(_Descriptions{1}; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 18)
		End if 
		
		If (ds:C1482.Employee.getCount()=0)
			If (Get database localization:C1009(Current localization:K5:22)="ja")
				$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("Employee-ja.json").getText(); Is collection:K8:32)
			Else 
				$json:=JSON Parse:C1218(Folder:C1567(fk resources folder:K87:11).file("Employee-en.json").getText(); Is collection:K8:32)
			End if 
			ds:C1482.Employee.fromCollection($json)
		End if 
		
		//List box employees
		Form:C1466.employees:=ds:C1482.Employee.all()
		
		btnTrace:=False:C215
		
	: (Form event code:C388=On Page Change:K2:54)
		
		If (Is Windows:C1573)
			$n:=Size of array:C274(_Descriptions)
			For ($i; 1; $n)
				ST SET ATTRIBUTES:C1093(_Descriptions{$i}; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 14)
			End for 
			
			$n:=Size of array:C274(_Directions)
			For ($i; 1; $n)
				ST SET ATTRIBUTES:C1093(_Directions{$i}; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 11; Attribute italic style:K65:2; 1)
			End for 
		End if 
		
		If (Is macOS:C1572)
			$n:=Size of array:C274(_Descriptions)
			For ($i; 1; $n)
				ST SET ATTRIBUTES:C1093(_Descriptions{$i}; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 18)
			End for 
			
			$n:=Size of array:C274(_Directions)
			For ($i; 1; $n)
				ST SET ATTRIBUTES:C1093(_Directions{$i}; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 14; Attribute italic style:K65:2; 1)
			End for 
		End if 
		
		//Page 1
		//Select the 3 first employees in the list box
		Form:C1466.selectedEmployees:=Form:C1466.employees.slice(0; 3)
		
		LISTBOX SELECT ROW:C912(*; "ListBoxEmployees"; 1)
		LISTBOX SELECT ROW:C912(*; "ListBoxEmployees"; 2; lk add to selection:K53:2)
		LISTBOX SELECT ROW:C912(*; "ListBoxEmployees"; 3; lk add to selection:K53:2)
		
		//Page 2
		Form:C1466.employeesAndHobbies:=ds:C1482.Employee.all().orderBy("salary")
		Form:C1466.practicedHobbies:=New collection:C1472
		
		
		btnTrace:=False:C215
		
End case 
