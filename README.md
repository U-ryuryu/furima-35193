## users

| Column          | Type   | Options     |
| --------------- | ------ | ----------- |
| nickname        | string | null: false |
| email           | string | null: false |
| password        | string | null: false |
| last_name       | string | null: false |
| first_name      | string | null: false |
| read_last_name  | string | null: false |
| read_first_name | string | null: false |
| birthday        | date   | null: false |

### Association

- has_many :items
- has_many :purchases

## items

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| name             | string     | null: false                    |
| description      | text       | null: false                    |
| price            | integer    | null: false                    |
| category_id      | integer    | null: false                    |
| status_id        | integer    | null: false                    |
| payment_id       | integer    | null: false                    |
| prefecture_id    | integer    | null: false                    |
| delivery_day_id  | integer    | null: false                    |
| user_id          | references | null: false, foreign_key: true |

### Association

- belongs_to             :user
- has_one                :purchase
- belongs_to_active_hash :category
- belongs_to_active_hash :status
- belongs_to_active_hash :payment
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :delivery_day

## purchase

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| user_id          | references | null: false, foreign_key: true |
| items_id         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :shipping_address

## shipping_address

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| postal_code      | string     | null: false                    |
| city             | string     | null: false                    |
| address          | string     | null: false                    |
| tel              | string     | null: false                    |
| prefecture_id    | integer    | null: false                    |
| purchase_id      | references | null: false, foreign_key: true |

### Association

- belongs_to             :purchase
- belongs_to_active_hash :prefecture