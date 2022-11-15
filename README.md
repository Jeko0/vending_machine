# Vending machine 

Vending machine logic implementation with api 


## Features

- User authentication/authorization
- JWT 
- CRUD implementation for products
- Buy product, update/reset deposit


## API Reference

#### User registration/session/delete account

```http
  POST /api/users/
```

| Parameters | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `user name, email, password, role` | `string/integer` | fill necessary fields |

```http
  POST /api/users/login
```

| Parameters | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `user name, password` | `string/integer` | login to receive JWT |

```http
  DELETE /api/users
```

| Parameters | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `JWT` | `string` | delete account |

```http
  PATCH /api/users
```

| Parameters | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `JWT and other parameters` | `string/integer` | Update account |

#### CRUD for products, note: you have to be a seller in order to interact with products

```http
  POST /api/products/
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `Seller JWT, product name, amount, cost`      | `string/integer` | create product|

```http
  GET /api/products
```

| Parameters | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `-` | `-` | shows all products|

```http
  GET /api/produts/:id
```

| Parameters | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `-` | `-` | shows specific product |

```http
  PATCH /api/products/:id
```

| Parameters | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `seller JWT and other parameters` | `string/integer` | update product |

```http
  DELETE /api/products/:id
```

| Parameters | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `seller JWT` | `string` | Delete product |

```http
  POST /api/buy/, note: you have to be a buyer in order to purchase product
```

| Parameters | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `buyer JWT, product_id, amount` | `string/integer` | buy product |

#### depostis 

```http
  GET /api/deposit/
```

| Parameters | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `buyer JWT` | `string` |  shows your current wallet  |

```http
  PATCH /api/deposit/
```

| Parameters | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `buyer JWT, desired coins(5, 10, 20, 50, 100)` | `string/integer` |  update wallet  |

```http
  DELETE /api/reset/
```

| Parameters | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `buyer JWT` | `string` |  resets your wallet  |




