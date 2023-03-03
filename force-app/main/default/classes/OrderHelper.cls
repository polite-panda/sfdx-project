public with sharing class OrderHelper {

    /**
     * @name AfterUpdate
     * @description 
     * @param List<Order> newList
     * @param List<Order> oldList
     * @return void
    **/
    public static void AfterUpdate(List<Order> newList, List<Order> oldList){
        Set<Id> orderIds = new Set<Id>();
        for ( Integer i=0; i<newList.size(); i++ ){
            // if ( newList[i].Status == 'Activation' && oldList[i].Status != 'Activate' ){
            if(newList[i].Status == Constants.ACTIVATED_ORDER_STATUS &&
                oldList[i].Status != Constants.ACTIVATED_ORDER_STATUS){
                orderIds.add(newList[i].Id);
            }
        }

        RollUpOrderItems(orderIds);
    }

    /**
     * @name RollUpOrderItems
     * @description Given a set of Activated Order ids, query the child Order Items and related Products to calculate Inventory levels
     * @param Set<Id> activatedOrderIds
     * @return void
    **/
    public static void RollUpOrderItems(Set<Id> activatedOrderIds){
        //ToDo: Declare a Map named "productMap" of Ids to Product2 records
        Map<Id,Product2> productMap = new Map<Id,Product2>();
        //ToDo: Loop through a query of OrderItems related to the activatedOrderIds        
        for(OrderItem item : [SELECT Id,Product2Id,Product2.Name,Product2.Quantity_Ordered__c
                                FROM OrderItem 
                                WHERE OrderId IN :activatedOrderIds]){
            //ToDo: Populate the map with the Id of the related Product2 as the key and Product2 record as the value
            Product2 product = new Product2(Id=item.Product2Id,
                                            Name=item.Product2.Name,
                                            Quantity_Ordered__c=item.Product2.Quantity_Ordered__c);
            productMap.put(product.Id,product);
        }
        //ToDo: Loop through a query that aggregates the OrderItems related to the Products in the ProductMap keyset
        AggregateResult[] groupedResults = [SELECT Product2Id,SUM(Quantity) 
                                            FROM OrderItem 
                                            WHERE OrderId IN :activatedOrderIds 
                                                AND Product2Id IN :productMap.keyset()
                                            GROUP BY Product2Id];

        for(AggregateResult  item : groupedResults){
            //ToDo: Perform an update on the records in the productMap
            Product2 product = productMap.get(String.valueOf(item.get('Product2Id')));
            product.Quantity_Ordered__c += Decimal.valueOf(String.valueOf(item.get('expr0')));
            productMap.put(product.Id,product);
        }
        
        update(productMap.values());
    }

}