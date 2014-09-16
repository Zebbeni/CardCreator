public class Interface extends ParentPanel
{
  
  Interface(String nm , ArrayList<Panel> panels)
  {
    name = nm; x = 0; y = 0; wid = width; hei = height;
    drawPG = createGraphics(wid, hei);
    childPanels = panels;
  }
  
  public void refresh()
  {
    updateDrawPG();
    drawToBuffer( bufferPG );
  }
  
  void updateThis()
  {
    wid = width;
    hei = height;
    drawPG.background(100);
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
