//%attributes = {}
ALL RECORDS:C47([INFO:1])
$json:=Selection to JSON:C1234([INFO:1])
Folder:C1567(fk resources folder:K87:11).file("INFO-ja.json").setText($json)

ALL RECORDS:C47([Employee:3])
$json:=Selection to JSON:C1234([Employee:3])
Folder:C1567(fk resources folder:K87:11).file("Employee-ja.json").setText($json)
