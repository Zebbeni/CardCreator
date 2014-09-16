public abstract class ChildPanel extends Panel
{
  public boolean click( int mx , int my )
  {
    /**
     * Returns true if the click occurred in this panel
     * calls class-specific click function with mouse X and mouse Y
     */
    boolean clickedInHere = isInPanel( mx , my );
    if ( clickedInHere ) 
    {
      clickThis();
    }
    return clickedInHere;
  }
  
  public boolean hover( int mx , int my )
  {
    /**
     * Returns true if the click occurred in this panel
     * calls class-specific click function with mouse X and mouse Y
     */
    boolean hoveredInHere = isInPanel( mx , my );
    if ( hoveredInHere ) 
    {
      hoverThis();
    }
    return hoveredInHere;
  }
  
  public void updateDraw()
  {
    updateThis();
  }
  
  public void drawToBuffer( PGraphics parentPG )
  {
    /*
     * draws thisPG to the parentPG
     */
    parentPG.image( drawPG , x , y );
  }
}
