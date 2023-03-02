public class LoadDataProducts {
    public static void execute(){
        List<Product2> products = new List<Product2>();
        List<PricebookEntry> entries = new List<PricebookEntry>();
        
        products.add(new Product2(Name='Pizza',Family='Entree',Initial_Inventory__c=25,Quantity_Ordered__c=0,IsActive=true));
        products.add(new Product2(Name='Garlic Bread',Family='Side',Initial_Inventory__c=20,Quantity_Ordered__c=0,IsActive=true));
        products.add(new Product2(Name='Chocolate Cake',Family='Dessert',Initial_Inventory__c=15,Quantity_Ordered__c=0,IsActive=true));
        products.add(new Product2(Name='Coconut Water',Family='Beverage',Initial_Inventory__c=10,Quantity_Ordered__c=0,IsActive=true));
        products.add(new Product2(Name='Hamburger',Family='Entree',Initial_Inventory__c=25,Quantity_Ordered__c=0,IsActive=true));
        products.add(new Product2(Name='French Fries',Family='Side',Initial_Inventory__c=20,Quantity_Ordered__c=0,IsActive=true));
        products.add(new Product2(Name='Carrot Cake',Family='Dessert',Initial_Inventory__c=15,Quantity_Ordered__c=0,IsActive=true));
        products.add(new Product2(Name='Lemonade',Family='Beverage',Initial_Inventory__c=10,Quantity_Ordered__c=0,IsActive=true));
        products.add(new Product2(Name='Hot Dog',Family='Entree',Initial_Inventory__c=25,Quantity_Ordered__c=0,IsActive=true));
        products.add(new Product2(Name='Onion Rings',Family='Side',Initial_Inventory__c=20,Quantity_Ordered__c=0,IsActive=true));
        products.add(new Product2(Name='Jello',Family='Dessert',Initial_Inventory__c=15,Quantity_Ordered__c=0,IsActive=true));
        products.add(new Product2(Name='Iced Tea',Family='Beverage',Initial_Inventory__c=10,Quantity_Ordered__c=0,IsActive=true));
                        
        insert(products);
        System.debug(products);
        
        Pricebook2 priceBook = [SELECT Id,Name FROM Pricebook2 WHERE Name = 'Standard Price Book'];
        
        Map<String,Decimal> prices = new Map<String,Decimal>();
        prices.put('Pizza',20);
		prices.put('Garlic Bread',6);
		prices.put('Chocolate Cake',5);
		prices.put('Coconut Water',3);
        prices.put('Hamburger',20);
        prices.put('French Fries',6);
        prices.put('Carrot Cake',5);
        prices.put('Lemonade',3);
        prices.put('Hot Dog',10);
        prices.put('Onion Rings',6);
        prices.put('Jello',2.5);
        prices.put('Iced Tea',3);
        
        for(Integer x=0;x<products.size();x++){
            Product2 prod = products.get(x);
            entries.add(new PricebookEntry(Product2Id=prod.Id,Pricebook2Id=priceBook.Id,
                                          UnitPrice=prices.get(prod.Name),IsActive=true));
            
            
        }
                
        insert(entries);
        System.debug(entries);
    }
}