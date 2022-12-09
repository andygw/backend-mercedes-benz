# README

A small Ruby on Rails application providing an endpoint which takes a GPS latitude and longitude and spits out the names of museums around that location grouped by their postcode as JSON.

As an example when doing a request to /museums?lat=52.494857&lng=13.437641 would generate a response similar to:

```
{
  "10999": ["Werkbundarchiv – museum of things"],
  "12043": ["Museum im Böhmischen Dorf"],
  "10179": [
    "Märkisches Museum",
    "Museum Kindheit und Jugend",
    "Historischer Hafen Berlin"
  ],
  "12435": ["Archenhold Observatory"]
}
```

## Instructions
1. Create a [Mapbox](https://www.mapbox.com/) account.
2. Get an access token from Mapbox.
3. Create a file named .env in the root of this repo.
4. In the .env file, add `MAPBOX_API_KEY=your_access_token` (replace `your_access_token` with your actual token) and save.
5. In your terminal, enter `rails s`.
6. In your broswer, go to [`http://localhost:3000/museums?lat=45.51&lng=-73.56`](http://localhost:3000/museums?lat=45.51&lng=-73.56) (with whatever coordinates you want).

This challenge is taken from Le Wagon's career week challenges, [Junior Backend Developer @Mercedes-Benz](https://lewagon.notion.site/Junior-Backend-Developer-Mercedes-Benz-1c437fd7e3bc48888e35d2792d29b626)

TODO:
- Make the API more generic, so it accepts any type of point of interest, not just museums
- Return more than 10 results
- Show distance between each museum and the given coords as the crow flies
- Show distance between each museum and the given coords while driving/walking
