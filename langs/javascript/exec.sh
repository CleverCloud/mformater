for FILE in `find . -name "*.js" ! -name "*.min.js" ! -name "*.noformat.js" -type f` 
do
	echo "js format $FILE"
	js-beautify -s 4 -j --brace-style=end-expand --outfile $FILE.new -f $FILE 
done

for FILE in `find . -name "*.js.new" -type f` 
do
	mv $FILE ${FILE%%.new}  
done