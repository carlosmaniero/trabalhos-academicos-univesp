FILE_PATH="./atividades"
ASSETS_PATH="./assets"
DIST_PATH="./dist"
FILES=`ls $FILE_PATH/*.tex`

for file in $FILES
do
 file="$(basename $file .tex)"
 echo "Compilando $file..."
 ./compile.sh $file
done

rm -rf dist
mkdir dist/
mv $FILE_PATH/*.pdf dist/
cp $FILE_PATH/*.tex $DIST_PATH
cp $ASSETS_PATH/* $DIST_PATH

echo "Gerando HTML"
./generates-html.sh > dist/index.html
