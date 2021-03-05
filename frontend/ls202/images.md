# Image types

## JPG

- Great balance of quality and compression
- **Lossy** compression format: lose information (i.e. image quality) to reduce the file size
  - A JPEG artifact is inserted when lossy compression affects the image quality
  - When you save a jpg file you can set its lossiness levels
    - Higher lossiness is smaller but lower quality
    - Lower is larger but higher quality

## PNG

- Best for backgrounds and non-photographic images
- **Non-lossy** compression format: less image quality loss but larger files
- **Single-color and alpha transparency** lets images have a transparent background (???)
  - Single color transparency: reserves a single color to be entirely clear (i.e. to reveal the content underneath)
  - Alpha transparency: adds alpha channel to images — up to 65,536 different levels of transparency tinted by color

## GIF

- Limited color range of 256 colors
- By extension, this allows for tiny file sizes
- Great for: images where size or detail aren't important (e.g. an icon)

## Comparison table

|JPG|PNG|GIF|
|Compression|Lossy|Non-lossy|None/Lossy/Non-lossy|
|Photographs?|Yes|Yes, but too big|No|
|Line Drawings?|No|Yes|Depends on drawing|
|Gradients?|No|Yes|No|
|Typical File Size|Small|Medium-Large|Tiny|
|Quality|Poor to Good|Best|Good but limited color|
|Color Palette|16.7 million|256 Tera Colors|256|
|Color Depth|24 bits|8-48 bits|8 bits|
|1-Color Transparency|No|Yes|Yes|
|alpha Transparency|No|Yes|No|
|Resolution Maximum|65536 x 65536|2 GP x 2 GP|65536 x 65536|
|Total Pixels Max|4 GP|256 EP|4 GP|

Special units:
- 256 teracolors is 280 million million
- A GP (gigapixel): 1b pixels
- An EP (exapixel) is 3 fillowed by 23 zeroes

# Adding images

## `img` element

`img` element is a self-enclosing or self-contained tag. It tells the browser to load and display an image from a separate resource. Its 4 key attributes are:
- `src`: tells the browser where to find the image
- `alt`: alternative text for visually impaired people and computers; by default, browsers display the `alt` text when an image isn't displayed
- `width` and `height`: specifies the width and height of the element
  - If you know the exact size of the image: use the html `width` and `height` properties to optimize the browser's rendering speed (by allocating room for the image before it downloads it)
  - If you don't know the size of the image: using html `width` and `height` may lead to worse performance — stick to CSS properties exclusively

Note that when you modify only the CSS `width` or `height` properties the other will be automatically adjusted to maintain the same aspect ratio.

## `figure` and `figcaption`

If we want to add an image caption `figure` and `figcaption` do it with semantic meaning (contrary to using `p` or a similar element).

- `figure`: an element that encloses some media that illustrates surrounding content
- `figcontent`: a tag that caption a piece of media

Use `figure` when you reference the media in the text
Use `figcontent` when you caption media (needs to be in a `figure`)

Note that while `img` is an `inline-block` element `figure` is a block element.

## Images as links

To use an image as a link place it within an `a` tag.

## Background images

The CSS `background` or `background-image` property allows us to display an image as a background element. These appear behind the element's content and the element's descendent's content.

These properties can be applied to the whole page or specific elements.