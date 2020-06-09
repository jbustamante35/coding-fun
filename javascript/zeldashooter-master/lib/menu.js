const GameView = require("./gameview");

class Menu {
  constructor(ctx) {
    this.ctx = ctx;
    this.gameview = new GameView(this.ctx, this);
    this.scroll = 0;
    this.highscore = 0;
    this.firstTimer = true;

    this.git = new Image();
    this.git.src = "./assets/images/git.png"

    this.linkedin = new Image();
    this.linkedin.src = "./assets/images/linkedin.png"

    this.background = new Image();
    this.background.src = "./assets/images/background.png";

    this.pic = new Image();
    this.pic.src = "./assets/images/navi.png";

    this.cucco = new Image();
    this.cucco.src = "./assets/images/cucco.png";

    this.rupee = new Image();
    this.rupee.src = "./assets/images/rupee.png";

    this.music = new Image();
    this.music.src = "./assets/images/music.png";

    this.arrow = new Image();
    this.arrow.src = "./assets/images/arrow.png";

    this.link = new Image();
    this.link.src = "./assets/images/link.png";
  }

  gameover(score) {
    if (score > this.highscore) {
      this.highscore = score;
    }

    setTimeout(this.start.bind(this), 1000);
    this.ctx.clearRect(0,0,800,600);
    this.ctx.fillStyle = "black";
    this.ctx.fillRect(0,0,800, 600);
    this.ctx.fillStyle = "red";
    this.ctx.font="30px Zelda";
    this.ctx.fillText(`Game Over`, 350, 300);
    // this.ctx.drawImage(this.background, 0, 0, 800, 600);
  }

