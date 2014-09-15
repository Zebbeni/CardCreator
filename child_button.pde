public class Button extends ChildPanel
{
  Button ( String nm , int xx , int yy , int ww , int hh )
  {
    name = nm;
    x = xx;
    y = yy;
    wid = ww;
    hei = hh;
    drawPG = createGraphics( wid, hei );
  }
  
  public void clickThis()
  {
//    println("clicked ", name);
  }
  
  public void updateThis()
  {
    drawPG.strokeWeight(2);
    drawPG.fill(150);
    drawPG.rect( 0 , 0 , wid , hei );
  }
}
