


<cfscript>
string function DegreesKtoC(required numeric temperature) output="false" hint="return fully formatted temperature"	{
	
	return LSNumberFormat(arguments.temperature - 273.15, '99.9') & '&deg;C';
	}
	
</cfscript>	



<cfparam name="url.action" default="">
<cfparam name="form.zip" default="10000">


<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>OpenWeather</title>



		
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	
	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" integrity="sha256-7s5uDGW3AHqw6xtJmNNtr+OBRJUlgkNJEo78P4b0yRw= sha512-nNo+yCHEyn0smMxSswnf/OnX6/KwJuZTlNZBjauKhTK0c+zT+q5JOCx0UFhXQ6rJR9jg6Es8gPuD2uZcYDLqSw==" crossorigin="anonymous">
	
	<link rel="start"  	href="index.cfm" />
	<link rel="made" 	href="mailto:james@webworldinc.com" />
</head>	


<body>



<div class="jumbotron">
	<h1>JSON powered weather</h1>
	<p>Using CFHTTP to pull in JSON</p>
</div>

<div class="container">


<form action="index.cfm?action=process" method="post"  class="form-inline">

	<div class="form-group">
		<cfoutput>
			<input type="text" name="zip" value="#form.zip#" />
		</cfoutput>
	</div>

	<button type="submit" class="btn btn-primary btn-large">Get Weather</button>
</form>  


<cfif url.action EQ "process">

	
	<cfhttp url="http://api.openweathermap.org/data/2.5/weather?zip=#form.zip#,us&appid=#application.openweatherkey#">

	<cfset JSONdata = DeserializeJSON(cfhttp.Filecontent)>
		

	<cfoutput>
	<h1>Weather for #encodeForHTML(JSONData.name)#</h1>
	
	<blockquote>
		<p>Temperature: #DegreesKtoC(JSONData.main.temp)# (Hi: #DegreesKtoC(JSONData.main.temp_max)# / Lo: #DegreesKtoC(JSONData.main.temp_min)#)<p>
		<p>Wind: 	#encodeForHTML(JSONData.wind.speed)# km/h. Clouds: #encodeForHTML(JSONData.clouds.all)#%</p>
			
		<footer>Powered by <a href="http://openweathermap.org/current" target="_blank">OpenWeatherMap</a></footer>	
	</blockquote>	 

	</cfoutput>	

	<cfdump var="#JSONData#" expand="no">
</cfif>


</div>

</body>
</html>

