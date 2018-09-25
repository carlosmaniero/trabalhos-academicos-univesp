FILES=`ls *.pdf`

function get_text_title {
    cat $1 | grep "\\\\titulo" | cut -d "{" -f2 | cut -d "}" -f1
}

function links {
	for file in $FILES
	do
        file=`basename $file .pdf`
        echo "<tr><td>$(date -r $file.tex "+%Y-%m-%d %H:%M:%S")</td><td><a href=\"./$file.pdf\">$(get_text_title $file.tex)</a></td></tr>"
	done
}

cat << _EOF_
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="utf-8">
    <title>Trabalhos Acadêmicos - UNIVESP</title>
    <style>
        html {
            margin: 0;
            padding: 0;
            min-height: 100%;
            border-left: 30px solid black;
            padding-left: 30px;
            font-family: sans;
        }
        * {
            box-sizing: border-box;
        }
        a {
            color: #000;
        }
        hr {
            height: 1px;
            background: black;
            border: 0;
        }
        th {
            text-align: left;
            padding-right: 10px;
            padding-bottom: 5px;
        }
    </style>
  </head>

  <body>
    <hgroup>
        <h1>Trabalhos acadêmicos</h1>
        <h2>Engenharia da Computação - UNIVESP</h2>
    </hgroup>
    <hr />
    <table>
      <thead>
        <tr>
          <th>Ultima atualização</th>
          <th>Título</th>
        </tr>
      </thead>
      <tbody>
          $(links)
      </tbody>
    </table>
  </body>
  </html>
_EOF_
