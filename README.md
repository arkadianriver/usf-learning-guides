# USF Learning Guides

> This repo is a demonstration of a workflow where content can be authored
> in a simple format, such as markdown, to create a resulting PDF.
> It makes use of Pandoc templates to produce HTML styled with special CSS
> that PagedJS uses to generate the output documents.

<p style="border:2px solid red;background-color:#dfdfad;padding:6px">USF
Learning Guides are used as an example. This repository is not associated
with that organization in any way.</p>

## Contents:

-  [Synopsis](#synopsis)
   -  [Building online](#building-online)
   -  [Building locally](#building-locally)
-  [Installing the software locally](#installing-the-software-locally)
-  [Editing the markdown source](#editing-the-markdown-source)

## Synopsis

### Building online

1.  In Github, create and edit a markdown file in the
    `content` directory.

1.  Click **Save**, which creates the file in a branch in your
    forked repository.

1.  Create a Pull Request ()PR, pulling your forked branch into the
    `dev` branch of the `arkadianriver/usf-learning-guides` repository.

1.  Your colleagues can review the markdown source, comment, and
    discuss before an authorized person merges your PR into the
    `dev` branch.

1.  After a minute or two, view the PDFs
    [on Github pages](https://arkadianriver.github.io/usf-learning-guides/).

1.  When ready to publish the reviewed PDFs to the CMS, an authorized person
    merges the `dev` branch into the `main` branch.
    After a minute or two, view the PDFs _in your CMS_.
    (@TODO: Publish to Sharepoint, for example with
    [this workflow action](https://github.com/marketplace/actions/publish-to-sharepoint).)


### Building locally

1.  Edit a markdown file in the `content` directory:

    ```markdown
    ---
    title: How to Lorem ipsum
    subtitle: A study of Amet ex irure
    date: 09/11/2022
    ---

    Lorem ipsum ...

    ::: {.sidebar-right}
    This is a sidebar comment. yada, yada, yada.
    :::

    Lorem ipsum ...
    ```

1.  Build the markdown files into PDFs:

    ```bash
    ./build.sh
    ```

1.  View your PDF files in the output folder.


## Installing the software locally

**Mac:**

1.  Homebrew (to easily install Pandoc):

    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

1.  Pandoc (to create the HTML file, using the template):

    ```bash
    brew install pandoc
    ```

1.  Node version manager (to easily switch Node versions):

    ```bash
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    ```

    After that, restart the Terminal.

1.  Node JS (prerequisite to PagedJS; version 16 is a good stable one):

    ```bash
    nvm install 16
    ```

1.  Paged JS (to render the HTML as a PDF):

    ```bash
    npm install -g pagedjs-cli pagedjs
    ```

## Editing the markdown source

The source files are written in Pandoc markdown, which is
[standard markdown](https://daringfireball.net/projects/markdown/syntax)
with [Pandoc extensions](https://pandoc.org/MANUAL.html#pandocs-markdown).

**Heading information:**

The metadata block at the top of the source file
(encapsulated within three-dash delimiters `---`)
must contain the following properties:
`title`, `subtitle`, and `date`.
The default guide is an Instructor Guide;
if auhoring a Student Guide, set the optional
`student-guide` property to any value, such as `true`.

```yaml
---
title: Your amazing title
subtitle: its subtitle
date: MM/DD/YYYY
student-guide: true
---
```

**Special blocks:**

This is content contained within a block indicated with starting
and ending `:::` markers, with particular classes indicated after
the beginning marker. For example, the following block indicates
a TIP block (using the `tip` style)

```markdown
::: {.tip}
This is a tip.
:::
```

Other styles are `sidebar-right`, `sidebar-left`, and `step`.
The `step` style also requires a `first-step` style on the first
step to reset the step counter.
Steps can also include a prefix icon. The available icons are:

|style|icon|
|---|---|
|think|<img src="resources/thinking-svgrepo-com.svg" width="20" height="20"/>|

See the `content/test.md` file for example source,
and the `output/test.pdf` file for its output.
(Note that when publishing, the `test.pdf` is not published.)

