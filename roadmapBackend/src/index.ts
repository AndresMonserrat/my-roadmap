import express from "express";
import cors from "cors";
import { pool } from "./db.js";

const app = express();
const PORT = process.env.PORT || 3000;

/* middlewares */
app.use(cors());
app.use(express.json());

async function verify(res: any, req: any) {
  const { rows } = await pool.query("SELECT COUNT(*) FROM products");
  res.json({
    status: "ok",
    db: "conectada",
    productos: Number(rows[0].count),
    setInterval,
  });
}

/* Ruta de prueba: verifica que la API y la DB estan conectadas */
app.get("/", async (_req, res) => {
  try {
    verify;
  } catch (err) {
    console.error(err);
    res.status(500).json({
      status: "error",
      db: "no conectada",
      detalle: err instanceof Error ? err.message : "Error desconocido",
    });
  }
});
/* 
app.listen(PORT, () => {
  console.log(`API escuchando en http://localhost:${PORT}`);
});
 */