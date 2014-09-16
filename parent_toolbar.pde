public class Toolbar extends ParentPanel
{
  Toolbar(String nm, int xx, int yy, int ww, int hh )
  {
    name = nm; x = xx; y = yy; wid = ww; hei = hh;
    drawPG = createGraphics(wid, hei);
    addButtons();
  }
  
  void addButtons()
  {
    Button a = new Button( "Button A", 5, 5, 30, 25);
    addButton( a );
    Button b = new Button( "Button B", 40, 5, 30, 25);
    addButton( b );
    Button c = new Button( "Button C", 75, 5, 30, 25);
    addButton( c );
    Button d = new Button( "Button D", 110, 5, 30, 25);
    addButton( d );
  }
  
  void addButton( Button b )
  {
    childPanels.add( b );
  }
  
  void updateThis()
  {
    x = width - wid;
    drawPG.fill(200);
    drawPG.rect(0, 0, wid, hei);
  }
  
  void clickThis()
  {
    println("Clicked ", name);
  }
  
  void hoverThis()
  {
    println("Hovering on ", name);
  }
}
