select
  shoppingcart_orderitem.status, unit_cost, course_id, user_id
from
  shoppingcart_orderitem, shoppingcart_certificateitem
where
 shoppingcart_certificateitem.orderitem_ptr_id = shoppingcart_orderitem.id and status='purchased' limit 5;

select 
  sum(unit_cost) as cost, course_id as cid1
from 
  shoppingcart_orderitem, shoppingcart_certificateitem 
where 
  shoppingcart_certificateitem.orderitem_ptr_id = shoppingcart_orderitem.id and status='purchased' group by course_id;

select 
  count(*) as cert_count, course_id as cid2 
from 
  certificates_generatedcertificate 
where 
  certificates_generatedcertificate.status = 'downloadable'
group by 
  certificates_generatedcertificate.course_id;


select 
  min_cost, max_cost, total, cert_count, cid1 
from 
  (select min(unit_cost) as min_cost, max(unit_cost) as max_cost, sum(unit_cost) as total, course_id as cid1 from shoppingcart_orderitem, shoppingcart_certificateitem where shoppingcart_certificateitem.orderitem_ptr_id = shoppingcart_orderitem.id and status='purchased' group by course_id) as a, 
  (select count(*) as cert_count, course_id as cid2 from certificates_generatedcertificate where certificates_generatedcertificate.status = 'downloadable' group by certificates_generatedcertificate.course_id) as b 
where a.cid1 = b.cid2;
