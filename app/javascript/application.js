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
  // 各要素をクラス名で取得
  const difficultyElements = document.querySelectorAll('.difficulty');

  // 各要素に対してループ
  difficultyElements.forEach(element => {
    // 各要素の難易度を取得し、計算
    const algoDifficulty = Math.floor(element.value / 400);
    const difficultyElement = element.nextElementSibling.querySelector('.your-difficulty-element');
    
    // 難易度に応じた色を適用
    if (algoDifficulty == 0) {
      difficultyElement.style.color = theme.difficultyGreyColor;
    } else if (algoDifficulty == 1) {
      difficultyElement.style.color = theme.difficultyBrownColor;
    } else if (algoDifficulty == 2) {
      difficultyElement.style.color = theme.difficultyGreenColor;
    } else if (algoDifficulty == 3) {
        difficultyElement.style.color = theme.difficultyCyanColor;
    } else if (algoDifficulty == 4) {
      difficultyElement.style.color = theme.difficultyBlueColor;
    } else if (algoDifficulty == 5) {
      difficultyElement.style.color = theme.difficultyYellowColor;
    } else if (algoDifficulty == 6) {
      difficultyElement.style.color = theme.difficultyOrangeColor;
    } else {
      difficultyElement.style.color = theme.difficultyRedColor;
    }
  });
});
