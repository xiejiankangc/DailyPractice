//进入服务器 d:\PostgreSQL14\bin\psql.exe -U postgres //退出psql \q //进入shop数据库 d:\PostgreSQL14\bin\psql.exe -U postgres -d shop //创建Product表，代码清单1-2

CREATE TABLE Product (product_id CHAR(4) NOT NULL, product_name VARCHAR(100) NOT NULL, product_type VARCHAR(32) NOT NULL, sale_price INTEGER NOT NULL, purchase_price INTEGER , regist_date DATE , PRIMARY KEY (product_id)); //删除Product表，代码清单1-3

DROP TABLE Product; //添加一列可以存储100位的可变长字符串的product_name_pinyin列 ALTER TABLE Product ADD COLUMN product_name_pinyin VARCHAR(100); ALTER TABLE 表名 ADD COLUMN 列的定义 //表的更新 //添加列的alter table语句 ALTER TABLE Product ADD COLUMN <列的定义>; //删除列的alter table语句 ALTER TABLE Product

DROP COLUMN product_name_pinyin; //向Product表中插入数据的SQL语句，代码清单1-6 BEGIN transaction;
INSERT INTO Product VALUES ('0001', 'T恤衫', '衣服', 1000, 500, '2009-09-20');
INSERT INTO Product VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
INSERT INTO Product VALUES ('0003', '运动T恤', '衣服', 4000, 2800, NULL);
INSERT INTO Product VALUES ('0004', '菜刀', '厨房用具', 3000, 2800, '2009-09-20');
INSERT INTO Product VALUES ('0005', '高压锅', '厨房用具', 6800, 5000, '2009-01-15');
INSERT INTO Product VALUES ('0006', '叉子', '厨房用具', 500, NULL, '2009-09-20');
INSERT INTO Product VALUES ('0007', '擦菜板', '厨房用具', 880, 790, '2008-04-28');
INSERT INTO Product VALUES ('0008', '圆珠笔', '办公用品', 100, NULL, '2009-11-11'); COMMIT;

SELECT  product_id     AS id
       ,product_name   AS name
       ,purchase_price AS price
FROM product;

SELECT  product_id    AS id
       ,product_name  AS name
       ,product_price AS price
FROM product
SELECT  product_id AS "编号"
FROM product;

SELECT  '商品'         AS defultstring
       ,'38'         AS defultnumber
       ,'2009-02-24' AS date
       ,product_id
       ,product_name
FROM product;

SELECT  DISTINCT product_type
       ,regist_date
FROM product;
--这是一行的注释 /* 这是多行的， 注释 */
SELECT  DISTINCT product_type --注释还可以这样插，在SQL语句中插入
FROM product;

SELECT  DISTINCT product_type /* 同理多行注释 也可以这样插入 */
FROM product;

SELECT  product_name
       ,sale_price
       ,sale_price * 2 AS "价格 x 2"
FROM product;

SELECT  product_name
       ,sale_price
       ,purchase_price
FROM product
WHERE sale_price - purchase_price >=500;

CREATE TABLE Chars (chr char(3) NOT NULL, PRIMARY KEY (chr)); BEGIN transaction;
INSERT INTO Chars VALUES ('1');
INSERT INTO Chars VALUES ('2');
INSERT INTO Chars VALUES ('3');
INSERT INTO Chars VALUES ('10');
INSERT INTO Chars VALUES ('11');
INSERT INTO Chars VALUES ('222'); COMMIT;

SELECT  product_name
       ,sale_price
FROM product
WHERE NOT sale_price>=1000
AND product_name='打孔器';

SELECT  product_name
       ,product_type
       ,regist_date
FROM product
WHERE product_type='办公用品'
AND regist_date='2009-09-11' OR regist_date = '2009-09-20';

SELECT  DISTINCT product_type
FROM product ;

SELECT  product_type
FROM product
GROUP BY  product_type;

