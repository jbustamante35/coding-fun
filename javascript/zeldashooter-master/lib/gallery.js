// const Game = require("./game");
// const GameView = require("./gameview");
const Menu = require("./menu");

document.addEventListener("DOMContentLoaded", function(){
  const canvas = document.getElementById('mycanvas');
  const ctx = canvas.getContext('2d');

  // const game = new Game();
  // document.addEventListener("keydown", game.keydown.bind(game));
  // debugger;
  new Menu(ctx).start();
  // new GameView(ctx, document).start();

});
