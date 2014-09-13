import de.bezier.guido.*;

PGraphics buffer;
Listbox listbox;
ContentHandler content;
TemplateHandler template;
TemplateCanvas canvas;
Toolbar tools;
Object lastItemClicked;

float zoom = 0.6;

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
    canvas = new TemplateCanvas(template.elements, content.table, 200, 30, 675, 1050);
    tools = new Toolbar( width - 150 , 0 , 150 , 35 );
}

void draw ()
{
  buffer = createGraphics(width, height);
  buffer.clear();
  buffer.beginDraw();
  buffer.background( 75 );
  canvas.drawAll();
  tools.drawAll();
  
  listbox.drawList();
  
  image(listbox.listPG,listbox.x,listbox.y);

  buffer.image(canvas.drawPG,canvas.x,canvas.y,int(canvas.wid*zoom),int(canvas.hei*zoom));
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
  if (canvas.handleDragged(mouseX,mouseY,listbox.selectedItem)){
    
  }
}

void mouseReleased()
{
  canvas.handleReleased(mouseX,mouseY);
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
    zoom(1.25);
  }
  else if(key == '-')
  {
    zoom(0.8);
  }
}

void zoom(float zm)
{
  zoom *= zm;
  canvas.x += int(25 * ( zm - 1 ));
  canvas.y += int(25 * ( zm - 1 ));
  constrainOffsets();
}

void constrainOffsets()
{
  canvas.x = constrain(canvas.x , int(-0.8 * canvas.wid), width - 50);
  canvas.y = constrain(canvas.y , int(-0.8 * canvas.hei), height - 50);
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
  canvas.handleArrowPress( selectedId );
}

public void toggleDrawHighlights()
{
  canvas.toggleHighlight();
}

void toggleDrawContent()
{
  canvas.toggleContent();
}

void saveTemplate()
{
  template.saveTemplate();
}
