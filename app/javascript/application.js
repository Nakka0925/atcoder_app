// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


const theme = {
    difficultyBlackColor: "#404040",
    difficultyGreyColor: "#808080",
    difficultyBrownColor: "#804000",
    difficultyGreenColor: "#008000",
    difficultyCyanColor: "#00C0C0",
    difficultyBlueColor: "#0000FF",
    difficultyYellowColor: "#C0C000",
    difficultyOrangeColor: "#FF8000",
    difficultyRedColor: "#FF0000",
  };

document.addEventListener('turbo:load', (event) => {
  const algoDifficulty = Math.floor(document.getElementById('diff').value/400);
  const difficultyElement = document.querySelector('.your-difficulty-element');
  
  if (algoDifficulty == 0 ) {
    difficultyElement.style.color = "#808080"; // Green color
  } else if (algoDifficulty == 1) {
    difficultyElement.style.color = "#804000"; // Orange color
  } else if (algoDifficulty == 2) {
    difficultyElement.style.color = "#008000"; // Red color
  } else {
    difficultyElement.style.color = "#00C0C0"; // Default color
  };
});