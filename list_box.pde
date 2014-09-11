public void itemClicked ( int i, Object item )
{
    lastItemClicked = item;
}

public class Listbox
{
    PGraphics listPG;
    int x, y, listHeight;
    
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
    
    int pgHeight;
    int pgWidth;
    int listStartAt = 0;
    
    Listbox ( int xx, int yy, int ww, int hh, int ih, ArrayList<Element> e )
    {
        x = xx; y = yy;
        pgWidth = ww;
        pgHeight = hh;
        listPG = createGraphics(pgWidth, pgHeight);
        
        itemHeight = ih; itemWidth = pgWidth - scrolltabWidth;
        
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
    
    void drawList ()
    {  
        updatePosition();
        listPG.beginDraw();
        listPG.background(200);
        listPG.noStroke();
        listPG.fill( 100 );
        listPG.rect( 0 , 0 - scrollDist, pgWidth , listHeight );
        if ( items != null )
        {
            for ( int i = 0; i < items.size(); i++ )
            {
                listPG.stroke( 80 );
                listPG.fill( 200 );
                if (items.get(i).selected)
                {
                  listPG.fill( 255 );
                }
                else if(items.get(i).hovered)
                {
                  listPG.fill(215);
                }
                listPG.rect( 0, (i*itemHeight) - scrollDist, pgWidth, itemHeight );
                
                listPG.noStroke();
                listPG.fill( 0 );
                listPG.text( items.get(i+listStartAt).name, 25, (i+1)*(itemHeight) - 20 - scrollDist );
            }
        }
        
        //draw scrollbar
        listPG.stroke(80);
        listPG.fill(100);
        listPG.rect(itemWidth, 0, pgWidth, pgHeight);
        listPG.fill(200);
        listPG.rect(scrolltabX, scrolltabY, scrolltabWidth, scrolltabHeight);

        listPG.endDraw();
    }
    
    /**
     * update x position and list height in case window is resized
     */
    void updatePosition(){
      x = width - pgWidth;
      pgHeight = height - y - 100;
      updateMaxScrollDist();
      updateScrollTab();
      listPG = createGraphics(pgWidth, pgHeight);
    }
    
    void updateMaxScrollDist()
    {
      calculateListHeight();
      maxScrollDist = listHeight - pgHeight;
    }
    
    void calculateListHeight(){
      listHeight = itemHeight * items.size();
    }
    
    void updateScrollTab()
    {
      scrolltabHeight = int(float(pgHeight * pgHeight) / float(listHeight));
      scrolltabHeight = constrain(scrolltabHeight, 0, pgHeight);
      scrolltabX = itemWidth;
      scrolltabY = int(float(pgHeight * scrollDist) / float(listHeight)); //tabY is relative to listPG 
    }
    
    boolean handleMoved ( int mx, int my)
    {
      if(inArea(mx,my))
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
    
    boolean handleClicked ( int mx, int my)
    {
      if(inArea(mx,my))
      {
        if(inItem(mx,my))
        {
          selectItem(my);
        }
        else if(inScrollbar(mx,my))
        {
          clickScrollBar(my);
        }
        return true;
      }
      else
      {
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
    
    boolean inArea( int mx, int my)
    {
      boolean isInArea = (mx > x && mx < x + pgWidth && my > y && my < y + pgHeight);
      return isInArea; 
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

