public class Listbox extends ParentPanel
{
    int listHeight;
    
    int itemHeight;
    int itemWidth;
    
    int scrolltabWidth = 15;
    int scrolltabHeight;
    int scrolltabX;
    int scrolltabY;
    
    int maxScrollDist = 0;
    int listStartAt = 0;
    
    Listbox ( String nm , int xx, int yy, int ww, int hh, int ih )
    {
        name = nm; x = xx; y = yy; wid = ww; hei = hh;
        wid = ww;
        hei = hh;
        drawPG = createGraphics(wid, hei);
        
        itemHeight = ih; itemWidth = wid - scrolltabWidth;
        
        refreshItems();
        
        calculateListHeight();
        updateScrollTab();
        
        // register it
        Interactive.add( this );
    }
    
    public void refreshItems( )
    {
      childPanels = new ArrayList<Panel>();
      for( Element e : elements )
      {
        addItem( e );
      }
    }
    
    public void addItem ( Element e )
    {
      MenuItem item = new MenuItem( 0 , 0 , itemWidth , itemHeight , e);
      childPanels.add( item );
    }
    
    public void removeItem ( Element item )
    {
      elements.remove(item);
      selectedElement = NONE;
      hoveredElement = NONE;
    }
    
    // called from manager
    void mouseScrolled ( float step )
    {
        scrollDist += (step*5);
        scrollDist = constrain( scrollDist, 0, maxScrollDist <= 0 ? 0 : maxScrollDist );
    }
    
    void updateThis ()
    {
      updatePosition();
      drawPG.background(200);
      drawPG.noStroke();
      drawPG.fill( 100 );
      drawPG.rect( 0 , 0 - scrollDist, wid , listHeight );
      
      //draw scrollbar
      drawPG.stroke(80);
      drawPG.fill(100);
      drawPG.rect(itemWidth, 0, wid, hei);
      drawPG.fill(200);
      drawPG.rect(scrolltabX, scrolltabY, scrolltabWidth, scrolltabHeight);
    }
    
    /**
     * update x position and list height in case window is resized
     */
    void updatePosition(){
      x = width - wid;
      hei = height - y - 100;
      updateMaxScrollDist();
      updateScrollTab();
    }
    
    void updateMaxScrollDist()
    {
      calculateListHeight();
      maxScrollDist = listHeight - hei;
    }
    
    void calculateListHeight(){
      listHeight = itemHeight * elements.size();
    }
    
    void updateScrollTab()
    {
      scrolltabHeight = int(float(hei * hei) / float(listHeight));
      scrolltabHeight = constrain(scrolltabHeight, 0, hei);
      scrolltabX = itemWidth;
      scrolltabY = int(float(hei * scrollDist) / float(listHeight)); //tabY is relative to drawPG 
    }
    
//    boolean handleMoved ( int mx, int my)
//    {
//      if(isInPanel(mx,my))
//      {
//        if(inItem(mx,my))
//        {
//          hoverItem(my);
//        }
//        return true;
//      }
//      else
//      {
//        unHover();
//        return false;
//      }
//    }
    
    void hoverThis()
    {
      hoverElement( null );
      println("Hovering on ", name);
    }
    
//    void hoverItem( int my )
//    {
////      int listClick = my + scrollDist - y;
////      int index = ceil(listClick / itemHeight);
////      if ( index >= elements.size())
////      {
////        if( hoverItem != NONE )
////        {
////          elements.get(hoverItem).hovered = false;
////          hoverItem = NONE;
////        } 
////    }
////      else
////      {
////        if(hoverItem != NONE)
////        {
////          elements.get(hoverItem).hovered = false;
////        }
////        hoverItem = index;
////        elements.get(hoverItem).hovered = true;
////      }
//    }
//    
//    void unHover()
//    {
////      if( hoverItem != NONE)
////      {
////        elements.get(hoverItem).hovered = false;
////        hoverItem = NONE;
////      }
//    }
    
    void clickScrollBar( int my )
    {
      println("clicked the scrollbar");
    }
    
    void clickThis()
    {
    }
    
    boolean inItem( int mx, int my)
    {
      boolean isInItem = (mx < x + itemWidth);
      return isInItem;
    }
    
    boolean inScrollbar( int mx, int my)
    {
      boolean isInArea = (mx >= x + itemWidth);
      return isInArea;
    }
}

