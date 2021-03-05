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

Inline elements take the width of their contents and box properties. Thus, they ignore the width and height properties given to them. This is why unlike block elements they don't necessarily take the full space of its parent. This explains why inline displays are used within and aside content (e.g. `b`, `span`, `em` elements).

- Uses the width and height computed from the element content
  - i.e., it ignores width and height properties
- Ignores top and bottom margins, but not left and right margins
- Borders are displayed but surrounding elements ignore them
- Padding fully works as expected

Takeaway: stick to horizontal margins and paddings at most with inline elements.

## Inline-block

Relative to inline elements
- Allows a set width and height
- Respects top and bottom margins and paddings

Relative to block elements:
- Does not add a line-break after the element (it sits inline with others)

## Nesting elements

You can nest inline elements in a block or inline-block element, but not vice versa. The exception is with `a` elements, which can wrap around any type of elements.

# Box sizing

`box-sizing` is a property to build CSS layouts. It sets how the width and height are computed. Its 2 key values are `content-box` (default) and `border-box`.
- `content-box`: width and height is strictly based on the content
- `border-box`: width and height includes the border and padding

`box-sizing` can be reset in CSS with
```css
html {
  box-sizing: border-box;
}

*, *::before, *::after {
  box-sizing: inherit;
}
```

# Margin vs padding

Margins occupy a space outside of the element's borders
- They are by extension also outside of the element's clickable space
- They do not display the element's background (it's transparent)
- Between 2 block elements the margins "collapse": instead of the top element's bottom margin + bottom element's top margin it's the largest margin of the 2
  - Doesn't happen with left and right margins
  - Paddings don't collapse

Paddings occupy a space inside of the element's borders. Therefore,
- They are part of the clickable space
- They display the background of the element

Note that an element's clickable space extends up to and including its borders.

Thus, as rules of thumb:
- Use margins for spacing between elements and paddings to make an element more clickable or visible
- Use paddings to avoid margin collapse between 2 block elements (unless you specifically want that)
- Use padding to change the height or width at which the border is at
- Use padding to modify the background space of the element

# Dimensions

There are many **measurement units** (or units for short) in CSS: `px`, `%`, `em`, `rem`, etc. **An instance** of a measurement unit (e.g. `12px`) is called a **measurement** or **dimension**.

Absolute measurements or dimensions are based on a standerdized system: a meter is a meter, a pixel is 96th of an inch.

Relative measurements or dimensions are based on a relative value: a hand varies by person and a building's floor varies by each building.

## Physical vs Reference pixels

A physical (or device or display) pixel is a pixel on a screen. This can vary: it's typically 96 pixels per inch but high resolution displays might have 192 pixels per inch.

A CSS reference pixel is the size of a pixel on a display based on the **angular** diameter as viewed from a typical viewing distance (TVD) for the display. Thus, a reference pixel on a 27-inch display TV (≈ 33 in) will be larger than on a phone (≈ 14 in) because a TV's TVD is higher — compensating for the differences in size.

Therefore, it's preferrable to use CSS pixels to account for these differences in devices and typical viewing distance (TVD).

## `em` and `rem`

Ems and rems are proportional to the calculated and root font sizes. The calculated font size is the height of the current font size (i.e., the element you're in). The root font size is the font size in the `html` element (i.e., at the root of the document).

It's best to specify the root font in pixels and to use rems to make font sizes consistent (1.5rems means the same thing across the page while 1.5em does not)

### Fallback unit

Some old browsers may not recognize rems. If so, you need to use a fallback unit that specifies the size of the root font before specifying the rem size.

```css
p {
  font-size: 20px; font-size: 1.25rem;
}
```
In the above code, if the browser doesn't recognize `1.25rem` it'll fall back on `20px` (note the rem is further down the cascade). We use `20px` because the typical browser default font size is `16px`, so `20px` is 1.25x the size.

## Percentages

Percentages are units relative to the element's container. E.g. a block or inline-block's `width: 50%;` is equivalent to 50% of its containers width.

## Auto

A value of `auto` tells the browser to determine the value. What is does is contextual:
- `width` or `height`: fit the element in its container (block elements only!)
  - Note: `auto` != 100% — 100% may cause the element to overflow the container in some circumstances
- `margin`
  - Left or right values on a block element: push the element all the way to the opposite direction (e.g. push all the way to the right if `margin: X X X auto` and viceversa)
    - Note: `margin: X auto;` centers the element
  - Top or bottom: `auto` is equivalent to `0`
- Padding doesn't accept `auto` values


## Zero lengths

When the length is 0 you can omit the type of unit.

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