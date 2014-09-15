public class TemplateCanvas extends ParentPanel
{
  PGraphics fontPlacer;
  PImage cardPic;
  PFont drawFont;
  
  ArrayList<Element> elements;
  Table contents;
  
  int canvasWid;
  int canvasHei;
  
  int contentExample = 0;
  
  boolean doHighlight = true;
  boolean doContent = true;
  boolean isDragging = false;
  
  int[] resizing = {NONE,NONE}; //horizontal direction, vertical direction
  float widHeiRatio;
  float prevX2;
  float prevY2;
  
  int lastMX;
  int lastMY;
  
  TemplateCanvas (String nm, ArrayList<Element> e, Table conts, int xx, int yy, int canW, int canH)
  {
    name = nm; x = xx; y = yy; wid = int(canW * zoom); hei = int(canH * zoom);
    elements = e;
    canvasWid = canW;
    canvasHei = canH;
    contents = conts;
    drawPG = createGraphics(wid,hei);
  }
  
  public void updateThis()
  {
    wid = int(canvasWid * zoom);
    hei = int(canvasHei * zoom);
    drawCanvas();
    drawElements();
  }
  
  public void drawCanvas()
  {
    drawPG.fill(150);
    drawPG.rect(0, 0, wid, hei);
  }
  
  void drawElements()
  {
    for ( Element e : elements )
    {
      e.updatePosition();
      
      int cx = int(e.x * zoom);
      int cy = int(e.y * zoom);
      int cwid = int(e.wid * zoom);
      int chei = int(e.hei * zoom);
      
      drawPG.noStroke();
      if (doContent && contentExample != NONE)
      {
        drawContent(e , cx , cy , cwid , chei);
      }
      if (doHighlight)
      {
        drawHighlight(e , cx , cy , cwid , chei);
      }
      drawSelectBorder(e , cx , cy , cwid , chei);
    }
  }
  
  void drawHighlight( Element e , int cx , int cy , int cwid , int chei )
  {
    int alpha = 50;
    if ( e.hovered )
    {
      drawPG.fill(255,255,255,100);
    }
    else if ( e.type == IMG )
    {
      drawPG.fill(100,255,100,alpha);
    }
    else if ( e.type == TXT )
    {
      drawPG.fill(100,100,255,alpha);
    }
    drawPG.rect( int(e.x * zoom), int(e.y * zoom), int(e.wid * zoom), int(e.hei * zoom));
  }
  
  void drawContent( Element e , int cx , int cy , int cwid , int chei )
  {
    TableRow conRow = contents.getRow(contentExample);
    if ( e.type == IMG )
    {
      try {
        String imgFile = conRow.getString(e.name);
        cardPic = loadImage(imgFile);
        drawPG.image(cardPic, cx, cy, cwid, chei);
      } catch ( Exception ex ) {
      }
    }
    else if ( e.type == TEXT )
    {
      float hSquish = e.hSquish;
      fontPlacer = createGraphics(int(cwid/hSquish),chei);
      fontPlacer.beginDraw();
      fontPlacer.textFont(e.font);
      fontPlacer.textSize(constrain(e.fontSize * zoom,0,chei));
      fontPlacer.textAlign(LEFT,TOP);
      fontPlacer.fill(e.col);
      try {
        String textToPlace = conRow.getString(e.name);
        fontPlacer.text( textToPlace , 0 , 0 , int(cwid/hSquish) , chei);
      } catch ( Exception ex ) {
      }
      fontPlacer.endDraw();
      drawPG.image( fontPlacer.get() , cx , cy , cwid, chei);
    }
  }
  
  void drawSelectBorder( Element e , int cx , int cy , int cwid , int chei )
  {
    if ( e.selected )
    {
      drawPG.stroke(200);
      drawPG.strokeWeight(2);
      drawPG.fill(255,255,255,50);
      if( isDragging )
      {
        drawPG.stroke(200,200,200,255);
        drawPG.strokeWeight(1);
        drawPG.fill(255,255,255,100);
      }
      drawPG.rect( cx, cy, cwid, chei);
    }
  }
  
  boolean handleDragged(int mx, int my , int selectedId)
  {
    if (selectedId != NONE)
    {
      if (resizing[0] != NONE || resizing[1] != NONE)
      {
        resizeElement(elements.get(selectedId) , mx, my );
      }
      else if ( isDragging )
      {
        dragElement(elements.get(selectedId), mx, my);
      }
      else
      {
        setResizing(elements.get(selectedId), mx, my);
        if(resizing[0] != NONE || resizing[1] != NONE)
        {
          beginResizing(elements.get(selectedId), mx, my);
        }
        else 
        {
          beginDragging(mx, my);
          isDragging = true;
        }
      }
    }
    else if( isDragging )
    {
      dragCanvas(mx,my);
    }
    else
    {
      beginDragging(mx, my);
    }
    return isDragging;
  }
  
  void beginResizing(Element e, int mx, int my)
  {
    widHeiRatio = e.realWid/e.realHei; //keep in mind in case user hits SHIFT
    prevX2 = e.realX + e.realWid;
    prevY2 = e.realY + e.realHei;
    beginDragging(mx,my);
  }
  
  void beginDragging(int mx, int my)
  {
    isDragging = true;
    resetLastMouse(mx,my);
  }
  
  void resizeElement(Element e , int mx, int my )
  {
    if(resizing[1] == BORDER_TOP)
    {
      e.realY += (my - lastMY);
      e.realHei -= (my - lastMY);
      if(keyPressed && keyCode == SHIFT)
      {
          e.realWid = e.realHei * widHeiRatio;
          e.realY = prevY2 - e.realHei;
      }
    }
    else if(resizing[1] == BORDER_BOTTOM)
    {
      e.realHei += (my - lastMY);
      if(keyPressed && keyCode == SHIFT)
      {
        e.realWid = e.realHei * widHeiRatio;
      }
    }
    
    if(resizing[0] == BORDER_RIGHT)
    {
      e.realWid += (mx - lastMX);
      if(keyPressed && keyCode == SHIFT)
      {
        e.realHei = e.realWid / widHeiRatio;
      }
    }
    else if(resizing[0] == BORDER_LEFT)
    {
      e.realX += (mx - lastMX);
      e.realWid -= (mx - lastMX);
      if(keyPressed && keyCode == SHIFT)
      {
        e.realHei = e.realWid / widHeiRatio;
        e.realX = prevX2 - e.realWid;
      }
    }
    resetLastMouse(mx,my);
    e.realWid = constrain(e.realWid, 3, 3000);
    e.realHei = constrain(e.realHei, 3, 3000);
    println("e.realWid = ", e.realWid, " e.realHei = ", e.realHei);
  }
  
  void dragCanvas(int mx, int my)
  {
    x += (mx - lastMX);
    y += (my - lastMY);
    resetLastMouse(mx,my);
    constrainOffsets();
  }
  
  void dragElement(Element e, int mx, int my)
  {
    e.realX += (mx - lastMX);
    e.realY += (my - lastMY);
    resetLastMouse(mx,my);
  }
  
  void resetLastMouse(int mx, int my)
  {
    lastMX = mx;
    lastMY = my;
  }
  
  void clickThis()
  {
    if( isDragging )
    {
      isDragging = false;
      resizing[0] = NONE;
      resizing[1] = NONE;
    }
    else
    {
      println("Clicked ", name);
    }
  }
  
  void handleArrowPress(int selectId)
  {
    if(selectId != NONE)
    {
      Element e = elements.get(selectId);
      if(keyCode == UP)
      {
        e.move(0, -1 * ceil( move_step ) ); 
        println("moving up");
      }
      else if(keyCode == DOWN)
      {
        e.move(0, ceil(move_step ));
      }
      else if(keyCode == LEFT)
      {
        e.move( -1 * ceil(move_step ) , 0);
      }
      else
      {
        e.move( ceil(move_step ) , 0);
      }
    }
    else if(doContent)
    {
      if(keyCode == LEFT)
      {
        contentExample = (contentExample + contents.getRowCount() -1) % contents.getRowCount();
      }
      else if(keyCode == RIGHT)
      {
        contentExample = (contentExample + 1) % contents.getRowCount();
      }
    }
  }
  
  void setResizing( Element e, int mx, int my)
  {
    resizing[0] = NONE;
    resizing[1] = NONE;
    
    int dispX = int(e.x * zoom);
    int dispY = int(e.y * zoom);
    int dispW = int(e.wid * zoom);
    int dispH = int(e.hei * zoom);
    
    if( abs(mx - dispX) < border_select_width)
    {
      resizing[0] = BORDER_LEFT;
    }
    else if( abs(mx - (dispX + dispW)) < border_select_width )
    {
      resizing[0] = BORDER_RIGHT;
    }
    
    if( abs(my - dispY) < border_select_width)
    {
      resizing[1] = BORDER_TOP;
    }
    else if( abs(my - (dispY + dispH)) < border_select_width )
    {
      resizing[1] = BORDER_BOTTOM;
    }
  }
  
  void toggleHighlight()
  {
    doHighlight = !doHighlight;
  }
  
  void toggleContent()
  {
    doContent = !doContent;
  }
}
