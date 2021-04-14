# Problem description

Each image is associated with the following handlebar data:
- Description
- Name of pthe photo, data taken, likes and favorites
- Collection of comments

Routes:
- '/photos': array of photos with data — id is used to get comment data
- '/comments?photo_id=X': JSON object with the photo's object — using the id from '/photos' (use each loop in Handlebars)
- '/comments/new': creates comments object

When a new comment is created:
- Send data back to the server: POST to '/comments/new'
- Return a new comment object that should be renderered
- Changing images should replace the data on the page

1. On *DOMContentLoaded*, render the information in the JSON object returned by '/photos' in the HTML file
- XHR request gets the JSON object
- For each object, insert
  - 'src' value into the corresponding figure's img element's (first child) 'src' attribute
- For the first photo: insert the following within section > header
  - 'caption' value as the text in the figure's figcaption
  - 'title': in the 'h2' element
  - 'created_at': at the end of the "Taken on TIME" string in p > time
  - 'likes': div.actions > a.button.like: "NUMBER Likes"
  - 'favorites': div.actions > a.button.favorite: "NUMBER Favorites"