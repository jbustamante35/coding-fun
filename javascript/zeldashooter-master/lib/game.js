const Character = require("./character");
const Projectile = require("./projectile");
const Target = require("./target");
const Cucco = require("./cucco");

class Game {
  constructor() {
    this.score = 0;
    this.misses = 10;
    this.character = [];
    this.projectile = [];
    this.targetsWaiting = [];
    this.targets = [];

    this.darudeModeOn = false;
    this.darude = new Audio("./assets/audio/darude_sandstorm.wav");
    this.darude.loop = true;
    this.cucco = new Audio("./assets/audio/cucco_cry.wav");

    this.targetDisappearRunning = false;

    this.cuccopic = new Image();
    this.cuccopic.src = "./assets/images/cucco.png";

    this.rupee = new Image();
    this.rupee.src = "./assets/images/rupee.png";

    this.music = new Image();
    this.music.src = "./assets/images/music.png";

    this.arrow = new Image();
    this.arrow.src = "./assets/images/arrow.png";

    this.link = new Image();
    this.link.src = "./assets/images/link.png";

  }

  playMusic() {
    // this.snd.innerHTML = '<source src="' + './music.wav'+ '" type="audio/mpeg"' + ' loop="true" />';
    // this.snd.innerHTML = '<source src="' + './music.wav'+ '" type="audio/mpeg" />';
    this.snd = document.createElement('audio');
    this.snd = new Audio("./assets/audio/music.wav");
    this.snd.loop = true;
    // this.snd.play();
  }

  darudeMode() {
    if (this.score > 200 && this.darudeModeOn === false && !this.snd.paused) {
      this.snd.pause();
      // this.darude = document.createElement('audio');
      // this.darude = new Audio("./darude_sandstorm.wav");
      // this.darude.loop = true;
      this.darudeModeOn = true;
      this.darude.play();
    }
  }

  add(object) {
    if (object instanceof Character) {
      this.character.push(object);
    } else if (object instanceof Projectile) {
      this.projectile.push(object);
    }
  }

  addCharacter() {
    const char = new Character();

    this.add(char);

    return char;
  }

  addTargets() {
    const target1 = new Target([200, 200]);
    const target2 = new Target([300, 200]);
    const target3 = new Target([400, 200]);
    const target4 = new Target([500, 200]);
    const cucco = new Cucco();

    this.targetsWaiting = [cucco];
    this.targets = [target1, target2, target3, target4];

  }

  addProjectile() {
    if (this.projectile.length <= 1) {
      const posi = this.character[0].pos;
      const projectile = new Projectile({
        pos: [posi[0]+ 20, posi[1]]
      });
      this.add(projectile);

      return projectile;
    }
  }

  allObjects() {
    return [].concat(this.character, this.projectile, this.targets);
  }

  keydown(e) {
    if (e.keyCode === 37) {
      this.character[0].pos[0] -= 10;
    } else if (e.keyCode === 39) {
       this.character[0].pos[0] += 10;
    } else if (e.keyCode === 32) { //65
      this.addProjectile();
    } else if (e.keyCode === 77) {
      if (this.darude.paused && this.darudeModeOn === true) {
        this.darude.play();
      } else if (!this.darude.paused && this.darudeModeOn === true) {
        this.darude.pause();
      } else if (this.snd.paused && this.darudeModeOn === false) {
        this.snd.play();
      } else if (!this.snd.paused && this.darudeModeOn === false){
        this.snd.pause();
      }
    }
  }

  moveObjects() {
    // console.log(this.allObjects());
    this.allObjects().forEach((object) => {
      object.move();
    });
  }

  draw(ctx) {
    ctx.clearRect(0,0,800,600);
    ctx.fillStyle = "black";
    ctx.fillRect(0,0,800,600);

    this.drawScreen(ctx);

    this.allObjects().forEach((object) => {
      object.draw(ctx);
    });

    this.drawTitle(ctx);
    this.drawScore(ctx);
    this.drawMisses(ctx);
    this.drawInstructions(ctx);

  }

