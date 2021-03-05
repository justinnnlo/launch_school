CSS selectors determine what elements it'll apply a set of CSS rules.

The key group of selectors are:
- Universal selector: selects all elements with `*`
- Type selector: based on the element type
- Class selector
- Id selector
- Attribute selector: select all elements with the attribute `[attr]` or with the attribute value `[attr="value"]`
  - Can be used in conjunction with a class, e.g. `li[attr]`

## Grouping

Selectors can be grouped with a `,`

## Combinators

- Descendent ` `: selects an element that descends from another
  - E.g. `A B` selects all elements `B` that descend from an element `A`
- Direct descendent `>`: selects an element that *directly* descends from another
  - E.g. `A>B` selects all elements `B` that directly descend from an element `A`
- Adjacent sibling `+`: selects the siblings that directly follow a first sibling
  - E.g. `A + B` selects all elements `B` that are siblings that immediately follow an element `A`
- General sibling `~`: select elements that share the same parents (i.e., are siblings of the other element)
  - E.g. `A ~ B` selects all `B` elements that are siblings of an element `A`