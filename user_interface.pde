import de.bezier.guido.*;

PGraphics buffer;
Listbox listbox;
ContentHandler content;
TemplateHandler template;
TemplateDrawer drawer;
Toolbar tools;
Object lastItemClicked;

float time = 0.0;
float fade;

void setup ()
{
    size(1000, 700);
    buffer = createGraphics(width, height);
    frameRate(30);
    frame.setResizable(true);
    
    // make the manager
    Interactive.make( this );
    
    // create a list box
    template = new TemplateHandler();
    listbox = new Listbox( width - 150 , 35 , 150 , 400 , 50 , template.elements );
    content = new ContentHandler( );
    drawer = new TemplateDrawer(template.elements, content.table, 675, 1050);
    tools = new Toolbar( width - 150 , 0 , 150 , 35 );
}

void draw ()
{
  time = (time + 0.1) % (PI);
  fade = (sin(time) * 0.2) + 0.8;

  buffer = createGraphics(width, height);
  buffer.clear();
  buffer.beginDraw();
  buffer.background( 50 );
  drawer.drawAll();
  tools.drawAll();
  
  listbox.drawList();
  
  image(listbox.listPG,listbox.x,listbox.y);

  buffer.image(drawer.drawPG,drawer.x,drawer.y);
  buffer.image(tools.drawPG,tools.x,tools.y);
  buffer.image(listbox.listPG,listbox.x,listbox.y);
  buffer.endDraw();
  image(buffer,0,0);
}

void mousePressed ()
{
  if (listbox.handleClicked(mouseX,mouseY)){
    
  }
}

void mouseMoved()
{
  if (listbox.handleMoved(mouseX,mouseY)){
    
  }
}

void mouseDragged()
{
  if (drawer.handleDragged(mouseX,mouseY,listbox.selectedItem)){
    
  }
}

void mouseReleased()
{
  drawer.handleReleased(mouseX,mouseY);
}

void keyPressed ()
{
  if( key == 'a' )
  {
    addElement();
  }
  else if( keyCode == 8 )
  {
    println("delete clicked");
    removeElement();
  }
  else if ( key == 's' )
  {
    saveTemplate();
  }
  else if ( key == 'h' )
  {
    toggleDrawHighlights();
  }
  else if ( key == 'c' )
  {
    toggleDrawContent();
  }
  else if ( key == CODED )
  {
    if ( keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT)
    {
      handleArrowPress();
    }
  }
}

void keyReleased ()
{
  if(key == '=')
  {
    drawer.zoomIn();
  }
  else if(key == '-')
  {
    drawer.zoomOut();
  }
}

void addElement()
{
  Element e = new Element("New Element", IMG, 2, 2, 200, 250);
  listbox.addItem(e);
  content.table.addColumn(e.name);
}

void removeElement()
{
  int selectedId = listbox.selectedItem;
  if (selectedId != NONE)
  {
    Element e = listbox.items.get(selectedId);
    content.table.removeColumn(e.name);
    listbox.removeItem(e);
  }
}

public void handleArrowPress(  )
{
  int selectedId = listbox.selectedItem;
  drawer.handleArrowPress( selectedId );
}

public void toggleDrawHighlights()
{
  drawer.toggleHighlight();
}

void toggleDrawContent()
{
  drawer.toggleContent();
}

void saveTemplate()
{
  template.saveTemplate();
}