  drawInstructions(ctx) {
    ctx.drawImage(this.arrow, 280, 510, 20, 50);
    ctx.drawImage(this.music, 380, 510, 50, 50);
    ctx.drawImage(this.link, 500, 510, 50, 50);
    ctx.drawImage(this.cuccopic, 670, 20, 50, 50);
    ctx.drawImage(this.rupee, 740, 20, 40, 50);

    ctx.beginPath();
    ctx.fillStyle = "yellow";
    ctx.font="18px Zelda";
    ctx.fillText(`SpaceBar`, 255, 590);
    ctx.fillText(`M`, 390, 590);
    ctx.fillText(`Left + Right`, 485, 590);
    ctx.fillText(`100 pts`, 670, 85);
    ctx.fillText(`10 pts`, 735, 85);

    ctx.font="30px Zelda";
    ctx.fillText(`Controls`, 100, 570);
  }

  drawScreen(ctx) {
    const pic = new Image();
    pic.src = "./assets/images/mapscreen.png";
    ctx.drawImage(pic, 0 , 100);
  }

  drawTitle(ctx) {
    ctx.beginPath();
    ctx.fillStyle = "yellow";
    ctx.font="30px Zelda";
    ctx.fillText(`Zelda Shooting Gallery`, 260, 60);
  }

  drawScore(ctx) {
    ctx.beginPath();
    ctx.fillStyle = "yellow";
    ctx.font="30px Zelda";
    ctx.fillText(`Score: ${this.score}`, 10, 60);
  }

  drawMisses(ctx) {
    ctx.beginPath();
    ctx.fillStyle = "yellow";
    ctx.font="30px Zelda";
    ctx.fillText(`Escaped Targets Left: ${this.misses}`, 10, 90);
  }

  checkCollision() {
    this.targets.forEach((target, idx) => {
      this.projectile.forEach((proj, index) => {
        if ((proj.pos[0] + proj.sizex) > target.pos[0] &&
          proj.pos[0] < (target.pos[0] + target.sizex) &&
          proj.pos[1] > target.pos[1] &&
          proj.pos[1] < target.pos[1] + target.sizey
        ) if (target instanceof Cucco) {
            this.projectile.splice(index, 1);
            let cucco = this.targets.splice(idx, 1);
            cucco[0].pos = [700,100];
            this.targetsWaiting.push(cucco[0]);
            this.score += 100;
            if (!this.snd.paused || !this.darude.paused) {
              this.cucco.play();
            }
            this.darudeMode();
        } else {
            clearInterval(this.intervalDisappear);
            this.projectile.splice(index, 1);
            let removed = this.targets.splice(idx, 1);
            this.targetsWaiting.push(removed[0]);
            this.score += 10;
            this.timerDisappear();
          }


      });
    });
  }

  step() {
    this.moveObjects();
    this.deleteObjects();
    this.checkCollision();
    // this.gameOver();
  }

  timerDisappear() {
    this.intervalDisappear = setInterval(this.targetDisappear.bind(this), 2000);
  }

  timerReappear() {
    this.intervalReappear = setInterval(this.targetReappear.bind(this), 1500);
  }

  targetDisappear() {
    if (this.targets[0] && this.targetDisappearRunning) {
      let removed = this.targets.splice(0, 1);
      this.targetsWaiting.push(removed[0]);
      this.misses -= 1;
    }
  }

  targetReappear() {
    // console.log(this.targetsWaiting);
    let idx = Math.floor(Math.random()*this.targetsWaiting.length);
    let removed = this.targetsWaiting.splice(idx, 1);
    if (removed[0] instanceof Cucco || this.targets.length <= 1) {
      this.targets.push(removed[0]);

      let idx2 = Math.floor(Math.random()*this.targetsWaiting.length);
      let removed2 = this.targetsWaiting.splice(idx2, 1);

      if (removed2[0]) {
        this.targets.push(removed2[0]);
      }
    } else if (removed[0]) {
      this.targets.push(removed[0]);
    }

  }

  deleteObjects() {
    this.allObjects().forEach((object) => {
      if (object instanceof Projectile) {
        if (object.pos[1] < 80) {
          this.projectile.splice(this.projectile.indexOf(object), 1);
          this.score -= 30;
        }

      } else if (object instanceof Cucco) {
        if (object.pos[0] < 0) {
          const cucco = this.targets.splice(this.targets.indexOf(object), 1);
          cucco[0].pos = [800,100];
          this.targetsWaiting.push(cucco[0]);
          this.score -= 30;
          this.misses -= 1;
        }
      }
    });
  }

  gameOver() {
    // console.log(this.misses);
    if (this.misses <= 0) {
      return true;
    }
  }

}
//
// Game.X = 800;
// Game.Y = 600;
// Game.IN_X = 800;
// Game.IN_Y = 400;

module.exports = Game;
