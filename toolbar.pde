public class Toolbar
{
  int x;
  int y;
  int wid;
  int hei;
  PGraphics drawPG;
  
  ArrayList<Button> buttons;
  
  Toolbar( int xx, int yy, int ww, int hh )
  {
    x = xx;
    y = yy;
    wid = ww;
    hei = hh;
    buttons = new ArrayList();
    drawPG = createGraphics(wid, hei);
    addButtons();
  }
  
  void addButtons()
  {
    Button a = new Button( 5, 5, 30, 25, drawPG);
    addButton( a );
    Button b = new Button( 40, 5, 30, 25, drawPG);
    addButton( b );
    Button c = new Button( 75, 5, 30, 25, drawPG);
    addButton( c );
    Button d = new Button( 110, 5, 30, 25, drawPG);
    addButton( d );
  }
  
  void addButton( Button b )
  {
    buttons.add(b);
  }
  
  void drawAll()
  {
    updatePosition();
    drawPG.beginDraw();
    drawPG.fill(200);
    drawPG.rect(0, 0, wid, hei);
    for (Button b : buttons)
    {
      b.drawButton();
    }
    drawPG.endDraw();
  }
  
  void updatePosition()
  {
    x = width - wid;
  }
}
