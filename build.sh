#!/bin/bash

set -e

mkdir -p ./output
touch ./output/.nojekyll

#
# For dev branch and local builds we want an index page available
#
if [[ "$GITHUB_REF_NAME" == dev || "$OSTYPE" =~ ^darwin ]]; then
  cat <<EOF >./output/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>USF Guides as PDF</title>
</head>
<body>
  <section id="main">
    <header>
      <h1>Guides as PDF</h1>
    </header>
    <article>
      <ul>
EOF
fi

mkdir -p ./tmp
for fname in ./content/*; do
  basename=$(basename -s .md $fname)
  # skip test.pdf in production
  if [[ $GITHUB_REF_NAME == main && "$basename" =~ ^test ]]; then continue; fi
  echo "Transforming ${basename}.md to HTML ..."
  pandoc -s $fname --template=./resources/template.html -o ./tmp/${basename}.html
  echo "Transforming ${basename}.html to PDF ..."
  pagedjs-cli ./tmp/${basename}.html -o ./output/${basename}.pdf
  if [[ "$GITHUB_REF_NAME" == dev || "$OSTYPE" =~ ^darwin ]]; then
    echo "        <li><a href='${basename}.pdf' target='_blank'>${basename}.pdf</a></li>" >>./output/index.html
  fi
done
rm -r ./tmp

if [[ "$GITHUB_REF_NAME" == dev || "$OSTYPE" =~ ^darwin ]]; then
  cat <<EOF >>./output/index.html
      </ul>
    </article>
  </section>
</body>
</html>
EOF
fi

# Open the index when building locally
if [[ $OSTYPE =~ ^darwin ]]; then
  open ./output/index.html
fi

echo "Done."
