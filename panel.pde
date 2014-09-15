public abstract class Panel
{
  int x;
  int y;
  int wid;
  int hei;
  PGraphics drawPG;
  String name = "No Name";

  public abstract void clickThis();
  public abstract boolean click( int mx , int my );
  
  public abstract void updateThis();
  public abstract void updateDraw();
  public abstract void drawToBuffer( PGraphics parentPG);
  
  public void updateDrawPG()
  {
    drawPG = createGraphics( wid, hei );
    drawPG.beginDraw();
    updateDraw();
    drawPG.endDraw();
  }
  
  public boolean isInPanel( int mx , int my )
  {
    /**
     * Returns true if the given mouse X and mouse Y lie in this panel
     */
    boolean isHere = (mx > x && mx < (x + wid) && my > y && y < (my + hei));
    return isHere;
  }
}



