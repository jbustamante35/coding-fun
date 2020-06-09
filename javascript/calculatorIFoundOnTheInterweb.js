<!doctype html>
<html>
<head>
<title>HTML calc</title>
</head>

<body bgcolor= "white" text= "black">

<form name="calculator" align="center">
<table cellpadding="7" align="center">
<th>
<input type="button" value="1" onClick="document.calculator.ans.value+='1'">
</th>
<th>
<input type="button" value="2" onClick="document.calculator.ans.value+='2'">
</th> 
<th>
<input type="button" value="3" onClick="document.calculator.ans.value+='3'">
</th>
<th>
<input type="button" value="+" onClick="document.calculator.ans.value+='+'">
</th>
 
 </tr>
 
 <th>
<input type="button" value="4" onClick="document.calculator.ans.value+='4'">
</th>
<th>
<input type="button" value="5" onClick="document.calculator.ans.value+='5'">
</th>
<th>
<input type="button" value="6" onClick="document.calculator.ans.value+='6'">
</th>
<th>
<input type="button" value="-" onClick="document.calculator.ans.value+='-'">
</th>
 </tr>
 
 <tr>
 <th> 
<input type="button" value="7" onClick="document.calculator.ans.value+='7'">
</th>
<th>
<input type="button" value="8" onClick="document.calculator.ans.value+='8'">
</th>
<th>
<input type="button" value="9" onClick="document.calculator.ans.value+='9'">
</th>
<th> 
<input type="button" value="*" onClick="document.calculator.ans.value+='*'">
</th>
</tr>
 
 <tr>
 <th>
<input type="button" value="0" onClick="document.calculator.ans.value+='0'">
</th>
<th> 
<input type="reset" value="Reset">
</th>
<th> 
<input type="button" value="=" onClick="document.calculator.ans.value=eval(document.calculator.ans.value)">
</th>
<th> 
<input type="button" value="/" onClick="document.calculator.ans.value+='/'">
</th>

<br><input type="textfield" name="ans" value="">
</form>
 
</body>
</html>﻿