SELECT  product_type
       ,COUNT(*)
FROM product
GROUP BY  product_type
HAVING COUNT(1)=2;

SELECT  product_id
FROM product
ORDER BY product_name;

SELECT  product_type
       ,COUNT(1)
FROM product
GROUP BY  product_type
ORDER BY COUNT(1) DESC;

CREATE VIEW productsum (product_type, cnt_product) AS
SELECT  product_type
       ,COUNT(1)
FROM product
GROUP BY  product_type;

SELECT  product_type
       ,cnt_product
FROM productsum;

CREATE VIEW productsumjim(product_type_2, cnt_product_2) AS
SELECT  product_type
       ,cnt_product
FROM productsum
WHERE product_type='办公用品';

SELECT  product_type_2
       ,cnt_product_2
FROM productsumjim;

SELECT  product_id
       ,product_name
       ,sale_price
FROM product
WHERE sale_price > (
SELECT  AVG(sale_price)
FROM product);

SELECT  product_id
       ,product_name
       ,sale_price
       ,(
SELECT  AVG(sale_price)
FROM product) AS avg1
FROM product;

SELECT  product_type
       ,product_name
       ,AVG(sale_price)
FROM product
GROUP BY  product_type
         ,product_name
HAVING AVG(sale_price) > (
SELECT  AVG(sale_price)
FROM product) ;

SELECT  product_type
       ,product_name
       ,sale_price
FROM product AS t1
WHERE sale_price > (
SELECT  AVG(sale_price)
FROM product AS t2
WHERE t1.product_type = t2.product_type) ;

CREATE VIEW viewpractice5_1(product_name, sale_price, regist_date) AS
SELECT  product_name
       ,sale_price
       ,regist_date
FROM product
WHERE sale_price >= 1000
AND regist_date='2009-09-20';

SELECT  *
FROM viewpractice5_1;

SELECT  product_id
       ,product_name
       ,product_type
       ,sale_price
       ,(
SELECT  AVG(sale_price)
FROM product) AS sale_price_all
FROM product ;

CREATE VIEW avgpricebytype AS
SELECT  product_id
       ,product_name
       ,product_type
       ,sale_price
       ,(
SELECT  AVG(sale_price)
FROM product AS t2
WHERE t1.product_type = t2.product_type)
FROM product AS t1;

SELECT  *
FROM avgpricebytype; str1 || str2

SELECT  product_id
       ,substring('xiejianhhh'
FROM 2 FOR 2)
FROM product;

SELECT  product_name
       ,coalesce(regist_date,CURRENT_DATE)
FROM product;

CREATE TABLE samplelike(strcol varchar(6) NOT NULL, PRIMARY key(strcol)); BEGIN transaction;
INSERT INTO SampleLike (strcol) VALUES ('abcddd');
INSERT INTO SampleLike (strcol) VALUES ('dddabc');
INSERT INTO SampleLike (strcol) VALUES ('abdddc');
INSERT INTO SampleLike (strcol) VALUES ('abcdd');
INSERT INTO SampleLike (strcol) VALUES ('ddabc');
INSERT INTO SampleLike (strcol) VALUES ('abddc'); COMMIT;

SELECT  product_name
       ,sale_price
FROM product
WHERE sale_price BETWEEN 800 AND 1000;

SELECT  product_name
       ,purchase_price
FROM product
WHERE purchase_price IS NULL;

SELECT  product_name
       ,purchase_price
FROM product
WHERE purchase_price IS NOT NULL;

CREATE TABLE ShopProduct (shop_id CHAR(4) NOT NULL, shop_name VARCHAR(200) NOT NULL, product_id CHAR(4) NOT NULL, quantity INTEGER NOT NULL, PRIMARY KEY (shop_id, product_id)); BEGIN TRANSACTION;
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000A', '东京', '0001', 30);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000A', '东京', '0002', 50);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000A', '东京', '0003', 15);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0002', 30);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0003', 120);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0004', 20);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0006', 10);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000B', '名古屋', '0007', 40);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '大阪', '0003', 20);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '大阪', '0004', 50);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '大阪', '0006', 90);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000C', '大阪', '0007', 70);
INSERT INTO ShopProduct (shop_id, shop_name, product_id, quantity) VALUES ('000D', '福冈', '0001', 100); COMMIT;

