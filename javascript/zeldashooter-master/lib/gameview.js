const Game = require("./game");
// const Menu = require("./menu");


class GameView {
  constructor(ctx, menu) {
    this.ctx = ctx;
    this.game = new Game();
    this.menu = menu;
    this.started = false;
    this.running = true;
    this.game.keydown = this.game.keydown.bind(this.game);
    // document.addEventListener("keydown", this.game.keydown.bind(this.game));
  }

  start() {
    this.eventHandler = (e) => this.game.keydown(e);
    document.addEventListener("keydown", this.eventHandler, true);

    this.game.targetDisappearRunning = true;
    this.game.addCharacter();
    this.game.addTargets();
    this.game.playMusic();
    this.game.timerDisappear();
    this.game.timerReappear();
    requestAnimationFrame(this.animate.bind(this));
  }

  animate(){
    if (this.running) {
      if (!this.game.gameOver()) {
        this.game.targetDisappearRunning = true;
        this.game.step();
        this.game.draw(this.ctx);
      } else {
        // document.removeEventListener("keydown", this.eventHandler, true);
        this.score = this.game.score;
        this.running = false;
        this.game.targetDisappearRunning = false;
        this.game.misses = 10;
        this.game.score = 0;
        this.game.projectile = [];
        this.game.targets = [];
        this.game.addTargets();
        this.menu.gameover(this.score);
        return;
      }
    }

    requestAnimationFrame(this.animate.bind(this));
  }
}

module.exports = GameView;
