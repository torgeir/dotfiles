FOLDER=$HOME/.sweetjs-macros
for file in $FOLDER/tests/*.js
do
  cat $file | $FOLDER/load-macros.js
done
