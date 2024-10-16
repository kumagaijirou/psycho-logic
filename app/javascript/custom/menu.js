// メニュー操作

// トグルリスナーを追加してクリックをリッスンする
document.addEventListener("turbo:load", function() {
  let hamburger = document.querySelector("#hamburger");
  hamburger.addEventListener("click", function(event) {
    event.preventDefault();
    hamburger.classList.toggle("active");
    let menu = document.querySelector("#navbar-menu");
    menu.classList.toggle("active");
  });
  let account = document.querySelector("#account");
  account.addEventListener("click", function(event) {
    event.preventDefault();
    let menu = document.querySelector("#dropdown-menu");
    menu.classList.toggle("active");
  });
});