SELECT  product_name
       ,sale_price
FROM product
WHERE product_id IN ( SELECT product_id FROM ShopProduct WHERE shop_name='大阪');

SELECT  product_name
       ,sale_price
FROM product
WHERE product_id NOT IN ( SELECT product_id FROM ShopProduct WHERE shop_name='东京');

SELECT  product_name
       ,sale_price
FROM product AS P
WHERE EXISTS (
SELECT  1
FROM ShopProduct AS SP
WHERE shop_name='大阪'
AND P.product_id = sp.product_id);

SELECT  product_name
       ,sale_price
FROM product AS P
WHERE EXISTS (
SELECT  product_type
FROM ShopProduct AS SP
WHERE shop_name='大阪'
AND P.product_id = sp.product_id); CASE WHEN <求值表达式1> THEN <表达式> WHEN 求值表达式2 THEN 表达式 WHEN 求值表达式3 THEN 表达式 · · · ELSE 表达式 END

SELECT  product_name
       ,CASE WHEN product_type ='衣服' THEN 'A:'||product_type
             WHEN product_type ='办公用品' THEN 'B:'||product_type
             WHEN product_type ='厨房用具' THEN 'C:'||product_type  ELSE NULL END
FROM product;

SELECT  product_type
       ,SUM(sale_price)
FROM product
GROUP BY  product_type;

SELECT  SUM(CASE WHEN product_type='衣服' THEN sale_price ELSE 0 END)   AS sum_price_clothes
       ,SUM(CASE WHEN product_type='办公用品' THEN sale_price ELSE 0 END) AS sum_price_office
       ,SUM(CASE WHEN product_type='厨房用具' THEN sale_price ELSE 0 END) AS sum_price_chicken
FROM product;

SELECT  product_name
       ,CASE product_type WHEN '衣服' THEN 'A:'||product_type WHEN '办公用品' THEN 'B:'||product_type WHEN '厨房用具' THEN 'C:'||product_type ELSE NULL END
FROM product;

SELECT  product_name
       ,purchase_price
FROM Product
WHERE purchase_price NOT IN (500, 2800, 5000);

SELECT  product_name
       ,purchase_price
FROM Product
WHERE purchase_price NOT IN (500, 2800, 5000, NULL);

SELECT  product_name
       ,purchase_price
FROM Product
WHERE purchase_price IN (500, 2800, 5000, NULL);
--sql1
SELECT  a
FROM TABLE
WHERE a IN (1);
--sql2
SELECT  a
FROM TABLE
WHERE a not IN (1);
--sql3
SELECT  a
FROM TABLE
WHERE a IN (1, null);
--sql4
SELECT  a
FROM TABLE
WHERE a not IN (1, null);

SELECT  product_name
       ,purchase_price
FROM product
WHERE purchase_price is null
AND purchase_price IN (1, null);

SELECT  product_name
       ,purchase_price
FROM product
WHERE purchase_price is null ;

CREATE TABLE test_in (test char(3), name VARCHAR(200) NOT NULL, PRIMARY KEY (name)); BEGIN transaction;
INSERT INTO test_in(test, name) VALUES ('1', 'a');
INSERT INTO test_in VALUES ('2', 'b');
INSERT INTO test_in VALUES (null, 'c'); COMMIT;

SELECT  *
FROM test_in
WHERE test IN ('1');

SELECT  *
FROM test_in
WHERE test not IN ('1');

SELECT  *
FROM test_in
WHERE test IN ('1', null);

