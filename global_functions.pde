void zoom(float zm)
{
  zoom *= zm;
  canvas.x += int(25 * ( zm - 1 ));
  canvas.y += int(25 * ( zm - 1 ));
  canvas.wid = int(canvas.canvasWid * zoom);
  canvas.hei = int(canvas.canvasHei * zoom);
  constrainOffsets();
}

void constrainOffsets()
{
  canvas.x = constrain(canvas.x , int(-0.8 * canvas.wid), width - 50);
  canvas.y = constrain(canvas.y , int(-0.8 * canvas.hei), height - 50);
}

void addElement()
{
  Element e = new Element("New Element", IMG, elements.size(), 2, 2, 200, 250);
  elements.add(e);
  listbox.addItem(e);
  content.table.addColumn(e.name);
}

void removeElement()
{
  int selectedId = selectedElement;
  if (selectedId != NONE)
  {
    Element e = elements.get(selectedId);
    content.table.removeColumn(e.name);
    listbox.removeItem(e);
  }
}

void selectElement(Element e)
{
  if( selectedElement != NONE)
  {
    elements.get(selectedElement).selected = false;
  }
  e.selected = true;
  selectedElement = e.index;
}

void hoverElement(Element e)
{
  if( e == null )
  {
    if( hoveredElement != NONE)
    {
      elements.get(hoveredElement).hovered = false;
    }
    hoveredElement = NONE;
  }
  else
  {
    if( hoveredElement != NONE)
    {
      elements.get(hoveredElement).hovered = false;
    }
    e.hovered = true;
    hoveredElement = e.index;
  }
}

public void handleArrowPress(  )
{
  int selectedId = selectedElement;
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

public void itemClicked ( int i, Object item )
{
    lastItemClicked = item;
}
