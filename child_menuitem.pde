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
  
  public void hoverThis()
  {
    hoverElement(element);
  }
  
  public void updateThis()
  {
    y = (element.index * hei) - scrollDist;
    drawPG.fill( 210 );
    if (element.selected)
    {
      drawPG.fill( 255 );
    }
    else if(element.hovered)
    {
      drawPG.fill(215);
    }
    drawPG.rect( 0 , 0 , wid , hei );
  
    drawPG.noStroke();
    drawPG.fill( 0 );
    drawPG.text( element.name, 25, 25 );
  }
}
