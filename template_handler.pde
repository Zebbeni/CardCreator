public class TemplateHandler
{
  Table tempTable;
  ArrayList<Element> elements;
  
  TemplateHandler ( ) 
  {
    elements = new ArrayList<Element>();
    getTemplate();
  }
  
  /**
   * Looks in the data directory for a template file.
   * Passes this to get Template elements to load.
   * 
   * TODO: have this search intelligently for previously
   *       created template files, not just template.csv
   */
  void getTemplate()
  {
    getTemplateElements("template.csv");
  }
  
  void saveTemplate()
  {
    Table newTable = createTemplate();
    for ( Element e : elements )
    {
      TableRow newRow = newTable.addRow();
      newRow.setString("element", e.name);
      if(e.type == TXT)
      {
        newRow.setString("type", "text");
      }
      else if(e.type == IMG)
      {
        newRow.setString("type", "image");
      }
      newRow.setInt("x", e.x);
      newRow.setInt("y", e.y);
      newRow.setInt("w", e.wid);
      newRow.setInt("h", e.hei);
      newRow.setString("font", e.fontString);
      newRow.setInt("fontsize", e.fontSize);
      newRow.setFloat("hSquish", e.hSquish);
      newRow.setString("colorHex", e.colorString);
    }
    saveTable(newTable, "data/template.csv");
  }
  
  Table createTemplate()
  {
    Table nTable = new Table();
    nTable.addColumn("element");
    nTable.addColumn("type");
    nTable.addColumn("x");
    nTable.addColumn("y");
    nTable.addColumn("w");
    nTable.addColumn("h");
    nTable.addColumn("font");
    nTable.addColumn("fontsize");
    nTable.addColumn("hSquish");
    nTable.addColumn("colorHex");
    return nTable;
  }
  
  /**
   * Reads a template file and stores the element names 
   * in an ArrayList called 'elements'. All info goes in
   * Table 'tempTable'
   *
   * @param filename name of template file to open
   */
  void getTemplateElements(String filename)
  {  
    tempTable = loadTable(filename, "header");
    
    for (TableRow row : tempTable.rows()) 
    {
      
      String name = getElemName(row.getString("element"));
      int type = getType(row.getString("type"));
      int x = getX(row.getString("x"));
      int y = getY(row.getString("y"));
      int w = getHei(row.getString("w"));
      int h = getWid(row.getString("h"));
      
      Element e = new Element(name, type, x, y, w, h);
      
      if (type == TXT)
      {
        String font = getFont(row.getString("font"));
        int fontSize = getFontSize(row.getString("fontsize"));
        float hSquish = getHSquish(row.getString("hSquish"));
        String col = getColor(row.getString("colorHex"));
        e.setFont(font, fontSize, hSquish, col);
      }
      
      elements.add(e);
    }
  }
  
  /**
   * Input functions
   * These sanitize messed-up data in template.csv
   * and return correct (or default) values
   *
   * @param element attribute string
   */  
  String getElemName(String ss)
  {
    String name = ss;
    if ( name.equals("") ) //if given a blank name
    {
      name = "New Element"; //set name as 'New Element'
    }
    return name;
  }
  
  int getType(String t)
  {
    int type = IMG;
    if( t.equals("text"))
    {
      type = TXT;
    }
    else if( t.equals("image"))
    {
      type = IMG;
    }
    return type;
  }
   
  int getX(String xx)
  {
    int x = 0;
    try {
      x = int(xx);
    } catch (Exception e) {
      println("Expected an integer value for x. Got ", xx);
    }
    return x;
  }
  
  int getY(String yy)
  {
    int y = 0;
    try {
      y = int(yy);
    } catch (Exception e) {
      println("Expected an integer value for y. Got ", yy);
    }
    return y;
  }
  
  int getWid(String ww)
  {
    int wid = 50;
    try {
      wid = int(ww);
    } catch (Exception e) {
      println("Expected an integer value for w. Got ", ww);
    }
    if(wid <= 0) //set to minimum value
    {
      wid = 5;
    }
    return wid;
  }
  
  int getHei(String hh)
  {
    int hei = 50;
    try {
      hei = int(hh);
    } catch (Exception e) {
      println("Expected an integer value for h. Got ", hh);
    }
    if(hei <= 0)
    {
      hei = 5; //set to minimum value
    }
    return hei;
  }

  String getFont(String f)
  {
    String font = f;
    try {
      PFont test = loadFont(font);
    } catch (Exception e) {
      println("Unable to find the font", f, "in the data folder. Add it in Processing by going to Tools > CreateFont");
    }
    return font;
  }
  
  int getFontSize(String fsiz)
  {
    int fontSize = 15;
    try {
      fontSize = int(fsiz);
    } catch (Exception e) {
      println("Expected an integer value for fontsize. Got ", fsiz);
    }
    return fontSize;
  }
  
  float getHSquish(String hs)
  {
    float hSquish = 1;
    try {
      hSquish = float(hs);
    } catch (Exception e) {
      println("Expected a decimal or blank value for hSquish. Got ", hs);
    }
    if( Float.isNaN(hSquish) || hSquish <= 0 ) //if hSquish is not a number or <= 0
    {
      hSquish = 1; //set to default value
    }
    return hSquish;
  }
  
  String getColor(String chex)
  {
    String col = "FFFFFF";
    try {
      col = chex;
      color test = unhex("FF" + col); //assumes an alpha value of 100%
    } catch (Exception e) {
      println("Expected a hex value like BBFF3D for colorHex. Got ", chex);
    }
    return col;
  }
}
