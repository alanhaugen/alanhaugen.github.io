#!/bin/sh

echo "<html lang=en>" > todo.html
echo '
<head>
    <!-- FONT
    –––––––––––––––––––––––––––––––––––––––––––––––––– -->
    <link href="//fonts.googleapis.com/css?family=Raleway:400,300,600" rel="stylesheet" type="text/css">

    <!-- CSS
    –––––––––––––––––––––––––––––––––––––––––––––––––– -->
    <link rel="stylesheet" href="css/normalize.css">
    <link rel="stylesheet" href="css/skeleton.css">

    <!-- Favicon
    –––––––––––––––––––––––––––––––––––––––––––––––––– -->
    <link rel="icon" type="image/png" href="https://avatars.githubusercontent.com/u/1408981?v=4">
		<meta charset="utf-8">
		<title>AlOrganizer</title>
		<!-- jsCalendar v1.4.4 Javascript and CSS -->
		<script src="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.min.js" integrity="sha384-0LaRLH/U5g8eCAwewLGQRyC/O+g0kXh8P+5pWpzijxwYczD3nKETIqUyhuA8B/UB" crossorigin="anonymous"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-jscalendar@1.4.4/source/jsCalendar.min.css" integrity="sha384-44GnAqZy9yUojzFPjdcUpP822DGm1ebORKY8pe6TkHuqJ038FANyfBYBpRvw8O9w" crossorigin="anonymous">
	</head>
' >> todo.html

echo '
	<body>
    <div class="container">
      <div class="row">
        <div class="seven columns" style="margin-top: 25%">
' >> todo.html

pandoc todo.markdown >> todo.html

echo '
        </div>
        <div class="five columns portrait" style="margin-top: 15%">
' >> todo.html

echo '
<div id="calendar" data-firstDayOfTheWeek="2"></div>
<!-- Create the calendar -->
<script type="text/javascript">
    // Get the element
    var element = document.getElementById("calendar");
    // Create the calendar
    var myCalendar = jsCalendar.new(element);
    myCalendar.previous();
</script>
' >> todo.html

# THIS MONTH !
echo ' 
            <!-- Calendar Element -->
            <div class="auto-jsCalendar" data-firstDayOfTheWeek="2"></div>
' >> todo.html

echo '
<div id="my-calendar" data-firstDayOfTheWeek="2"></div>
<!-- Create the calendar -->
<script type="text/javascript">
    // Get the element
    var element = document.getElementById("my-calendar");
    // Create the calendar
    var myCalendar = jsCalendar.new(element);
    myCalendar.next();
</script>
' >> todo.html

echo '
<div id="mycalendar" data-firstDayOfTheWeek="2"></div>
<!-- Create the calendar -->
<script type="text/javascript">
    // Get the element
    var element = document.getElementById("mycalendar");
    // Create the calendar
    var myCalendar = jsCalendar.new(element);
    myCalendar.next();
    myCalendar.next();
</script>
' >> todo.html

echo '
<div id="mcalendar" data-firstDayOfTheWeek="2"></div>
<!-- Create the calendar -->
<script type="text/javascript">
    // Get the element
    var element = document.getElementById("mcalendar");
    // Create the calendar
    var myCalendar = jsCalendar.new(element);
    myCalendar.next();
    myCalendar.next();
    myCalendar.next();
</script>

' >> todo.html
echo '
        </div>
     </div>
  </div>
' >> todo.html

echo "</body></html>" >> todo.html
#awk "" todo.html
