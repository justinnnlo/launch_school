# Floats

A floated element tells the browser to move as far right or left as possible but to leave the remaining space available for more content. Then they can't fit they wrap around to the next available spot.

When an element floats it's removed from the normal document flow — so the container no longer contains the floated item. This creates a problem for containers: if the browser doesn't know what content is within the container it can't render it properly.

We can fix this issue by either:
1. Adding `overflow: hidden` or `overflow: auto` to the container
  - `overflow: hidden` can cut off content that exceeds the container if the container has a set width or height
  - `overflow: auto` can add unwanted scrollbars (browser-specific issue)
2. Wrapping the container in a **clearfix**

Both of these solutions ensure the parent container properly surrounds its contents.

## Understanding `overflow`

`overflow` creates a **block formatting context** that contains everything inside the element — including floats.

## Understanding clearfix

Clearfix is a standard pattern added to the element (rather than the container) to ensure a container doesn't lose its floated children.

```css
#columns::after { /* This rule is the clearfix */
  clear: both;
  content: "";
  display: block;
}
```
- `::after` **pseudo-element** creates a child block element at the end of the selected elements
- `content: "";` sets the pseudo-element's content to an empty string — making it invisible
- `clear: both;´ "clears" the floats inside the container — forcing the invisible pseudo-element below the floated content and thus stretching the container

Note: pseudo-elements like `::after` and `::before` use double colons `::` unlike pseudo-classes like `:hover` which use single colons `:`

# Positioning

## Offset Properties

Offset has 4 properties: `top`, `right`, `left` and `bottom`. **Offset is always inward when working with positive offset values**; negative offset shifts elements in the opposite direction. E.g. a positive `top` `relative` offset creates a positive distance between the element and its default position, pushing it downwards.

You can combine offset with negative margins (e.g. `margin-top: -100px`).


## `position` Property

`position` tells the browser how to position the selected elements.

- `position: static` (default):
  - Part of the document flow
  - Offset properties don't affect static elements
  - Elements appear in the same order as in the markup
- `position: relative`: move element to a new position relative to where the browser would put it
  - Use at most one vertical (`top` or `bottom`) and at most one horizontal (`left` or `right`) offset
  - Doesn't remove an element from the document flowt
- `position: absolute`: moves an element to a new position within a container element (i.e., the nearest ancestor with a relative, absolute or sticky `position`)
  - `top: 0` brings the element to the top, `right: 0` brings it to the right, etc
- `position: fixed`: sets an element to a fixed position in the window and thus stays fixed if the user scrolls

## Positioning as layers

The `z-index` property controls the layering of elements — i.e., which goes above or below. The element with the greater stack order is in front of the one with a lower stack order value.

# Flex and Grid

Both `flex` and `grid` are both values of `display` property.

- `flex` i.e. flexbox, is a one-dimensional layout tool
- `grid` is a 2-dimensional layout tool to manage both rows and columns

# Understanding CSS frameworks

CSS frameworks like Twitter Bootstrap and Foundation create a grid system using classes (using `grid` or other methods of setting layouts). The HTML uses those classes to layout the page. Despite `grid` and `flex`, frameworks are still useful because they work in browsers that don't support these 2 more recent CSS properties.

# Responsive design

Responsive design requires CSS that changes with different output devices. This is done via CSS media queries. Media queries define styles based on the size of the **current** browser window. Media queries are set based on **breakpoints**.

Besides common properties like `max-width`, we can choose media types like `screen`, `print` and `speech` to set media queries.

```css
@media screen and (max-width: 1600px) {
  /* CSS for 1600px (or smaller) screens (no printers!) */
}
```

[Read more on media queries here.](https://developer.mozilla.org/en-US/docs/Web/CSS/Media_Queries/Using_media_queries)

Note that mobile-first development (i.e., when the default screen size is for mobile and media queries handle progressively larger screens) results in faster download times for mobile phones — which is why it's best practice.

## Code for multiple devices

We need to add this code in the `head` to that mobile devices load the correct CSS — otherwise they show a miniaturized homepage.

```html
<meta name="viewport" content="width=device-width, initial-scale=1" />
```