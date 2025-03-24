# PostgreSQL সম্পর্কে বিস্তারিত

## PostgreSQL কি?
PostgreSQL হল একটি **ওপেন-সোর্স অবজেক্ট-রিলেশনাল ডাটাবেস ম্যানেজমেন্ট সিস্টেম (ORDBMS)**, যা উচ্চ মানের **পারফরম্যান্স, স্কেলেবিলিটি, ডাটা ইন্টিগ্রিটি, এবং ACID কমপ্লায়েন্স** প্রদান করে। এটি SQL এবং JSON সহ বিভিন্ন ডাটা টাইপ সমর্থন করে এবং বিস্তৃত এক্সটেনশন সমর্থন করে।

## PostgreSQL-এ ডাটাবেস স্কিমার উদ্দেশ্য কী?
**স্কিমা (Schema)** হল একটি **লজিক্যাল স্ট্রাকচার**, যা ডাটাবেসের বিভিন্ন **টেবিল, ফাংশন, ইনডেক্স** এবং অন্যান্য অবজেক্ট সংরক্ষণ ও পরিচালনা করতে সহায়তা করে। এটি ডাটাবেসকে **সাংগঠনিকভাবে সাজিয়ে রাখতে** সাহায্য করে।

**উদাহরণ:**
```sql
CREATE SCHEMA sales;
CREATE TABLE sales.orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    total_price NUMERIC
);
```
এতে **sales** নামে একটি স্কিমা তৈরি হয়েছে, যেখানে **orders** টেবিল থাকবে।

## Primary Key এবং Foreign Key কী?
✅ **Primary Key:**
- এটি একটি **কলাম বা কলামগুলোর সেট**, যা প্রতিটি সারিকে **এককভাবে শনাক্ত** করে।
- **ডুপ্লিকেট বা NULL মান গ্রহণ করে না**।

✅ **Foreign Key:**
- এটি একটি **কলাম যা অন্য টেবিলের Primary Key কে রেফারেন্স করে**।
- এটি **ডাটার ইন্টিগ্রিটি বজায় রাখে**।

**উদাহরণ:**
```sql
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    total_price NUMERIC NOT NULL
);
```
এখানে `orders.customer_id` **foreign key** হিসাবে `customers.id` রেফারেন্স করছে।

## VARCHAR এবং CHAR-এর মধ্যে পার্থক্য কী?
| বৈশিষ্ট্য  | VARCHAR | CHAR |
|------------|---------|------|
| দৈর্ঘ্য | পরিবর্তনশীল দৈর্ঘ্যের স্ট্রিং | নির্দিষ্ট দৈর্ঘ্যের স্ট্রিং |
| সংরক্ষণ | শুধুমাত্র প্রয়োজনীয় জায়গা নেয় | নির্ধারিত জায়গা বরাদ্দ থাকে |
| গতি | বড় ডাটা সংরক্ষণে কার্যকরী | ছোট ডাটা দ্রুত প্রসেস হয় |

**উদাহরণ:**
```sql
CREATE TABLE example (
    name1 VARCHAR(50),
    name2 CHAR(50)
);
```

## SELECT স্টেটমেন্টে WHERE ক্লজের উদ্দেশ্য কী?
✅ **WHERE ক্লজ** **নির্দিষ্ট শর্ত অনুযায়ী রেকর্ড ফিল্টার করতে** ব্যবহৃত হয়।

**উদাহরণ:**
```sql
SELECT * FROM customers WHERE id = 5;
```
এটি `id = 5` এমন কাস্টমারের তথ্য ফেরত দেবে।

## LIMIT এবং OFFSET ক্লজের ব্যবহার কী?
✅ **LIMIT** → নির্দিষ্ট সংখ্যক রেকর্ড ফেরত আনে।
✅ **OFFSET** → নির্দিষ্ট সংখ্যক রেকর্ড বাদ দিয়ে পরবর্তী রেকর্ড ফেরত আনে।

**উদাহরণ:**
```sql
SELECT * FROM customers LIMIT 10 OFFSET 5;
```
এটি **৫টি রেকর্ড বাদ দিয়ে পরবর্তী ১০টি রেকর্ড ফেরত আনবে**।

## UPDATE স্টেটমেন্ট ব্যবহার করে ডাটা কীভাবে পরিবর্তন করা যায়?
✅ **UPDATE** স্টেটমেন্ট **নির্দিষ্ট রেকর্ড আপডেট করতে** ব্যবহৃত হয়।

**উদাহরণ:**
```sql
UPDATE customers SET name = 'Rahim' WHERE id = 1;
```
এটি `id = 1` এমন কাস্টমারের নাম পরিবর্তন করে **Rahim** করবে।

## PostgreSQL-এ JOIN অপারেশনের গুরুত্ব ও কাজ কী?
✅ **JOIN অপারেশন** একাধিক টেবিলের মধ্যে সম্পর্ক তৈরি করে **সম্পর্কিত ডাটা একসাথে আনার জন্য** ব্যবহৃত হয়।

| JOIN টাইপ  | ব্যবহার |
|------------|---------|
| INNER JOIN | দুটি টেবিলের **ম্যাচিং রেকর্ড** ফেরত দেয় |
| LEFT JOIN | **প্রথম টেবিলের সব রেকর্ড + দ্বিতীয় টেবিলের মিল থাকা রেকর্ড** |
| RIGHT JOIN | **দ্বিতীয় টেবিলের সব রেকর্ড + প্রথম টেবিলের মিল থাকা রেকর্ড** |

**উদাহরণ:**
```sql
SELECT customers.name, orders.total_price
FROM customers
JOIN orders ON customers.id = orders.customer_id;
```
এটি কাস্টমারের নাম এবং তাদের **অর্ডার টোটাল প্রাইস** দেখাবে।

## GROUP BY ক্লজ ও এর ভূমিকা কী?
✅ **GROUP BY** **একই ধরণের রেকর্ডগুলোকে গ্রুপ করে এবং অ্যাগ্রিগেট ফাংশন ব্যবহার করতে সাহায্য করে**।

**উদাহরণ:**
```sql
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;
```
এটি প্রতিটি কাস্টমারের মোট অর্ডারের সংখ্যা দেখাবে।

## PostgreSQL-এ COUNT(), SUM(), এবং AVG() কিভাবে ব্যবহার করা যায়?
✅ **COUNT()** → মোট রেকর্ডের সংখ্যা গণনা করে।
✅ **SUM()** → নির্দিষ্ট কলামের মোট যোগফল প্রদান করে।
✅ **AVG()** → নির্দিষ্ট কলামের গড় মান প্রদান করে।

**উদাহরণ:**
```sql
SELECT COUNT(*) FROM orders; -- মোট অর্ডার সংখ্যা
SELECT SUM(total_price) FROM orders; -- মোট বিক্রয় পরিমাণ
SELECT AVG(total_price) FROM orders; -- গড় অর্ডার মূল্য
```

## 🔗 **PostgreSQL অফিসিয়াল ডকুমেন্টেশন**
PostgreSQL নিয়ে আরও জানতে অফিসিয়াল ডকুমেন্টেশন পড়তে পারেন: [PostgreSQL Documentation](https://www.postgresql.org/docs/)

---

