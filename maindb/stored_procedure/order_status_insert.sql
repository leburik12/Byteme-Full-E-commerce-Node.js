CREATE OR REPLACE PROCEDURE order_status_insert ()
AS $$
LANGUAGE plpgsql
BEGIN 
    INSERT INTO order_status (osname, descr, is_active)
    VALUES ('Pending', 'Order received and awaiting processing', TRUE);

    INSERT INTO order_status (osname, descr, is_active)
    VALUES ('In Progress', 'Order is being processed', TRUE);

    INSERT INTO order_status (osname, descr, is_active)
    VALUES ('Shipped', 'Order has been shipped', TRUE);

    INSERT INTO order_status (osname, descr, is_active)
    VALUES ('Delivered', 'Order has been delivered to the customer', TRUE);

    INSERT INTO order_status (osname, descr, is_active)
    VALUES ('Cancelled', 'Order has been cancelled', FALSE);
END;
$$;