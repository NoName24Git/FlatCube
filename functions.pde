int r(float num) {
  return round(num);
}
int rand(int randMin, int randMax) {
  return round(random(randMin, randMax));
}
void clr(float red, float green, float blue) {
  noFill();
  fill(red, green, blue);
}
void clro(float red, float green, float blue, float alpha) {
  noFill();
  fill(red, green, blue, alpha);
}

// orig
void setBlock(float xPos, float yPos, float xSize, float ySize) {
  rect(disW2 + xPos - xSize/2, disH2 - yPos - ySize/2, xSize, ySize);
}
void setBlock2(float xPos, float yPos, float xSize, float ySize, float k) {
  rect(disW2 + xPos - xSize/2, disH2 - yPos - ySize/2, xSize, ySize, k);
}
void setText(String txt, float xPos, float yPos, float size) {
  textSize(size);
  textAlign(CENTER, CENTER);
  text(txt, disW2 + xPos, disH2 - yPos);
}
void setTextn(String txt, float xPos, float yPos, float size) {
  textSize(size);
  text(txt, disW2 + xPos, disH2 - yPos);
}
void setTextWH(String txt, float xPos, float yPos, float size, float w, float h) {
  textSize(size);
  //textAlign(CENTER, CENTER);
  text(txt, disW2 + xPos, disH2 - yPos, w, h);
}
void setRotateBlock(float xPos, float yPos, float xSize, float ySize, float Rotate) {
  pushMatrix();
  translate (disW2+xPos, disH2-yPos);
  rotate(Rotate);
  setBlock(-disW2, disH2, xSize, ySize);
  popMatrix();
}
void setEps(float xPos, float yPos, float xSize, float ySize) {
  ellipse(disW2 + xPos, disH2 - yPos, xSize, ySize);
}
void setRotateEps(float xPos, float yPos, float xSize, float ySize, float Rotate) {
  pushMatrix();
  translate (disW2+xPos, disH2-yPos);
  rotate(Rotate);
  setEps(-disW2, disH2, xSize, ySize);
  popMatrix();
}
void setLine(float xPos, float yPos, float xPos2, float yPos2) {
  line(disW2 + xPos, disH2 - yPos, disW2 + xPos2, disH2 - yPos2);
}
void setImage(PImage fImage, float xPos, float yPos, float xSize, float ySize) {
  image(fImage, disW2 + xPos - xSize/2, disH2 - yPos - ySize/2, xSize, ySize);
}
void setRotateImage(PImage fImage, float xPos, float yPos, float xSize, float ySize, float Rotate) {
  pushMatrix();
  translate (disW2+xPos, disH2-yPos);
  rotate(Rotate);
  setImage(fImage, -disW2, disH2, xSize, ySize);
  popMatrix();
}
Boolean tap(float xPos, float yPos, float xSize, float ySize) {
  if (((moux>xPos-xSize/2)&&(moux<xPos+xSize/2))&&((mouy>yPos-ySize/2)&&(mouy<yPos+ySize/2))) {
    return true;
  } else {
    return false;
  }
}
float leng(float X1, float Y1) {
  return sqrt(X1*X1+Y1*Y1);
}
float leng3d(float X1, float Y1, float Z1) {
  return sqrt(X1*X1+Y1*Y1+Z1*Z1);
}
/*
public PImage getReversePImage( PImage image ) {
  PImage reverse = new PImage( image.width, image.height );
  for ( int i=0; i < image.width; i++ ) {
    for (int j=0; j < image.height; j++) {
      reverse.set( image.width - 1 - i, j, image.get(i, j) );
    }
  }
  return reverse;
}
void setVert(float vertexs[][]) {
  beginShape ();
  for (int vi = 0; vi < vertexs.length; vi++) {
    vertex((vertexs[vi][0]) + disW2, disH2 - (vertexs[vi][1]), 0, 0);
  }
  endShape ();
}
void setTriangle(float vertexs[][]) {
  triangle(vertexs[0][0] + disW2, disH2 - vertexs[0][1], vertexs[1][0] + disW2, disH2 - vertexs[1][1], vertexs[2][0] + disW2, disH2 - vertexs[2][1]);
  triangle(vertexs[0][0] + disW2, disH2 - vertexs[0][1], vertexs[3][0] + disW2, disH2 - vertexs[3][1], vertexs[2][0] + disW2, disH2 - vertexs[2][1]);
}
*/