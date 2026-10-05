CREATE TABLE product (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0
)

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  producto_id INT REFERENCES product(id),
  client_name VARCHAR(100) NOT NULL,
  cliente_phone VARCHAR(20) NOT NULL,
  countt INT NOT NULL,
  total NUMERIC(10,2) NOT NULL,
  state VARCHAR(20) DEFAULT 'activo',
  created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO products (nombre, precio, stock) VALUES
  ('Zapatos deportivos', 50.00, 3),
  ('Camiseta', 25.50, 10),
  ('Gorra', 15.00, 5),
  ('Cartera', 100.00, 25),
  ('Boxer', 1500.00, 15);
  
SELECT * FROM products;


