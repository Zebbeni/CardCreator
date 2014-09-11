public class Button
{
  int x;
  int y;
  int wid;
  int hei;
  PGraphics drawPG;
  
  Button ( int xx , int yy , int ww , int hh, PGraphics pGraph )
  {
    x = xx;
    y = yy;
    wid = ww;
    hei = hh;
    drawPG = pGraph;
  }
  
  void drawButton()
  {
    updatePosition();
    drawPG.fill(150);
    drawPG.rect( x , y , wid , hei );
  }
  
  void updatePosition()
  {
    
  }
}
