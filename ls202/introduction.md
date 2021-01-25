# HTML and CSS

HTML gives content structure and meaning by defining the content as certain elements that are rendered by the browser. It was created to describe the contents of a document in a browser.

CSS is a presentation language to style the appearance of content in an HTML file.

## Comments
HTML comments are made with `<!-- -->`.

CSS comments are made with `/* */`.

## HTML terms

- Elements: *designators* that define the structure and content of objects within a page
  - Elements use angle brackets `<>` to surround the element name
  - E.g.: `<h1>`, `<h6>`, `<a>`, `<div>`, `<strong>`, `<em>`, etc
- A tag is an individual pair of angle brackets surrounding an element
  - An elements can have an opening and closing tag, as in `<h1>...</h1>`
  - The text within angle brackets is the content of that tag
  - Elements that do not need a closing are called self-contained, self-enclosing, void or empty elements
- Attributes: properties used to provide additional information about an HTML element
  - `id`: attribute to unique identify an element that have the id selector
  - `class`: attribute to define a shared style across all of the elements htat share the class selector
- A nested element is an elements placed within another element

In `<a href="http://shayhowe.com/">Shay Howe</a>`
- Element: `a` (as it's the `a` element)
- Tags: `<a href="http://shayhowe.com/"></a>`
- Attributes: `href="http://shayhowe.com/"`

```html
<!DOCTYPE html>
<html lang="en">
  <head>
  </head>
  <body>
  </body>
</html>
```
In the above code, there are 2 nested HTML elements: `head` and `body`, which are both nested within the `html` element.

## CSS terms

- Selectors: designates which HTML element or elements to target and apply styles to
  - Selectors may use a combination of qualifiers to determine which elements to target
  - Selectors can be unique (e.g. id selector) or not (e.g. class selector)
  - Selectors are followed by curly brackets that enclose the styles to be applied to the selected elements
- Properties: the styles applied to the elements selected by the selector
  - E.g. `color`, `background-color`, `flexbox`
- Values: determines the behavior of the property
  - The text between the colon after the property name and before the semicolon
  - E.g. `color: red;` has a property of `color` and a value of `red`

### CSS Selector Types

There are 3 common types of selectors in CSS
- Type selectors: selectors based on an element name
  - E.g. `p { font-size: 16; }`
- Class selectors: selectors based on a class
  - E,g, `.my_class { color: red; }`
- Id selectors: selectors based on an id
  - E.g. `#my_id { background-color: white; }`

The specificity of these selectors are the same as their ascending order: type < class < id

[Advanced CSS selectors are here.](https://learn.shayhowe.com/advanced-html-css/complex-selectors/)

# Referencing CSS

There are 3 ways of referencing CSS within an HTML file
- External: referencing an external file
- Internal: adding CSS in the `head` element
- Inline: adding CSS as an attribute of an element

We'll cover the first one because internal and inline is discouraged: it makes code harder to maintain and understand

HTML and CSS are in separate files: one that ends in `.html` and another that ends in `.css`.

The best practice to reference CSS is to store the styles in a CSS file and refer to it in the HTML `head` element. The benefit of using a single CSS file is that we can reference it across the site and it's easier to maintain.

```html
<head>
  <link rel="stylesheet" href="main.css">
</head>
```
- `link` element: defines the relationship between the HTML and CSS files
- `rel` attribute: defines the type of document being linked
- `"stylesheet"` value: specifies the file as a CSS stylesheet
- `href` (hyperlink reference): identifies the path/location of the file
  - Note: if using a relative path it needs to start in the current directory

# CSS resets

Each browser has its own way of defining the default style of an element. For example, Chrome renders the default `p` element different than Internet Explorer. Thus, CSS resets reset the default values of CSS elements to improve cross-browser compatibility.

Popular resets are [Eric Mayer's reset](https://meyerweb.com/eric/tools/css/reset/) and the slightly more nuances and complex [Normalize.css](https://necolas.github.io/normalize.css/)

# HTML in depth

## HTML semantics
Semantics is the *practice* of giving content on a page meaning and structure by using the proper element. Semantic code allows your HTML code to be properly read by:
- Search engines
- Computers
- Screen readers for the disabled
- Other devices

For example, non-semantic code is:
```html
<font size="6">
   <strong>This is a page title</strong>
</font>
```

While semantic code is:
```html
<h1>This is a heading</h1>
```

Note that the difference is that the second block provides the device with the meaning that the text is an `h1` element, which has more specific meaning than the contents of `font` and `strong` elements.

Besides being more readable for computers and the visually impaired, other benefits of semantic code include:
- Usually shorter code — and thus faster loading speeds
- Easier code maintainance
- More readable for developers

## divs and spans

`div` and `span` elements are elements without semantics: they exist only for styling purposes. Thus, they are generic containers that lack a specific value. In contrast, an element like `p` is semantic because it's understood that it's contents are a paragraph of text.

`div` and `span` elements allows us to apply targeted styles to a container of a set of content.
- `div`s are block-level elements that are typically used to encase a large group of elements to build the layout of a page
- `span`s are inline-level elements that are typically used to group smaller amounts of content within a block-level element

### Inline vs block elements

An element is inline when it begins in the continuation of the normal flow of a document and it's width is that of the content. An element is block when its content begins in a new line and has the width of its container

Note that block elements can wrap inline elements but inline elements cannot wrap block elements (with the exception of `a` in HTML5).

## Text-based elements

- Headings: `h1` to `h6` elements
  - They're block-level elements used to break up content and create hierarchies within the text
  - Headings should be used when they're semantically valuable — not to just make text big or bold!
- Paragraphs: `p` block-level element
- Bold text with strong: `strong`
  - An inline elements that places a *strong importance* on something
  - `b` bolds text but has the semantic value of stylistically offsetting text — so thus doesn't bring the text as prominent attention as `strong` at a semantical level
- Italize text with emphasis: `em`
  - As with `b` and `strong`, `i` semantically conveys ab alternate tone or voice while `em` semantically conveys emphasis

|Element|Description|
|-|-|
|strong|The text has greater importance than the surrounding text; most browsers use boldface. Example: You **must** remember to turn the light off.|
|em|Adds emphasis to the text; most browsers use italics. Example: We do them because they are *hard*!|
|b|Stylistically offset text, such as keywords. Example: ES6 adds the keywords **const** and **let**.|
|i|Alternate voice text. Example: I said "Hello." She said "*Goodbye*."|

[See this cheatsheet for help in establishing the semantics](http://html5doctor.com/downloads/h5d-sectioning-flowchart.pdf)

## Structure and semantics

HTML structure was long done with semantically generic `div`s. HTML5 introduced structural elements with semantic meaning like:
- `header`: identifies the top of a page, and tenfs to include a heading, intro text and navigation
- `nav`: identifies a section of major *nav*igational links on a page
  - Note: should be reserved for a section of primary navigation and noteworthy groups of nav links — one-off links should just use `a` without `nav`
- `section`: identifies a thematic grouping of content — it says said content is related
- `article`: identifies content that can be independently redistributed (e.g. a newspaper article)
- `aside`: content that is tengentially related to surrounding content — e.g. a sidebar, inserts or brief explanations
  - Note: `aside` elements shouldn't be used if they're in the main document flow
- `footer`: closing or end of page,article, section, or other page segment

Like `div`s, these are block-level elements and can be used multiple times in an HTML document.

## Hyperlinks

Hyperlinks allows us to link one page or resource with another. Hyperlinks are created with the `a` inline anchor element. It uses the hypertext reference (href) attribute to identify the location of the destination being liked.

## Relative vs absolute paths

A relative path points to a resource in the same page. It starts in the folder of the current element and does not include the domain (e.g. .com, .org, .edu) in the `href` attribute value.

An absolute path points to a resource in a different page. Unlike a relative path, it needs to include the domain.

## Other links

- Linking to an email address: en email link uses the `href` attribute and needs to start with `mailto:`
  - Subject, body text, and other info can be populated with link parameters
  - E.g. `<a href="mailto:14jdelap@gmail.com?subject=Learning%20How%20To%20Code&Body=Testing>`
- Opening links in a new window: `target` attribute with a value of `_blank`
  - `target` determines where the link will be displayed
  - `_blank` specifies that it'll be a new window
- Links in the same page
  1. Set an `id` attribute to the element we want to link to
  2. Use the `id` attribute within the anchor element's `href`

# Encoding special characters

Special characters can be misunderstood or mistaken for another character by HTML when typed directly. Thus, they need to be encoded.

Encoded characters begin with an ampersand `&` and end with a semicolon `;`. The character's unique encoding is between said `&` and the `;`.

[Here's a list of character encodings.](http://copypastecharacter.com/)

# CSS

Cascading Style Sheets (CSS) adds layout and design to pages, and allows us to share them between elements and pages.

## Cascading

All styles cascade from the top to the bottom of the style sheet. The bottom-most values of an attribute take precedence.

## Cascading selector types

```css
p {
  background: orange;
  font-size: 24px;
}
p {
  background: green;
}
```
In this example, the value `green` of `background` takes precedence over `orange` because it's specified after it. However, as the bottom-most `p` didn't specify a new font size it uses `24px` (as the first `p` type selector).

## Cascading properties

The principle of cascading also works within a selector.

```css
p {
  background: orange;
  background: green;
}
```

Here, `green` is applied because it's after `orange` within the same selector.

## Cascating specificity

Every CSS selector has a specificity weight. A style is rendered by a combination of the selector's specificity weight and the selector's position within the cascade.

A selector's specificity weight is expressed as a 3 digit point value in the form of `X-X-X`.
- Type selector: 0-0-1
- Class selector: 0-1-0
- ID selector: 1-0-0
Note that the point values don't use a base of 10: 0-0-1 isn't 1 and 1-0-0 isnt' 100. Rather, they have to be considered in the context of the 3 digits.

## Combining selectors

The key selector is the element the styles will be applied to.
```css
.my-class {
  color: red;
}

.my-class p.my-second-class {
  color: blue;
}
```
In `.my-class p.my-second-class` the key selector is `.my-second-class`. `.my-class` and `p` are *prequalifiers*. Note that `.my-class p.my-second-class` has a specificity weight of `0-2-1` (2 classes and one type).

Note that an element can refer to multiple classes.
```html
<a class="btn btn-danger">...<a>
  <a class="btn btn-success">...<a>
```

More complex combinations include the `>` character, which says "all descendents within an element".

```css
main ul > li
```
The above code says: within the `main` elements select all `li` elements that are within, at any point, of a `ul` element that is a direct descendent from `main`.

# Absolute vs relative lenghts

An absolute length has a strict physical measurement. For example, a centimiter is 1/100 of a meter.

A relative length has a value that's relative on another length — like the device it's viewed on.

## Absolute: pixels
The most common absolute value used in computers is the pixel. A pixel is 1/96th of an inch. However, a pixel's measurement varies between high and low density devices.

## Relative: percentages and em
Percentages (`%` notation) are defined in relation to another length. For example, if we set a width to 50% we are setting it to 50% of the length of the parent element.

Em (`em` notation) is a length calculated on the element's font size.

```css
.banner {
  font-size: 14px;
  width: 5em;
}
```
Here `5em` is `70px` because it's essentially `5 * 14px`, as the banner class' font size is 14px. If an element doesn't have an explicit font size it'll use the font size of the closest element.




# Basics

- HTML skeleton or HTML scaffold: the required `DOCTYPE`, `html`, `head` (with its `title` and `meta` tags) and `body` tags
- Elements that do not needs a closing tag can be called "self-enclosing element", "self-contained element", "empty element" or "void element"
  - `<!DOCTYPE html>`: Document Type Definition — a message that tells the browser the specific markup language to expect
    - This isn't HTML
    - The `!` in `!DOCTYPE` specifies that it's HTML5
    - It needs to be the first item in the HTML document — even before whitespace
    - In HTML5 `DOCTYPE` is case insensitive, but in older HTML versions it needs to be uppercase
  - `html` element encloses the entire HTML document
  - `head` element encloses the document header, which stores the page's metadata meant for the browser
  - `body` element encloses the content of the page, which is what's rendered by the browser
- Note that even though the 4 elements are required a browser will typically render a page correctly even if it's missing it. However, don't rely on this!
- Indent everything except: self-enclosing tags and (optional) the 4 required elements (`DOCTYPE`, `html`, `head`, `body`)

- HTML identifies certain elements through 3 attributes: classes, ids, and names
  - Any element can use the `class` or `id` attribute, and some can use the `name` attribute; an element could use all 3 simultaneously
  - Class: identifies a set of page elements you want to style consistently
    - Elements can belong to one or more classes
    - Any number and type of element can belong to a class
    - CSS class selectors `.class_selector` selects elements by class
  - id: a unique identification of an element
    - Only one element can have an id
    - CSS ID selectos `#id_selector` selects elements by id
    - Note that id selectors have higher specificity than CSS selectors
  - Name: ties form elements to data in the server