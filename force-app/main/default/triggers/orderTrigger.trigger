/**
 * @name orderTrigger
 * @description calculate inventory quantities
**/
trigger orderTrigger on Order (
    after update
) {
    OrderHelper.AfterUpdate(Trigger.new, Trigger.old);
}