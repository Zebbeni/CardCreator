public class ContentHandler
{
  Table table;
  
  ContentHandler ( )
  {
    getContent();
  }
  
  void getContent()
  {
    getContentTable("content.csv");
  }
  
  void getContentTable( String filename )
  {
    table = loadTable(filename, "header");
  }
  
}
