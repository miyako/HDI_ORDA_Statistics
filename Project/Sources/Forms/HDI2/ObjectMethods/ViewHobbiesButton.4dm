If (btnTrace)
	TRACE:C157
End if 

//Fill the collection Form.practicedHobbies
Form:C1466.practicedHobbies:=Form:C1466.employeesAndHobbies.distinct("extra.hobby")