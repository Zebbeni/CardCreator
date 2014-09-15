public class MenuItem extends ChildPanel
{
  Element element;
  
  MenuItem ( int xx, int yy, int ww , int hh , Element e)
  {
    x = xx; y = yy; wid = ww; hei = hh; element = e;
    drawPG = createGraphics( wid, hei );
  }
  
  public void clickThis()
  {
    selectElement( element );
  }
  
  public void updateThis()
  {
    if(element.index == 2)
    {
      y = (element.index * hei) - scrollDist;
      drawPG.fill( 200 );
//    if (element.selected)
//    {
//      drawPG.fill( 255 );
//    }
//    else if(element.hovered)
//    {
//      drawPG.fill(215);
//    }
      drawPG.rect( x , y , wid , hei );
    
//    drawPG.noStroke();
      drawPG.fill( 0 );
      drawPG.text( element.name, x + 25, y );
    }
  }
}
