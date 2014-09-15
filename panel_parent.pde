public abstract class ParentPanel extends Panel
{
  ArrayList<Panel> childPanels = new ArrayList<Panel>();
  
  public boolean click( int mx , int my )
  {
    /*
     * Passes relative click info to all children until it finds one clicked
     * by the mouse.
     */ 
    boolean clickedInHere = isInPanel( mx , my );
    
    if( clickedInHere )
    {
      boolean clickedChild = false;
      for( int i = 0; i < childPanels.size() && !clickedChild ; i++ )
      {
        clickedChild = childPanels.get(i).click( mx - x, my - y);
      }
      if( !clickedChild )
      {
        clickThis();
      }
    }
    
    return clickedInHere;
  }
  
  public void updateDraw()
  {
    updateThis();
    for( Panel p : childPanels)
    {
      p.updateDrawPG();
    }
  }
  
  public void drawToBuffer( PGraphics parentPG )
  {
    /*
     * Begins drawing drawPG and passes this to children to
     * draw on, before passing the final image to its own parent
     */ 
    drawPG.beginDraw();
    for( Panel p : childPanels )
    {
      p.drawToBuffer( drawPG );
    }
    drawPG.endDraw();
    parentPG.image( drawPG , x , y );
  }
}