  scrollText() {
    if (this.scroll == 0) {
      this.ctx.clearRect(0,0,800,600);
      this.ctx.drawImage(this.background, 0, -50, 800, 600);
      this.ctx.fillStyle = "black";
      this.ctx.fillRect(0,0,800,100);
      this.ctx.fillRect(0,500, 800, 100)
      this.ctx.drawImage(this.arrow, 280, 510, 20, 50);
      this.ctx.drawImage(this.music, 380, 510, 50, 50);
      this.ctx.drawImage(this.link, 500, 510, 50, 50);
      this.ctx.drawImage(this.cucco, 670, 20, 50, 50);
      this.ctx.drawImage(this.rupee, 740, 20, 40, 50);
      // this.ctx.drawImage(this.git, 660, 20, 50, 50);
      // this.ctx.drawImage(this.linkedin, 730, 20, 50, 50);

      this.ctx.beginPath();
      this.ctx.fillStyle = "yellow";
      this.ctx.font="18px Zelda";
      this.ctx.fillText(`SpaceBar`, 255, 590);
      this.ctx.fillText(`M`, 390, 590);
      this.ctx.fillText(`Left + Right`, 485, 590);
      this.ctx.fillText(`100 pts`, 670, 85);
      this.ctx.fillText(`10 pts`, 735, 85);

      this.ctx.font="30px Zelda";
      this.ctx.fillText(`Highscore: ${this.highscore}`, 10, 60);
      this.ctx.fillText(`Escaped Targets Left: 10`, 10, 90);
      this.ctx.fillText(`Zelda Shooting Gallery`, 260, 60);
      this.ctx.fillText(`Controls`, 100, 570);

      this.ctx.fillText(`Hey! Listen!`, 330, 450);

      setTimeout(this.navi.bind(this), 10);

      this.scroll = 1;
    } else if (this.scroll == 1) {
      this.ctx.clearRect(0,0,800,600);
      this.ctx.drawImage(this.background, 0, -50, 800, 600);
      this.ctx.fillStyle = "black";
      this.ctx.fillRect(0,0,800,100);
      this.ctx.fillRect(0,500, 800, 100)
      this.ctx.drawImage(this.arrow, 280, 510, 20, 50);
      this.ctx.drawImage(this.music, 380, 510, 50, 50);
      this.ctx.drawImage(this.link, 500, 510, 50, 50);
      this.ctx.drawImage(this.cucco, 670, 20, 50, 50);
      this.ctx.drawImage(this.rupee, 740, 20, 40, 50);
      // this.ctx.drawImage(this.git, 660, 20, 50, 50);
      // this.ctx.drawImage(this.linkedin, 730, 20, 50, 50);

      this.ctx.beginPath();
      this.ctx.fillStyle = "yellow";
      this.ctx.font="18px Zelda";
      this.ctx.fillText(`SpaceBar`, 255, 590);
      this.ctx.fillText(`M`, 390, 590);
      this.ctx.fillText(`Left + Right`, 485, 590);
      this.ctx.fillText(`100 pts`, 670, 85);
      this.ctx.fillText(`10 pts`, 735, 85);

      this.ctx.font="30px Zelda";
      this.ctx.fillText(`Highscore: ${this.highscore}`, 10, 60);
      this.ctx.fillText(`Escaped Targets Left: 10`, 10, 90);
      this.ctx.fillText(`Zelda Shooting Gallery`, 260, 60);
      this.ctx.fillText(`Controls`, 100, 570);

      this.ctx.fillText(`You have an important mission`, 220, 450);
      this.navi();

      this.scroll = 2
    } else if (this.scroll == 2) {
      this.ctx.clearRect(0,0,800,600);
      this.ctx.drawImage(this.background, 0, -50, 800, 600);
      this.ctx.fillStyle = "black";
      this.ctx.fillRect(0,0,800,100);
      this.ctx.fillRect(0,500, 800, 100)
      this.ctx.drawImage(this.arrow, 280, 510, 20, 50);
      this.ctx.drawImage(this.music, 380, 510, 50, 50);
      this.ctx.drawImage(this.link, 500, 510, 50, 50);
      this.ctx.drawImage(this.cucco, 670, 20, 50, 50);
      this.ctx.drawImage(this.rupee, 740, 20, 40, 50);
      // this.ctx.drawImage(this.git, 660, 20, 50, 50);
      // this.ctx.drawImage(this.linkedin, 730, 20, 50, 50);

      this.ctx.beginPath();
      this.ctx.fillStyle = "yellow";
      this.ctx.font="18px Zelda";
      this.ctx.fillText(`SpaceBar`, 255, 590);
      this.ctx.fillText(`M`, 390, 590);
      this.ctx.fillText(`Left + Right`, 485, 590);
      this.ctx.fillText(`100 pts`, 670, 85);
      this.ctx.fillText(`10 pts`, 735, 85);

      this.ctx.font="30px Zelda";
      this.ctx.fillText(`Highscore: ${this.highscore}`, 10, 60);
      this.ctx.fillText(`Escaped Targets Left: 10`, 10, 90);
      this.ctx.fillText(`Zelda Shooting Gallery`, 260, 60);
      this.ctx.fillText(`Controls`, 100, 570);

      this.ctx.fillText(`Hit as many rupees and cuccos as you can`, 170, 450);

      this.navi();

      this.scroll = 3
    } else if (this.scroll == 3) {
      this.ctx.clearRect(0,0,800,600);
      this.ctx.drawImage(this.background, 0, -50, 800, 600);
      this.ctx.fillStyle = "black";
      this.ctx.fillRect(0,0,800,100);
      this.ctx.fillRect(0,500, 800, 100)
      this.ctx.drawImage(this.arrow, 280, 510, 20, 50);
      this.ctx.drawImage(this.music, 380, 510, 50, 50);
      this.ctx.drawImage(this.link, 500, 510, 50, 50);
      this.ctx.drawImage(this.cucco, 670, 20, 50, 50);
      this.ctx.drawImage(this.rupee, 740, 20, 40, 50);
      // this.ctx.drawImage(this.git, 660, 20, 50, 50);
      // this.ctx.drawImage(this.linkedin, 730, 20, 50, 50);

      this.ctx.beginPath();
      this.ctx.fillStyle = "yellow";
      this.ctx.font="18px Zelda";
      this.ctx.fillText(`SpaceBar`, 255, 590);
      this.ctx.fillText(`M`, 390, 590);
      this.ctx.fillText(`Left + Right`, 485, 590);
      this.ctx.fillText(`100 pts`, 670, 85);
      this.ctx.fillText(`10 pts`, 735, 85);

      this.ctx.font="30px Zelda";
      this.ctx.fillText(`Highscore: ${this.highscore}`, 10, 60);
      this.ctx.fillText(`Escaped Targets Left: 10`, 10, 90);
      this.ctx.fillText(`Zelda Shooting Gallery`, 260, 60);
      this.ctx.fillText(`Controls`, 100, 570);

      this.ctx.fillText(`If you're too slow they'll disappear`, 210, 450);

      this.navi();

      this.scroll = 4
    } else if (this.scroll == 4) {
      this.ctx.clearRect(0,0,800,600);
      this.ctx.drawImage(this.background, 0, -50, 800, 600);
      this.ctx.fillStyle = "black";
      this.ctx.fillRect(0,0,800,100);
      this.ctx.fillRect(0,500, 800, 100)
      this.ctx.drawImage(this.arrow, 280, 510, 20, 50);
      this.ctx.drawImage(this.music, 380, 510, 50, 50);
      this.ctx.drawImage(this.link, 500, 510, 50, 50);
      this.ctx.drawImage(this.cucco, 670, 20, 50, 50);
      this.ctx.drawImage(this.rupee, 740, 20, 40, 50);
      // this.ctx.drawImage(this.git, 660, 20, 50, 50);
      // this.ctx.drawImage(this.linkedin, 730, 20, 50, 50);

      this.ctx.beginPath();
      this.ctx.fillStyle = "yellow";
      this.ctx.font="18px Zelda";
      this.ctx.fillText(`SpaceBar`, 255, 590);
      this.ctx.fillText(`M`, 390, 590);
      this.ctx.fillText(`Left + Right`, 485, 590);
      this.ctx.fillText(`100 pts`, 670, 85);
      this.ctx.fillText(`10 pts`, 735, 85);

      this.ctx.font="30px Zelda";
      this.ctx.fillText(`Highscore: ${this.highscore}`, 10, 60);
      this.ctx.fillText(`Escaped Targets Left: 10`, 10, 90);
      this.ctx.fillText(`Zelda Shooting Gallery`, 260, 60);
      this.ctx.fillText(`Controls`, 100, 570);

      this.ctx.fillText(`Let 10 get away, and it's game over!`, 190, 450);

      this.navi();

      this.scroll = 5
    } else if (this.scroll == 6) {
      this.ctx.clearRect(0,0,800,600);
      this.ctx.drawImage(this.background, 0, -50, 800, 600);
      this.ctx.fillStyle = "black";
      this.ctx.fillRect(0,0,800,100);
      this.ctx.fillRect(0,500, 800, 100)
      this.ctx.drawImage(this.arrow, 280, 510, 20, 50);
      this.ctx.drawImage(this.music, 380, 510, 50, 50);
      this.ctx.drawImage(this.link, 500, 510, 50, 50);
      this.ctx.drawImage(this.cucco, 670, 20, 50, 50);
      this.ctx.drawImage(this.rupee, 740, 20, 40, 50);
      // this.ctx.drawImage(this.git, 660, 20, 50, 50);
      // this.ctx.drawImage(this.linkedin, 730, 20, 50, 50);

      this.ctx.beginPath();
      this.ctx.fillStyle = "yellow";
      this.ctx.font="18px Zelda";
      this.ctx.fillText(`SpaceBar`, 255, 590);
      this.ctx.fillText(`M`, 390, 590);
      this.ctx.fillText(`Left + Right`, 485, 590);
      this.ctx.fillText(`100 pts`, 670, 85);
      this.ctx.fillText(`10 pts`, 735, 85);

      this.ctx.font="30px Zelda";
      this.ctx.fillText(`Highscore: ${this.highscore}`, 10, 60);
      this.ctx.fillText(`Escaped Targets Left: 10`, 10, 90);
      this.ctx.fillText(`Zelda Shooting Gallery`, 260, 60);
      this.ctx.fillText(`Controls`, 100, 570);

      this.ctx.fillText(`Play Again?`, 330, 450);

      this.navi();

      this.scroll = 5
    } else {
      this.scroll = 6;
      this.listen();
    }
  }

  // background() {
  //   this.ctx.drawImage(this.background, 0, -50, 800, 600);
  // }

  navi() {
    this.ctx.drawImage(this.pic, 530, 290, 150, 150);
  }

  start() {
    this.ctx.drawImage(this.background, 0, 0, 800, 600);

    if (this.firstTimer) {
      setTimeout(this.scrollText.bind(this), 1300);
      setTimeout(this.navi.bind(this), 1300);
      this.firstTimer = false;
    } else {
      setTimeout(this.scrollText.bind(this), 10);
      setTimeout(this.navi.bind(this), 10);
    }

    this.eventHandler = () => this.scrollText();
    document.addEventListener("keydown", this.eventHandler, true);
  }

  listen() {
    document.removeEventListener("keydown", this.eventHandler, true);
    if (this.gameview.started === false) {
      this.gameview.start();
      this.gameview.started = true;
      this.gameview.running = true;
    } else {
      this.gameview.animate();
      this.gameview.running = true;
    }
  }

}

module.exports = Menu;
