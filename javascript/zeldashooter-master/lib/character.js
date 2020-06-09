// need to pass options and draw(ctx)

class Character {
  constructor() {
    this.pos = [370,400];
    this.sizex = 75;
    this.sizey = 90;

    this.pic = new Image();
    this.pic.src = "./assets/images/link.png";

  }

  draw(ctx) {
    ctx.drawImage(this.pic, this.pos[0], this.pos[1], this.sizex, this.sizey);

    // ctx.beginPath();
    // ctx.fillStyle = "red";
    // ctx.rect(this.pos[0], this.pos[1], this.sizex, this.sizey);
    // ctx.fill();
  }

  move() {
    if (this.pos[0] < 1) {
      this.pos[0] = 1;
    } else if (this.pos[0] + this.sizex > 799) {
        this.pos[0] = 799 - this.sizex;
      }
  }

}

module.exports = Character;
