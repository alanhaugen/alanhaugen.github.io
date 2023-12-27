#!/bin/sh

echo "<!DOCTYPE html lang=en>" > todo.html
echo '
<head>

    <script src="//unpkg.com/graphre/dist/graphre.js"></script>
    <script src="//unpkg.com/nomnoml/dist/nomnoml.js"></script>

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

<style>
			.jsCalendar tbody td.jsCalendar-colorful-blue {border-color: #52C9FF;}
			.jsCalendar tbody td.jsCalendar-colorful-yellow {border-color: #FFE31B;}
			.jsCalendar tbody td.jsCalendar-colorful-orange {border-color: #FFB400;}
			.jsCalendar tbody td.jsCalendar-colorful-red {border-color: #F6511D;}
			.jsCalendar tbody td.jsCalendar-colorful-green {border-color: #7FB800;}

                        .weeknumber
                        {
                            text-align: center;
                            width: 36px; height: 36px;
                        }
		</style>

	</head>
' >> todo.html

echo '
	<body>
    <div class="container">
      <div class="row">
        <div class="six columns" style="margin-top: 15%">
' >> todo.html

pandoc todo.markdown >> todo.html

echo '
        </div>
        <div class="six columns portrait" style="margin-top: 15%">
' >> todo.html

echo '
<div id="calendar"></div>
<!-- Create the calendar -->
<script type="text/javascript">
    // Get the element
    var element = document.getElementById("calendar");
' >> todo.html


echo "
// Colorful Select
			jsCalendar.prototype.colorfulSelect = function(dates, color){
				// If no arguments
				if (typeof dates === 'undefined') {
					// Return
					return this;
				}

				// If dates not array
				if (!(dates instanceof Array)) {
					// Lets make it an array
					dates = [dates];
				}

				// Save colors
				this._colorful_saveDates(dates, color);
				// Select dates
				this._selectDates(dates);

				if (!this._colorful_patched) {
					this._colorful_patched = this.refresh;
					this.refresh = function(date) {
						// Call original refresh
						this._colorful_patched(date);
						// Refresh select Colors
						this._colorful_update();
						// Return
						return this;
					};
				}
				// Refresh
				this.refresh();

				// Return
				return this;
			};

			// Save dates colors
			jsCalendar.prototype._colorful_saveDates = function(dates, color) {
				// Copy array instance
				dates = dates.slice();

				// Parse dates
				for (var i = 0; i < dates.length; i++) {
					dates[i] = jsCalendar.tools.parseDate(dates[i]);
					dates[i].setHours(0, 0, 0, 0);
					dates[i] = dates[i].getTime();
				}

				if (typeof this._colorful_colors == 'undefined') {
					this._colorful_colors = {};
				}

				// Save each date color
				for (i = dates.length - 1; i >= 0; i--) {
					this._colorful_colors[dates[i]] = color;
				}
			};

			// Refresh colors
			jsCalendar.prototype._colorful_update = function() {
				// Get month info
				var month = this._getVisibleMonth(this._date);

				// Check days
				var timestamp;
				for (var i = month.days.length - 1; i >= 0; i--) {
					// If date is selected
					timestamp = month.days[i].getTime();
					if (this._selected.indexOf(timestamp) >= 0 && this._colorful_colors.hasOwnProperty(timestamp)) {
						this._elements.bodyCols[i].className = 'jsCalendar-selected' + ' ' + this._colorful_colors[timestamp];
					}
				}
			};

            function makeCal(month)
            {
                var element = document.getElementById('calendar');
                month = month - 1;

                var d = new Date();
                var diff = month - d.getMonth();

                var cal = jsCalendar.new({
                    target : element,
                    navigator : false,
                    firstDayOfTheWeek : "2"
                });
                cal.set('now');

                if (diff < 0)
                {
                    while (diff != 0)
                    {
                        cal.previous();
                        diff = diff + 1;
                    }
                }
                else if (diff > 0)
                {
                    while (diff != 0)
                    {
                        cal.next();
                        diff = diff - 1;
                    }
                }

                month = month + 1;

                //cal.select('now');
                //cal.select('01/09/2023');
                if (month == 1)
                {
                cal.colorfulSelect('01/09/2023', 'jsCalendar-colorful-green');
                cal.colorfulSelect('18/09/2023', 'jsCalendar-colorful-blue');
                cal.colorfulSelect('22/09/2023', 'jsCalendar-colorful-orange');
                cal.colorfulSelect('29/09/2023', 'jsCalendar-colorful-green');
                }
                if (month == 2)
                {
                cal.colorfulSelect('20/10/2023', 'jsCalendar-colorful-orange');
                cal.colorfulSelect('23/10/2023', 'jsCalendar-colorful-blue');
                cal.colorfulSelect('27/10/2023', 'jsCalendar-colorful-green');
                }
                if (month == 3)
                {
                cal.colorfulSelect('03/11/2023', 'jsCalendar-colorful-orange');
                cal.colorfulSelect('17/11/2023', 'jsCalendar-colorful-blue');
                }
                if (month == 4)
                {
                cal.colorfulSelect('7/5/2024', 'jsCalendar-colorful-red');
                cal.colorfulSelect('13/5/2024', 'jsCalendar-colorful-orange');
                //cal.colorfulSelect('13/5/2024', 'jsCalendar-colorful-green');
                cal.colorfulSelect('21/5/2024', 'jsCalendar-colorful-blue');
                }
            }

            makeCal(1); // January
            makeCal(2); // February
            makeCal(3); // March
            makeCal(4); // April
            makeCal(5); // May


function addWeekColumn(calendar)
{
    const firstElement = document.querySelector(\"#calendar \> table:nth-child\(\" + calendar + \"\) \> thead \> tr.jsCalendar-week-days \> th:nth-child\(1\)\")
    const para = document.createElement(\"th\");
    //para.className = \"jsCalendar-previous\";
    const node = document.createTextNode(\"Week\");
    para.appendChild(node);
    const e = document.querySelector(\"#calendar \> table:nth-child\(\" + calendar + \"\) \> thead \> tr.jsCalendar-week-days\")
    e.insertBefore(para, firstElement);
}

function addWeekNumber(calendar, row, week)
{
    const firstElement = document.querySelector(\"\#calendar \> table:nth-child\(\" + calendar + \"\) \> tbody \> tr:nth-child\(\" + row + \"\) \> td:nth-child\(1\)\")
    const para = document.createElement(\"th\");
    para.className = \"weeknumber\";
    node = document.createTextNode(week);
    para.appendChild(node);
    const e = document.querySelector(\"#calendar \> table:nth-child\(\" + calendar + \"\) \> tbody \> tr:nth-child\(\" + row + \"\)\")
    e.insertBefore(para, firstElement);
}

addWeekColumn(1);
addWeekColumn(2);
addWeekColumn(3);
addWeekColumn(4);
addWeekColumn(5);

addWeekNumber(1, 1, 52);
addWeekNumber(1, 2, 1);
addWeekNumber(1, 3, 2);
addWeekNumber(1, 4, 3);
addWeekNumber(1, 5, 4);
addWeekNumber(1, 6, 5);

addWeekNumber(2, 1, 5);
addWeekNumber(2, 2, 6);
addWeekNumber(2, 3, 7);
addWeekNumber(2, 4, 8);
addWeekNumber(2, 5, 9); // Kjøkken, entre, stue
addWeekNumber(2, 6, 10); // Søppel

addWeekNumber(3, 1, 9);
addWeekNumber(3, 2, 10);
addWeekNumber(3, 3, 11); // Bad
addWeekNumber(3, 4, 12); // Kjøkken stue entre
addWeekNumber(3, 5, 13); // Søppel
addWeekNumber(3, 6, 14); // Bad

addWeekNumber(4, 1, 13);
addWeekNumber(4, 2, 14); // Kjøkken stue entre
addWeekNumber(4, 3, 15); // Søppel
addWeekNumber(4, 4, 16); // Bad
addWeekNumber(4, 5, 17); // Kjøkken stue entre
addWeekNumber(4, 6, 18); // Søppel

addWeekNumber(5, 1, 18);
addWeekNumber(5, 2, 19);
addWeekNumber(5, 3, 20); // Bad
addWeekNumber(5, 4, 21); // Kjøkken stue entre
addWeekNumber(5, 5, 22); // Søppel
addWeekNumber(5, 6, 23); // Bad

" >> todo.html

echo '
</script>
' >> todo.html

echo '
<canvas id="target-canvas"></canvas>
<script>
  var canvas = document.getElementById("target-canvas")
  var source = "[nomnoml] is -> [awesome]"
  nomnoml.draw(canvas, source)
</script>
' >> todo.html

echo '
        </div>
     </div>
  </div>
' >> todo.html

echo "</body></html>" >> todo.html
#awk "" todo.html
