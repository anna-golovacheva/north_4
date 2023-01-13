-- ЗАДАНИЕ 1

-- 1. Создать таблицу student с полями student_id serial, 
-- first_name varchar, last_name varchar, birthday date, 
-- phone varchar

CREATE TABLE students (
    student_id serial PRIMARY KEY,
	first_name varchar,
	last_name varchar,
	birthday date,
	phone varchar
);

-- 2. Добавить в таблицу после создания колонку middle_name varchar

ALTER TABLE students ADD COLUMN middle_name varchar;

-- 3. Удалить колонку middle_name

ALTER TABLE students DROP COLUMN middle_name;

-- 4. Переименовать колонку `birthday` в `birth_date`

ALTER TABLE students RENAME birthday TO birth_date;

-- 5. Изменить тип данных колонки `phone` на `varchar(32)`

ALTER TABLE students ALTER COLUMN phone SET DATA TYPE varchar(32);

-- 6. Вставить три любых записи с автогенерацией идентификатора

INSERT INTO students (first_name, last_name, birth_date, phone) 
VALUES ('Gregory', 'McHale', '2002-01-12', '34545972'), 
       ('Wirt', 'McHale', '1994-10-06', '03487534'),
	   ('Beatrice', 'Bluebird', '1993-03-01', '96857925');

-- 7. Удалить все данные из таблицы со сбросом идентификатор в 
-- исходное состояние

TRUNCATE TABLE students RESTART IDENTITY;


-- ЗАДАНИЕ 2

-- 1. добавить ограничение на поле `unit_price` таблицы `products`
-- (цена должна быть больше `0`)

ALTER TABLE products
ADD CONSTRAINT check_unit_price_positive
CHECK (unit_price > 0);

-- 2. добавить ограничение, что поле `discontinued` таблицы `products`
-- может содержать только значения `0` или `1`

ALTER TABLE products
ADD CONSTRAINT check_discontinued_boolean
CHECK (discontinued IN (0, 1));

-- 3.  Создать новую таблицу, содержащую все продукты, снятые
-- с продажи (`discontinued = 1`)

SELECT * INTO discontinued_products
FROM products
WHERE discontinued = 1;

-- 4. Удалить из `products` товары, снятые с продажи
-- (`discontinued = 1`)

ALTER TABLE order_details
DROP CONSTRAINT fk_order_details_products;

ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_products
FOREIGN KEY (product_id) REFERENCES products (product_id)
ON DELETE CASCADE;

DELETE FROM products
WHERE discontinued = 1;
