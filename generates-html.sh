function get_text_title {
    cat $1 | grep "\\\\titulo" | cut -d "{" -f2 | cut -d "}" -f1
}

function get_file_date {
    git log --date=format:'%Y-%m-%d %H:%M:%S' -1 --format="%ad" -- $1
}

function get_link {
    title=$2
    url=$1

    echo "<a href=\"$url\">$title</a>"
}

function get_github_url {
    echo "https://github.com/carlosmaniero/trabalhos-academicos-univesp/blob/master/$1"
}

function get_file_row {
    cat << _EOF_
        <tr>
            <td>$(get_file_date $1.tex)</td>
            <td>$(get_text_title $1.tex)</td>
            <td>$(get_link $1.tex "PDF")</td>
            <td>$(get_link $1.tex "LaTeX")</td>
            <td>$(get_link "$(get_github_url $1.tex)" "Github")</td>
        </tr>
_EOF_
}

function get_files_rows {
	for file in `ls *.tex`
	do
        file=`basename $file .tex`
        get_file_row $file
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
        td, th {
            padding: 15px;
            border-bottom: 1px solid black;
        }
        td:first-child, th:first-child {
            padding-left: 0px;
        }
        th {
            text-align: left;
            padding-right: 10px;
        }
    </style>
  </head>

  <body>
    <hgroup>
        <h1>Trabalhos acadêmicos</h1>
        <h2>Engenharia da Computação - UNIVESP</h2>
    </hgroup>
    <table>
      <thead>
        <tr>
          <th>Ultima atualização</th>
          <th>Título</th>
          <th></th>
          <th></th>
          <th></th>
        </tr>
      </thead>
      <tbody>
          $(get_files_rows)
      </tbody>
    </table>
  </body>
  </html>
_EOF_
