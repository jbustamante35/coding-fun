class Projectile {
  constructor(options) {
    this.pos = options.pos;
    this.sizex = 20;
    this.sizey = 50;
    this.pic = new Image();
    this.pic.src = "./assets/images/arrow.png";
  }

  move() {
    this.pos[1] -= 10;
  }

  draw(ctx) {
    ctx.drawImage(this.pic, this.pos[0], this.pos[1], this.sizex, this.sizey);

    // ctx.beginPath();
    // ctx.fillStyle = "pink";
    // ctx.rect(this.pos[0], this.pos[1], this.sizex, this.sizey);
    // ctx.fill();
  }

}

module.exports = Projectile;
