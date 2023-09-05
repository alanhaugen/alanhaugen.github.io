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

            function makeCalc(month)
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

			//cal.select('now');
			cal.select('01/09/2023');
			cal.colorfulSelect('01/09/2023', 'jsCalendar-colorful-green');
			cal.colorfulSelect('18/09/2023', 'jsCalendar-colorful-blue');
			cal.colorfulSelect('22/09/2023', 'jsCalendar-colorful-orange');
			cal.colorfulSelect('29/09/2023', 'jsCalendar-colorful-green');
			cal.colorfulSelect('20/10/2023', 'jsCalendar-colorful-orange');
			cal.colorfulSelect('23/10/2023', 'jsCalendar-colorful-blue');
			cal.colorfulSelect('27/10/2023', 'jsCalendar-colorful-green');
			cal.colorfulSelect('03/11/2023', 'jsCalendar-colorful-orange');
			cal.colorfulSelect('17/11/2023', 'jsCalendar-colorful-blue');
			cal.colorfulSelect('01/12/2023', 'jsCalendar-colorful-orange');
			cal.colorfulSelect('06/12/2023', 'jsCalendar-colorful-green');
			cal.colorfulSelect('11/12/2023', 'jsCalendar-colorful-blue');
            }

            makeCalc(8);  // August
            makeCalc(9);  // September
            makeCalc(10); // October
            makeCalc(11); // November
            makeCalc(12); // December

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
