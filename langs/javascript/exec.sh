for FILE in `find . -name "*.js" ! -name "*.min.js" ! -name "*.noformat.js" -type f` 
do
	echo "js format $FILE"
	js-beautify -j -f --brace-style=end-expand $FILE > $FILE.new
done

for FILE in `find . -name "*.js.new" -type f` 
do
	mv $FILE ${FILE%%.new}  
done