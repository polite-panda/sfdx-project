public class Product2Extension {

    class ProductWrapper {
        Product2 productRecord;
        PriceBookEntry pricebookEntryRecord;
    }

    public List<Product2> productsToInsert {get;set;}

    public Product2Extension(){
        productsToInsert = new List<Product2>();
        addRows();
    }

    public List<SelectOption> GetFamilyOptions(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption(Constants.SELECT_ONE,Constants.SELECT_ONE));
        for(Schema.PicklistEntry entry : Constants.PRODUCT_FAMILY){
            options.add(new SelectOption(entry.getLabel(),entry.getValue()));
        }
        return options;
    }

    public void AddRows(){
        for ( Integer i=0; i<Constants.DEFAULT_ROWS; i++ ){
            productsToInsert.add( new Product2() );
        }
    }

    public List<ChartHelper.ChartData> GetInventory(){
        return ChartHelper.GetInventory();
    }

    public PageReference Save(){
        try {
            insert productsToInsert;

            //If successful clear the list and display an informational message
            apexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,productsToInsert.size()+' Inserted'));
            productsToInsert.clear();   //Do not remove
            addRows();  //Do not remove
        } catch (Exception e){

        }
        return null;
    }

}