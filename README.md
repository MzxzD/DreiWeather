# DreiWeather

## About

A simple weather app ispired by Apples weather.
This project was made as a task for Drei.

## Instalation

Just download the code, open Xcode and navigate to:

```
Utils/Constants.swift
```
and replace `apiKey` with your own.

Hit run and off you go!


## Usage

On initial launch, you'll be promted to give access to Location:

<img src="assets/Screenshot 2025-02-10 at 13.23.12.png" width="310" height="600">

When you allow, it will automatically pull the current weather for your location

<img src="assets/Screenshot 2025-02-10 at 13.28.45.png" width="310" height="600">

Clicking on plus `+` icon on the top right, opens up the search for new location.

<img src="assets/Screenshot 2025-02-10 at 13.30.12.png" width="310" height="600">

After entering and confirming your city, you'll immediately receive the current weather forecat for the city.

<img src="assets/Screenshot 2025-02-10 at 13.31.29.png" width="310" height="600">

Clicking on Save saves the weather and the city and dismisses the search.

<img src="assets/Screenshot 2025-02-10 at 13.32.35.png" width="310" height="600">

If you have multiple locations saved, you can rearange them by clicking `Edit` and rearrange them as you wish

<img src="assets/Screenshot 2025-02-10 at 13.35.12.png" width="310" height="600">

If you click on one of them, it will expand and show you more details about the current weather

<img src="assets/Screenshot 2025-02-10 at 13.37.18.png" width="310" height="600">

If you want to refresh with new data, just pull to refresh

<img src="assets/Screenshot 2025-02-10 at 13.38.25.png" width="310" height="600">

If you want to delete, select one of the cards and press the delete button 🗑️ on the top right side
(You can't delete the card with your current location)

<img src="assets/Screenshot 2025-02-10 at 13.41.29.png" width="310" height="600">


## Todo

- [ ] Add nice animation transition from `CityCard` to `WeatherCard`
- [ ] Lint
- [ ] Tests
    - [ ] Figure out why does CoreData crash in test env


## Summary

Really happy how the app turned out. Unfortunately I've wasted too much time debuging the test environment (Because of CoreData) that for right now I gave up on writing tests. It is in mt todo and I'll try and resolve them in time.
 