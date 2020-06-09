class Cucco {
  constructor(options) {
    this.pos = [800,100];
    this.sizex = 60;
    this.sizey = 60;
    this.pic = new Image();
    this.pic.src = "./assets/images/cucco.png";
  }

  move() {
    this.pos[0] -= 5;
  }

  draw(ctx) {
    ctx.drawImage(this.pic, this.pos[0], this.pos[1], this.sizex, this.sizey);
  }


}

module.exports = Cucco;
