# Box model

All HTML elements have the shape of a box. Each box has different dimensions. The browser renders HTML elements one at a time. It renders them horizontally until an element cannot fit that line. In those cases, it starts a new line and inserts the element there.

## Box properties

Every element box has these properties:
- Width: horizontal space needed for the content area of the box
- Height: vertical space needed for the content area of the box
- Padding: vertical and horizontal space between the content of the box and its border
- Border: area/boundary between the padding and margin
- Margin: box space outside of the border


Moreover, the display value determines how the browser lays elements in relation to its neighbors

# Visual formatting model

The visual formatting model is the value of the `display` property. This det ermines how CSS displays the element in relation to its neighbors.

The 3 key types are:
- Block
- Inline
- Inline-block

## Block

A block element takes the width of its parent or container. Thus, a block element doesn't allow other elements to be in the same line.

Block elements typically group other elements within them. For example, the `body` groups other elements like `header`, `section`, and `footer` which themselves store other block or inline elements.

## Inline

Inline elements take the width of their contents and box properties. Thus, they idngore the width and height properties given to them. This is why unlike block elements they don't necessarily take the full space of its parent. This explains why inline displays are used within and aside content (e.g. `b`, `span`, `em` elements).

- Uses the width and height computed from the element content
  - i.e., it ignores width and height properties
- Ignores top and bottom margins, but not left and right margins
- Borders are displayed but surrounding elements ignore them
- Left and right padding works as expected but top or bottom padding is ignored by surrounding elements

Takeaway: stick to horizontal margins and paddings at most with inline elements.

## Inline-block

The `inline-block` visual display model is equivalent to the new `inline flow-root` visual display model.

They behave like block elements with one exception: when the specified width is less than the parent element's width it takes that smaller value.

# Vocabulary

- the box model
  - box properties
    - width and height
    - padding and margins
    - borders
- visual display models
  - block
  - inline
  - inline-block
- box sizing model
  - content-box
  - border-box
- dimensions: where does `auto` fit in?
  - absolute units: pixel
  - relative units: em, rem, %
- container
- physical pixels
- CSS reference pixels