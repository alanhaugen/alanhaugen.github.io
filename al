#!/bin/sh

echo "<!DOCTYPE html lang=en>" > todo.html
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

<style>
			.jsCalendar tbody td.jsCalendar-colorful-blue {border-color: #52C9FF;}
			.jsCalendar tbody td.jsCalendar-colorful-yellow {border-color: #FFE31B;}
			.jsCalendar tbody td.jsCalendar-colorful-orange {border-color: #FFB400;}
			.jsCalendar tbody td.jsCalendar-colorful-red {border-color: #F6511D;}
			.jsCalendar tbody td.jsCalendar-colorful-green {border-color: #7FB800;}

.week {
color: #1EAEDB;
}

		</style>

	</head>
' >> todo.html

echo '
	<body>
    <div class="container">
      <div class="row">
        <div class="seven columns" style="margin-top: 15%">
' >> todo.html

pandoc todo.markdown >> todo.html

echo '
        </div>
        <div class="five columns portrait" style="margin-top: 15%">
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
                if (month == 9)
                {
                cal.colorfulSelect('01/09/2023', 'jsCalendar-colorful-green');
                cal.colorfulSelect('18/09/2023', 'jsCalendar-colorful-blue');
                cal.colorfulSelect('22/09/2023', 'jsCalendar-colorful-orange');
                cal.colorfulSelect('29/09/2023', 'jsCalendar-colorful-green');
                }
                if (month == 10)
                {
                cal.colorfulSelect('20/10/2023', 'jsCalendar-colorful-orange');
                cal.colorfulSelect('23/10/2023', 'jsCalendar-colorful-blue');
                cal.colorfulSelect('27/10/2023', 'jsCalendar-colorful-green');
                }
                if (month == 11)
                {
                cal.colorfulSelect('03/11/2023', 'jsCalendar-colorful-orange');
                cal.colorfulSelect('17/11/2023', 'jsCalendar-colorful-blue');
                }
                if (month == 12)
                {
                cal.colorfulSelect('01/12/2023', 'jsCalendar-colorful-orange');
                cal.colorfulSelect('06/12/2023', 'jsCalendar-colorful-green');
                cal.colorfulSelect('11/12/2023', 'jsCalendar-colorful-blue');
                }
            }

            makeCal(8);  // August
            makeCal(9);  // September
            makeCal(10); // October
            makeCal(11); // November
            makeCal(12); // December


function addWeekColumn(calendar)
{
    const firstElement = document.querySelector(\"#calendar \> table:nth-child\(\" + calendar + \"\) \> thead \> tr.jsCalendar-week-days \> th:nth-child\(1\)\")
    const para = document.createElement(\"td\");
    para.className = \"week\";
    const node = document.createTextNode(\"Week\");
    para.appendChild(node);
    const e = document.querySelector(\"#calendar \> table:nth-child\(\" + calendar + \"\) \> thead \> tr.jsCalendar-week-days\")
    e.insertBefore(para, firstElement);
}

function addWeekNumber(calendar, row, week)
{
    const firstElement = document.querySelector(\"\#calendar \> table:nth-child\(\" + calendar + \"\) \> tbody \> tr:nth-child\(\" + row + \"\) \> td:nth-child\(1\)\")
    const para = document.createElement(\"td\");
    para.className = \"week\";
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

addWeekNumber(1, 1, 31);
addWeekNumber(1, 2, 32);
addWeekNumber(1, 3, 33);
addWeekNumber(1, 4, 34);
addWeekNumber(1, 5, 35);
addWeekNumber(1, 6, 36);

addWeekNumber(2, 1, 35);
addWeekNumber(2, 2, 36);
addWeekNumber(2, 3, 37);
addWeekNumber(2, 4, 38);
addWeekNumber(2, 5, 39);
addWeekNumber(2, 6, 40);

addWeekNumber(3, 1, 39);
addWeekNumber(3, 2, 40);
addWeekNumber(3, 3, 41);
addWeekNumber(3, 4, 42);
addWeekNumber(3, 5, 43);
addWeekNumber(3, 6, 44);

addWeekNumber(4, 1, 44);
addWeekNumber(4, 2, 45);
addWeekNumber(4, 3, 46);
addWeekNumber(4, 4, 47);
addWeekNumber(4, 5, 48);
addWeekNumber(4, 6, 49);

addWeekNumber(5, 1, 48);
addWeekNumber(5, 2, 49);
addWeekNumber(5, 3, 50);
addWeekNumber(5, 4, 51);
addWeekNumber(5, 5, 52);
addWeekNumber(5, 6, 53);

" >> todo.html

echo '
</script>
' >> todo.html

echo '
        </div>
     </div>
  </div>
' >> todo.html

echo "</body></html>" >> todo.html
#awk "" todo.html
