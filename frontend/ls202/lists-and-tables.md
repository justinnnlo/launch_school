# List types

## Unordered lists

An unordered lists lists items in no particular order using generic visual symbols like bullet points. Note that the list content itself may be ordered in some way, e.g. alphabetically.

## Ordered lists

An ordered list lists items in a consistent sequence using visual symbols like alphabetical letters or numbers.

An ordered list can be reversed with `<ol reversed>`, where `reversed` is a boolean attribute. Note that before HTML5 it would have had to been coded as: `<ol reversed="reversed">`. There are other boolean attributes that can be used within HTML elements.

## Description

Description lists (called definition lists before HTML5) contain a list of terms and definitions. Each item in the list has one or more terms and one or more definitions. E.g., definition lists include: telephone books, dictionaries, etc.

- `dl` creates the descriotion list
- `dt` creates a description term
- `dd`: creates a description definition

```html
<dl>
  <dt>Unordered</dt>
  <dd>A simple list with bullets.</dd>
  <dd>A plain list with no bullets or sequence numbers.</dd>

  <dt>Ordered</dt>
  <dd>A simple list with sequence numbers or letters.</dd>

  <dt>Description</dt>
  <dt>Definition</dt>
  <dd>A list with terms and definitions.</dd>
</dl>
```

![](https://d3jtzah944tvom.cloudfront.net/202/images/lesson_4/lists-overview-03.png)

# Nested lists

You can nest any list within another list regardless of its type.

# Navigation menus

Nav menus are typically constructed with unordered lists stored within a `nav` element.

# Pseudo-classes

A CSS pseudo-class is a keyword added to a selector to specify the state of the selector. E.g. `button:hover { color: blue }`, where `:hover` is the pseudo class.

[A list of pseudo-classes is here.](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-classes)

# Tables and tags

Tables should be strictly used to create a table to hold tabular data or similar type of values.

The most common tags are:
- `<table>`: defines a table
  - Note: eliminate borders with `border-collapse: collapse;`
- `<tr>` (table row): defines a single row in a table (columns are created as rows)
- `<td>` (table data): defines a single cell of content in a table
- `<th>` (table heading): defines a single table heading, rendering these values differently than a data cell
  - When we're using headings for both rows and columns we should specify the heading's scope for added semantic meaning
    - Column: `<th scope="col">`
    - Row: `<th scope="row">`
- `<thead>` (table head), `<tbody>` (table body), `<tfoot>` (table footer): defines a set of one or more rows that comprise the header, body or footer rows of a table
  - The are used as the parents of `tr` and provide semantic meaning to the table

```html
<table>
  <tr>                      <!-- row 1 -->
    <th>Color Name</th>       <!-- column header 1 -->
    <th>Color Hex</th>        <!-- column header 2 -->
    <th>Color Decimal</th>    <!-- column header 3 -->
  </tr>

  <tr>                      <!-- row 2 -->
    <th>red</th>              <!-- row header (column 1) -->
    <td>#f00</td>             <!-- data cell 1 (column 2) -->
    <td>255, 0, 0</td>        <!-- data cell 2 (column 3) -->
  </tr>

  <tr>                      <!-- row 3 -->
    <th>green</th>            <!-- row header (column 1) -->
    <td>#0f0</td>             <!-- data cell 1 (column 2) -->
    <td>0, 255, 0</td>        <!-- data cell 2 (column 3) -->
  </tr>

  <tr>                      <!-- row 4 -->
    <th>blue</th>             <!-- row header (column 1) -->
    <td>#00f</td>             <!-- data cell 1 (column 2) -->
    <td>0, 0, 255</td>        <!-- data cell 2 (column 3) -->
  </tr>
</table>
```

# Selecting based on attribute values

In CSS we can select any tag based on its attribute values. For example:
- Table row `<tr scope="red">`: we can make its background red via `[scope="red"] { background-color: red; }`
- Table row `<tr test="blue">`: we can make its background blue via `[scope="blue"] { background-color: blue; }`
