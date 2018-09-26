FILE_PATH="./atividades"

function get_text_title {
    cat $FILE_PATH/$1 | grep "\\\\titulo" | cut -d "{" -f2 | cut -d "}" -f1
}

function get_file_date {
    git log --date=format:'%Y-%m-%d %H:%M:%S' -1 --format="%ad" -- ./$FILE_PATH/$1
}

function get_link {
    title=$2
    url=$1

    echo "<a href=\"$url\">$title</a>"
}

function get_github_url {
    echo "https://github.com/carlosmaniero/trabalhos-academicos-univesp/blob/master/$FILE_PATH/$1"
}

function latest_commit {
    git log -1 --pretty=format:"%h%x09%an%x09%ad%x09%s"
}

function get_file_row {
    cat << _EOF_
        <tr>
            <td>🗎 $(get_text_title $1.tex)</td>
            <td>🕒 $(get_file_date $1.tex)</td>
            <td class="action">$(get_link $1.pdf "PDF")</td>
            <td class="action">$(get_link $1.tex "LaTeX")</td>
            <td class="action">$(get_link "$(get_github_url $1.tex)" "Github")</td>
        </tr>
_EOF_
}

function get_files_rows {
    for file in `ls ./$FILE_PATH/*.tex`
    do
        file="$(basename $file .tex)"
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
            color: #af1e23;
        }
        img {
            max-width: 100%;
        }
        small {
            color: #818285;
            font-size: 0.75rem;
        }
        hr {
            height: 1px;
            background: black;
            border: 0;
        }
        td, th {
            padding: 15px;
            border-bottom: 1px solid black;
            white-space: nowrap;
        }
        td:first-child, th:first-child {
            padding-left: 0px;
        }
        th {
            text-align: left;
            padding-right: 10px;
        }
        tr .action {
            width: 82px;
            text-align: center;
        }
        .wrapper {
            width: 80%;
            margin: 0 auto;
        }
    </style>
  </head>

  <body>
    <div class="wrapper">
        <img src="logo-univesp.png" align="right" />
        <hgroup>
            <h1>Trabalhos acadêmicos</h1>
            <h2>Engenharia da Computação — Carlos Maniero</h2>
        </hgroup>
        <table width="100%">
          <thead>
            <tr>
              <th>Título</th>
              <th>Última atualização</th>
              <th class="action"></th>
              <th class="action"></th>
              <th class="action"></th>
            </tr>
          </thead>
          <tbody>
              $(get_files_rows)
          </tbody>
        </table>
        <p>
            <small><strong>Última atualização:</strong> $(latest_commit)</small>
        </p>
    <div>
  </body>
  </html>
_EOF_
