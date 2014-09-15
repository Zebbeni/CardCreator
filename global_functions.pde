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

public void itemClicked ( int i, Object item )
{
    lastItemClicked = item;
}
