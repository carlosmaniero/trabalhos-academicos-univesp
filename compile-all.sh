FILES=`ls *.tex`

for file in $FILES
do
 file=`basename $file .tex`
 echo "Compilando $file.tex ..."
 ./compile.sh $file
done

./generates-html.sh > index.html
