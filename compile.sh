echo "limpando arquivos..."
./latex-clean.sh
echo "Criando estrutura básica..."
pdflatex ${1} > /dev/null
echo "Gerando bibliografia..."
bibtex ${1} > /dev/null
pdflatex ${1} > /dev/null
echo "Gerando PDF"
pdflatex ${1}
echo "Limpando arquivos"
./latex-clean.sh