SELECT  *
FROM test_in
WHERE test not IN ('1', null);

SELECT  *
FROM test_in
WHERE test IN (null);

SELECT  *
FROM test_in
WHERE test is null;

SELECT  *
FROM test_in
WHERE test = null;

SELECT  sum ( CASE WHEN sale_price<=1000 THEN 1 ELSE 0 END)                AS low_price
       ,SUM(CASE WHEN sale_price BETWEEN 1001 AND 3000 THEN 1 ELSE 0 END ) AS mid_price
       ,SUM(CASE WHEN sale_price >= 3001 THEN 1 ELSE 0 END)                AS high_price
FROM product ; < 窗口函数 > over
( [partition by <列清单>]
	ORDER BY <排序用列清单>
);

SELECT  product_name
       ,product_type
       ,sale_price
       ,rank() over ( ORDER BY sale_price) AS rank
FROM product;

SELECT  product_name
       ,product_type
       ,sale_price
       ,dense_rank() over (partition by product_type ORDER BY sale_price DESC) AS rank
FROM product;

SELECT  AVG(sale_price) over (partition by product_type ORDER BY sale_price )
FROM product;

SELECT  product_name
       ,AVG(sale_price) over (partition by product_type ORDER BY sale_price )
FROM product;

SELECT  product_name
       ,product_type
       ,sale_price
       ,rank() over ( ORDER BY sale_price)      AS rank
       ,dense_rank() over (ORDER by sale_price) AS dense_rank
       ,row_number() over(order by sale_price)  AS row_number
FROM product;

SELECT  product_id
       ,product_name
       ,sale_price
       ,SUM(sale_price) over (order by product_id) AS current_sum_price
FROM product;

SELECT  product_id
       ,product_name
       ,sale_price
       ,product_type
       ,SUM(sale_price) over (partition by product_type ORDER BY product_id) AS current_sum_price
FROM product;

SELECT  product_id
       ,product_name
       ,sale_price
       ,AVG(sale_price) over (order by product_id) AS current_avg
FROM product;

SELECT  product_id
       ,product_name
       ,sale_price
       ,AVG(sale_price) over (order by product_id rows 2 preceding) AS moving_avg
FROM product;

SELECT  product_id
       ,product_name
       ,sale_price
       ,AVG(sale_price) over ( ORDER BY product_id rows BETWEEN 1 preceding AND 1 following) AS moving_avg
FROM product; )

SELECT  product_id
       ,product_name
       ,sale_price
       ,AVG(sale_price) over (ORDER by product_id rows 2 preceding) AS pre_moving_avg
FROM product;

SELECT  product_id
       ,product_name
       ,sale_price
       ,AVG(sale_price) over (ORDER by product_id rows 2 following) AS flw_moving_avg
FROM product;

SELECT  product_id
       ,product_name
       ,sale_price
       ,AVG(sale_price) over (ORDER by product_id rows BETWEEN 1 preceding AND 1 following) AS btn_moving_avg
FROM product;

SELECT  product_name
       ,product_type
       ,sale_price
       ,RANK () OVER (ORDER BY sale_price) AS ranking
FROM Product;

SELECT  product_name
       ,product_type
       ,sale_price
       ,RANK () OVER (ORDER BY sale_price) AS ranking
FROM Product
ORDER BY ranking;

SELECT  product_id
       ,product_name
       ,sale_price
       ,MAX (sale_price) OVER (ORDER BY product_id) AS current_max_price
FROM Product;

SELECT  regist_date
       ,SUM(sale_price)
FROM product
GROUP BY
GROUPING SETS (regist_date)
ORDER BY regist_date;

SELECT  regist_date
       ,SUM(sale_price) over (order by regist_date nulls FIRST) AS sum
FROM product;

SELECT  regist_date
       ,SUM(sale_price) over (order by coalesce(regist_date, CAST('2020-01-01' AS DATE ))) AS sum
FROM product;