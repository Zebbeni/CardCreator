import de.bezier.guido.*;

PGraphics bufferPG;
Listbox listbox;
ContentHandler content;
TemplateHandler template;
TemplateCanvas canvas;
Toolbar tools;
Interface mainInterface;

ArrayList<Element> elements;

void setup ()
{
    size(1000, 700);
    bufferPG = createGraphics(width, height);
    frameRate(30);
    frame.setResizable(true);
    
    // make the manager
    Interactive.make( this );
    
    // create a list box
    template = new TemplateHandler();
    
    elements = template.elements;
    
    listbox = new Listbox("element menu", width - 150 , 35 , 150 , 400 , 50 );
    content = new ContentHandler( );
    canvas = new TemplateCanvas("canvas", content.table, 200, 30, 675, 1050);
    tools = new Toolbar("toolbar", width - 150 , 0 , 150 , 35 );
    
    ArrayList<Panel> parentPanels = new ArrayList<Panel>();
    parentPanels.add(canvas);
    parentPanels.add(listbox);
    parentPanels.add(tools);
    
    mainInterface = new Interface("main interface", parentPanels);
}

void draw ()
{
  bufferPG = createGraphics(width, height);
  bufferPG.clear();
  bufferPG.beginDraw();
  mainInterface.refresh();
  
  bufferPG.endDraw();
  image(bufferPG,0,0);
}

void mouseMoved()
{
  if (listbox.handleMoved(mouseX,mouseY)){
    
  }
}

void mouseDragged()
{
  if (canvas.handleDragged(mouseX,mouseY,selectedElement)){
    
  }
}

void mouseReleased()
{
  mainInterface.click(mouseX,mouseY);
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
