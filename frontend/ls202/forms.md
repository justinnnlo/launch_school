# Why they're important

Forms are where the front and backend meet because the user sends data to the server through a form. Note that they only send information to the server — they don't update the server itself or do anything else. The server needs backend software (e.g. Ruby code) to manipulate the data it receives.

# `form` tag

`form` is the parent for all other form-related tags. Its purpose is to tell the browser where and how to send data. Its key attributes are:
- `method`: the type of HTTP request/method used to send data to the server
  - `method="get"` or `method="post"`
    - Note: HTML limits us to GET and POST methods — we need to use JS or a backend app to use other HTTP methods
- `action`: provides the URL to which the browser sends the request
  - `formaction` attribute in individual action items like `button` and `input type="submit"` can override the form's `action` value

A `form` elements needs at least one `input`, `textarea` or `select` tag to receive input from a user — otherwise it's useless because it can't send data to the server.

# `fieldset` tag

`fieldset` is an optional tag to provide semantic data to the browser about which form content data is related. By default it uses a border which can be disabled with CSS.

```html
<form action="/login" method="post">
  <fieldset>
    <input type="text" name="username" />
    <input type="password" name="password" />
  </fieldset>
  <fieldset>
    <input type="submit" value="Save" />
    <input type="submit" value="Forgot Password" formaction="/forgot" />
  </fieldset>
</form>
```

Note that here `form` uses the `post` method and is linked to `/login` — but the `input` to recover a forgotten password uses `formaction="/forgot"` to use a different URL than the `form`s.

# `input` tag

This self-enclosing tag tag describes a mechanism (control or widget) that lets the user supply a request to the app on the server.

Input types:
- `type` attribute to have a value to know the type of mechanism (control, widget) used, e.g.
  - `text` gives the user space to input text — but it should be validated!
    - `input` attribute `maxlength` sets a maximum length for the text input
  - `password`: like `text` but with an obscured value
  - `email`: allows entry of an email address
    - Though browsers have implementations to prevent the input of incorrect email addresses you should also validate them
  - `tel`: allows entry of a phone number — which unlike `email`, isn't validated by browsers
  - `checkbox`: allows users to mark check/unchecked
    - `input` boolean attribute `checked` pre-checks the box
      - In CSS we can use the pseudoclass `:checked` to selected elements that are checked
    - There are 2 ways to associate related inputs (depeds on how it's set-up in your server)
      - `input` attribute `name` has the same value
        - The `input` would send to the server data in the form of `name=value` for each selected `input`, where `name` and `value` are different attributes
      - Each `input` attribute `name` has different values
  - `radio`: The user can choose zero or one item from a list of options
    - Attribute `value` defines the value sent to the database if that option is selected
    - `checked` attribute marks a default option
    - As in `checkbox`, the name values of `name` can be used to associate `radio` input (where he can select one of a set of options)
  - `submit` gives the user a button to submit the form to the server
  - `reset`: creates a button that resets the contents of the form to its default values
    - Clicking a `reset` button doesn't send a request to a server

Other `input` attributes:
- `value`: an attribute that varies according to the `input` `type`
  - Text-based types (e.g. `text`, `email`, `number`): assigns a default value (or an empty string, if it's omitted)
    - Typically use: when you have a value from the database or in a session provided by the user
  - `checkbox` and `radio`: set the value submitted by the input when it's sent to the database
  - Button types (e.g. `submit`, `reset`, `button`): `value` is the label that appears on the button
- `size` and `maxlength`: control the size of an `input` element — hence mostly for text-based input types
- `placeholder`: display text when the field is empty to describe the expected input — hence mostly for text-based input types
  - Note: don't use `placeholder` as a substitute for `label` elements! They have different purposes and avoiding `label` elements breaks screenreaders (if needed, add `label` but hide it with CSS)
- `disabled`: boolean attribute that disables `input` elements so that they're displayed but the user is unable to interact with them
  - `disabled` turns on the `:disabled` CSS pseudoclass while non-disabled elements set the `:enabled` pseudoclass
- `required`: boolean attribute that marks the input as required, so the browser won't submit a form unless required inputs are filled
  - Turns on the `:required` pseudoclass
- `autocomplete`: `autocomplete="off"` prevents the browser from storing and later reusing input data through the browser's `autocomplete` features
  - `autocomplete` doesn't affect the `password` input type
- `autocapitalize`: used in some *mobile browsers* to autocapitalize text input
  - `none`: no autocapitalization
  - `on` or `sentences`: The first letter of each sentence
  - `words`: the first character of each word
  - `characters`: every character defaults to uppercase
- `autocorrect`: automatic spelling corrections `on` or `off`
  - Best to use for names, usernames, addresses, etc
  - Like `autocapitalize`, its a non-standard HTML, W3C HTML validator will complaint
- `name`: the backend uses the name to identify the data submitted through that input

[See here for the full list of `input` `type` values.](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input)

# `label`

This tag associates text with an input field — it's the text that describes what the input is (e.g. "Username" besides a username input).

It associates a label with an input item through 2 attributes: the `label`s `for` attribute and the `input`s `id` attribute. Both need the same textual value to be associated.

Besides the semantic value of a label it:
- Jumpts to the desired field when clicked
- Can be used as containers (eliminating the need for `for` and `id` attributes), but it makes styling more difficult
```html
<label for="phone">Phone</label>
<input type="text" id="phone" name="phone_number" />

<label>
  Phone
  <input type="text" name="phone" />
</label>
```

# `textarea`

This is a substitute for `input`. This type of input allows the user to submit a multiline input. Unlike `input type="text"`, it doesn't ignore carriage returns, newlines, and other whitespace characters.

Unlike other controls, the value sent to the database is contained within the opening and closing tags.

- `rows` and `cols` control the element's height and width
- `resize` allows you to disable the default feature that allows `textarea` to be resized

# `select`

Creates a drop-down list of options of which the user can select 0 or more.

- `option` element defines a choice a user can make in a `select` element — i.e. a possible value a user can select>
  - The text within the `option` tags is the placeholder
  - The values sent to the database is in the attribute `value`
  - `disabled` boolean attribute disables an option so that it can't be selected (good for a first option that describes the list/action)
  - `multiple`: boolean attribute that allows the user to select multiple options
  - `selected`: pre-selected option