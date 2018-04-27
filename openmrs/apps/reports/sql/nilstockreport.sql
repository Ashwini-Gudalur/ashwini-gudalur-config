SELECT ROW_NUMBER() OVER (ORDER BY pt.name) as "Sl No",sl.name as Location,pt.name as Product_Name,
	SUM(CASE WHEN srp.qty<0 then '0.000'
    ELSE CAST((srp.qty)AS DECIMAL(10,3))
	END) AS Stock
FROM stock_report_prodlots srp 
RIGHT JOIN product_template pt on pt.id=srp.product_id
INNER JOIN stock_location sl ON sl.id = srp.location_id
WHERE 	srp.location_id IN (14,15,59)
AND srp.product_id  not in (3087,2138)
GROUP BY sl.name,pt.name,srp.product_id
HAVING 
	SUM(CASE WHEN srp.qty<0 then '0.000'
    ELSE CAST((srp.qty) AS DECIMAL(10,3))
	END) = 0
ORDER BY pt.name;

