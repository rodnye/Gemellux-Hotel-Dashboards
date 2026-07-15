### Tabla principal

```sql
-- La tabla está en el esquema 'gemelluxiot'
-- El nombre de la tabla es 'x002fconsumptionobserved'
```

### Columnas de la tabla

| Columna        | Tipo                 | Descripción                                                                                                |
| -------------- | -------------------- | ---------------------------------------------------------------------------------------------------------- |
| `recvtimets`   | `bigint`             | Timestamp en **milisegundos** (se convierte a segundos con `/1000` en las consultas)                       |
| `dateobserved` | `date` o `timestamp` | Fecha de observación en formato de fecha                                                                   |
| `carriers`     | `text` (o `jsonb`)   | Contiene un array JSON con los datos de los portadores. En las consultas se castea a `jsonb` con `::jsonb` |

### Estructura del JSON (campo `carriers`)

El campo `carriers` almacena un **array de objetos JSON**, donde cada objeto representa un portador de energía/recurso con sus métricas de consumo y cobertura.

#### Estructura de cada elemento del array:

```json
{
  "carrierType": "string",
  "unit": "string",
  "coverage": "integer",
  "yearPlan": "numeric",
  "yearReal": "numeric",
  "yearRealLastYear": "numeric",
  "monthPlan": "numeric",
  "monthReal": "numeric",
  "monthRealLastYear": "numeric",
  "dayPlan": "numeric",
  "dayReal": "numeric",
  "dayRealLastYear": "numeric"
}
```

#### Descripción detallada de cada campo:

| Campo               | Tipo      | Descripción                        | Valores observados                                                                                                                                        |
| ------------------- | --------- | ---------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `carrierType`       | `string`  | Tipo de portador/energía           | `liquefiedPetroleumGas` (Gas), `water` (Agua), `boilerDiesel` (Diesel), `electricity` (Electricidad), `kWhPerOccupiedRooms` (Electricidad por Habitación) |
| `unit`              | `string`  | Unidad de medida                   | `L` (litros), `kWh`, `m³`, etc.                                                                                                                           |
| `coverage`          | `integer` | Cobertura actual                   | Valor numérico (ej: 40000)                                                                                                                                |
| `yearPlan`          | `numeric` | Plan anual                         | Valor numérico                                                                                                                                            |
| `yearReal`          | `numeric` | Real anual                         | Valor numérico                                                                                                                                            |
| `yearRealLastYear`  | `numeric` | Real del año anterior              | Valor numérico                                                                                                                                            |
| `monthPlan`         | `numeric` | Plan mensual                       | Valor numérico                                                                                                                                            |
| `monthReal`         | `numeric` | Real mensual                       | Valor numérico                                                                                                                                            |
| `monthRealLastYear` | `numeric` | Real del mes anterior (año pasado) | Valor numérico                                                                                                                                            |
| `dayPlan`           | `numeric` | Plan diario                        | Valor numérico                                                                                                                                            |
| `dayReal`           | `numeric` | Real diario                        | Valor numérico                                                                                                                                            |
| `dayRealLastYear`   | `numeric` | Real del día anterior (año pasado) | Valor numérico                                                                                                                                            |

### Esquema SQL completo

```sql
CREATE SCHEMA IF NOT EXISTS gemelluxiot;

CREATE TABLE IF NOT EXISTS gemelluxiot.x002fconsumptionobserved (
    id SERIAL PRIMARY KEY,
    recvtimets BIGINT NOT NULL,          -- Timestamp en milisegundos
    dateobserved TIMESTAMP WITHOUT TIME ZONE,
    carriers TEXT NOT NULL,              -- JSON almacenado como texto
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Índices recomendados para optimizar las consultas
CREATE INDEX idx_recvtimets ON gemelluxiot.x002fconsumptionobserved (recvtimets);
CREATE INDEX idx_dateobserved ON gemelluxiot.x002fconsumptionobserved (dateobserved);
```

### Ejemplo de registro completo

```json
{
  "recvtimets": 1757894400000,
  "dateobserved": "2025-09-15",
  "carriers": [
    {
      "carrierType": "liquefiedPetroleumGas",
      "unit": "L",
      "coverage": 45000,
      "yearPlan": 500000,
      "yearReal": 480000,
      "yearRealLastYear": 490000,
      "monthPlan": 42000,
      "monthReal": 40000,
      "monthRealLastYear": 41000,
      "dayPlan": 1400,
      "dayReal": 1350,
      "dayRealLastYear": 1380
    },
    {
      "carrierType": "water",
      "unit": "m³",
      "coverage": 1200,
      "yearPlan": 15000,
      "yearReal": 14500,
      "yearRealLastYear": 14800,
      "monthPlan": 1250,
      "monthReal": 1200,
      "monthRealLastYear": 1220,
      "dayPlan": 40,
      "dayReal": 38,
      "dayRealLastYear": 39
    }
  ]
}
```
