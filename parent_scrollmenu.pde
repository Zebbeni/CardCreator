public class Listbox extends ParentPanel
{
    int listHeight;
    
    ArrayList<Element> items;
    int selectedItem = NONE;
    int hoverItem = NONE;
    
    int itemHeight;
    int itemWidth;
    
    int scrolltabWidth = 15;
    int scrolltabHeight;
    int scrolltabX;
    int scrolltabY;
    int scrollDist = 0;
    
    int maxScrollDist = 0;

    int listStartAt = 0;
    
    Listbox ( String nm , int xx, int yy, int ww, int hh, int ih, ArrayList<Element> e)
    {
        name = nm; x = xx; y = yy; wid = ww; hei = hh;
        wid = ww;
        hei = hh;
        drawPG = createGraphics(wid, hei);
        
        itemHeight = ih; itemWidth = wid - scrolltabWidth;
        
        items = e;
        calculateListHeight();
        updateScrollTab();
        
        // register it
        Interactive.add( this );
    }
    
    public void addItem ( Element item )
    {
        if ( items == null ) items = new ArrayList();
        items.add( item );
    }
    
    public void removeItem ( Element item )
    {
      items.remove(item);
      selectedItem = NONE;
      hoverItem = NONE;
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
        drawPG.beginDraw();
        drawPG.background(200);
        drawPG.noStroke();
        drawPG.fill( 100 );
        drawPG.rect( 0 , 0 - scrollDist, wid , listHeight );
        if ( items != null )
        {
            for ( int i = 0; i < items.size(); i++ )
            {
                drawPG.stroke( 80 );
                drawPG.fill( 200 );
                if (items.get(i).selected)
                {
                  drawPG.fill( 255 );
                }
                else if(items.get(i).hovered)
                {
                  drawPG.fill(215);
                }
                drawPG.rect( 0, (i*itemHeight) - scrollDist, wid, itemHeight );
                
                drawPG.noStroke();
                drawPG.fill( 0 );
                drawPG.text( items.get(i+listStartAt).name, 25, (i+1)*(itemHeight) - 20 - scrollDist );
            }
        }
        
        //draw scrollbar
        drawPG.stroke(80);
        drawPG.fill(100);
        drawPG.rect(itemWidth, 0, wid, hei);
        drawPG.fill(200);
        drawPG.rect(scrolltabX, scrolltabY, scrolltabWidth, scrolltabHeight);

        drawPG.endDraw();
    }
    
    /**
     * update x position and list height in case window is resized
     */
    void updatePosition(){
      x = width - wid;
      hei = height - y - 100;
      updateMaxScrollDist();
      updateScrollTab();
      drawPG = createGraphics(wid, hei);
    }
    
    void updateMaxScrollDist()
    {
      calculateListHeight();
      maxScrollDist = listHeight - hei;
    }
    
    void calculateListHeight(){
      listHeight = itemHeight * items.size();
    }
    
    void updateScrollTab()
    {
      scrolltabHeight = int(float(hei * hei) / float(listHeight));
      scrolltabHeight = constrain(scrolltabHeight, 0, hei);
      scrolltabX = itemWidth;
      scrolltabY = int(float(hei * scrollDist) / float(listHeight)); //tabY is relative to drawPG 
    }
    
    boolean handleMoved ( int mx, int my)
    {
      if(isInPanel(mx,my))
      {
        if(inItem(mx,my))
        {
          hoverItem(my);
        }
        return true;
      }
      else
      {
        unHover();
        return false;
      }
    }
    
    void hoverItem( int my )
    {
      int listClick = my + scrollDist - y;
      int index = ceil(listClick / itemHeight);
      if ( index >= items.size())
      {
        if( hoverItem != NONE )
        {
          items.get(hoverItem).hovered = false;
          hoverItem = NONE;
        } 
    }
      else
      {
        if(hoverItem != NONE)
        {
          items.get(hoverItem).hovered = false;
        }
        hoverItem = index;
        items.get(hoverItem).hovered = true;
      }
    }
    
    void unHover()
    {
      if( hoverItem != NONE)
      {
        items.get(hoverItem).hovered = false;
        hoverItem = NONE;
      }
    }
    
    void selectItem( int my )
    {
      int listClick = my + scrollDist - y;
      int index = int(listClick / itemHeight);
      if(index >= items.size())
      {
        if( selectedItem != NONE)
        {
          items.get(selectedItem).selected = false;
        }
        selectedItem = NONE;
      }
      else
      {
        if( selectedItem != NONE)
        {
          items.get(selectedItem).selected = false;
        }
        selectedItem = index;
        items.get(selectedItem).selected = true;
      }
    }
    
    void clickScrollBar( int my )
    {
      println("clicked the scrollbar");
    }
    
    void clickThis()
    {
      println("Clicked ", name);
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

