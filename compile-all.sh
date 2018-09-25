FILES=`ls atividades/*.tex`

for file in $FILES
do
 file="$(basename $file .tex)"
 echo "Compilando $file..."
 ./compile.sh $file
done

rm -rf dist/
mkdir dist/
mv atividades/*.pdf dist/
cp atividades/*.tex dist/

echo "Gerando HTML"
./generates-html.sh > dist/index.html
