class Score {
  constructor(score) {
    this.score = score;
  }

  draw(ctx) {
    ctx.beginPath();
    ctx.fillStyle = "pink";
    ctx.rect(0, 0, 50, 50);
    ctx.font="30px Verdana";
    ctx.fillText();
  }

  move() {

  }
}
