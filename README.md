# MyWeather ☀️
---

<h4>📱IOS application designed to display weather forecasts</h4>

---

<h3>📁Folders structure</h3>

<ul>

  <li>Application</li>
  <ul>
    <li>Specific app related: Services (Session & Weather), App & Scene Delegate, Info.plist and main</li>
  </ul>
  
  <li>Controllers</li>
  <ul>
    <li>Here there is a subfolder for each view-controller: Home, Current, Map, Favorites, AddFavorites, Details</li>
  </ul>
  
  <li>Library</li>
  <ul>
    <li>Here there is what is outside the MVC pattern, a subfolder of UI Custom Elements: UIDetailsWeatherTableCell and UIWeatherTableCell</li>
  </ul>
  
  <li>Models</li>
  <ul>
    <li>The models necessary for the abstraction of the application are present here: MDCoordinate, MDWeather, MDForecast, MDWeatherCoordinate & MDWeaCoord+MapAnnotation</li>
  </ul>
  
  <li>Views</li>
  <ul>
    <li>Here there is the storyboard</li>
  </ul>
  
</ul>

---

<h3>🪞Application views</h3>

<ul>

  <li>Current</li>
  <ul>
    <li>The weather for the current location is displayed</li>
    <li>Click ℹ️ for more information about the forecast</li>
    <li>Click 🔄 to update weather and/or location</li>
  </ul>
  
  <li>Favorites</li>
  <ul>
    <li>The list of locations saved as favourites is displayed here</li>
    <li>Click on the location for more information about the forecast</li>
    <li>Click on the ❌ to remove the location from the list</li>
    <li>Click the ➕ to add a new favourite location</li>
  </ul>
  
  <li>Map</li>
  <ul>
    <li>Forecasts for the current location and the preferred location are displayed here</li>
    <li>Automatic focus on current position🔎</li>
    <li>Click on the pin 📍 to see the current weather and on the ℹ️ for more information about the forecast</li>
  </ul>
  
</ul>

---

<h3>🤳🏼Application usage</h3>

<div><p>When application start, the necessary permissions will be requested.Having access to the location will make it possible to view the weather for the current location.<br>
Information is stored via appropriately formatted and managed NSUserDefaults (See AddFavoritesViewController & FavoritesViewController).<br>
Reference Branch --> Main.</p></div>

---

<div>
  <img src="https://github.com/devicons/devicon/blob/master/icons/apple/apple-original.svg" title="Apple" alt="Apple" width="40" height="40"/>&nbsp;
  <img src="https://github.com/devicons/devicon/blob/master/icons/objectivec/objectivec-plain.svg" title="objc" alt="objc" width="40" height="40"/>&nbsp;
  <img src="https://github.com/devicons/devicon/blob/master/icons/git/git-original-wordmark.svg" title="Git" **alt="Git" width="40" height="40"/>
</div>
