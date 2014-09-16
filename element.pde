public class Element
{
  String name;
  int type;
  int index;
  
  int x;
  float realX;
  int y;
  float realY;
  int wid;
  float realWid;
  int hei;
  float realHei;
  
  float hSquish = 1.0;
  String fontString = ""; //this is a String for the font file to load.
  PFont font;
  int fontSize = 0;
  String colorString = "FFFFFF";
  color col = unhex("FFFFFFFF");
  
  boolean selected = false;
  boolean hovered = false;
  
  Element (String nn, int tt, int idx, int xx, int yy, int ww, int hh)
  {
   name = nn;
   type = tt;
   index = idx;
   x = xx;
   realX = x;
   y = yy;
   realY = y;
   wid = ww;
   realWid = wid;
   hei = hh;
   realHei = hei;
  }
  
  /**
   * Sets extra font variables if this is a text type element
   */
  void setFont(String fstr, int fsiz, float hsq, String cstr)
  {
    fontString = fstr;
    fontSize = fsiz;
    font = loadFont(fstr);
    hSquish = hsq;
    colorString = cstr;
    col = unhex("FF" + cstr);
  }
  
  void move( int dx, int dy )
  {
    realX += dx;
    realY += dy;
  }
  
  void updatePosition()
  {
    x = int(realX);
    y = int(realY);
    wid = int(realWid);
    hei = int(realHei);
  }
}
