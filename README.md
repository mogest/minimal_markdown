# MinimalMarkdown

A lightweight and minimal Ruby implementation of a Markdown renderer,
designed with security in mind.

Tiny codebase, no dependencies, and HTML is rendered from a tree so no
possibility of corrupted or user-supplied HTML sneaking into the output.

## Supported Markdown elements

* Unordered lists
* Bold
* Italic
* Paragraphs

## Usage

Add to your Gemfile:

```
gem 'minimal_markdown'
```

Add to your app:

```
MinimalMarkdown.render('Here is my *markdown*')
=> "<div>Here is my <i>markdown</i></div>"
```

Or use the Slack-style Markdown parser by passing an option:

```
MinimalMarkdown.render('Here is my *markdown*', style: :slack)
=> "<div>Here is my <b>markdown</b></div>"
```
