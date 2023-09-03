#!/bash/sh

echo "<html>" > todo.html
echo '<link rel="stylesheet" href="air.css">' >> todo.html
pandoc todo.markdown >> todo.html
echo "</html>" >> todo.html
#awk "" todo.html
