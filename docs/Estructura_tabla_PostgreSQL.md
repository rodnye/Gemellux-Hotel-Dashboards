### Tabla principal

```sql
-- La tabla está en el esquema público (por defecto)
-- El nombre de la tabla es 'consumption_data'
-- Antes los datos se almacenaban en un JSON dentro de 'carriers'; ahora están normalizados en columnas.
```

### Columnas de la tabla

| Columna                | Tipo                          | Descripción                                                                                      |
| ---------------------- | ----------------------------- | ------------------------------------------------------------------------------------------------ |
| `id`                   | `integer`                     | Identificador único de la fila (autoincremental)                                                 |
| `entity_id`            | `character varying(255)`      | Identificador de la entidad o dispositivo asociado (opcional)                                    |
| `date_observed`        | `date`                        | Fecha de observación de los datos                                                                |
| `carrier_type`         | `character varying(100)`      | Tipo de portador/energía (`liquefiedPetroleumGas`, `water`, `boilerDiesel`, `electricity`, etc.) |
| `unit`                 | `character varying(50)`       | Unidad de medida (`L`, `kWh`, `m³`, etc.)                                                        |
| `coverage`             | `integer`                     | Cobertura actual (valor numérico)                                                                |
| `day_plan`             | `integer`                     | Plan diario                                                                                      |
| `day_real`             | `integer`                     | Real diario                                                                                      |
| `day_real_last_year`   | `integer`                     | Real del día anterior (año pasado)                                                               |
| `month_plan`           | `integer`                     | Plan mensual                                                                                     |
| `month_real`           | `integer`                     | Real mensual                                                                                     |
| `month_real_last_year` | `integer`                     | Real del mes anterior (año pasado)                                                               |
| `year_plan`            | `integer`                     | Plan anual                                                                                       |
| `year_real`            | `integer`                     | Real anual                                                                                       |
| `year_real_last_year`  | `integer`                     | Real del año anterior                                                                            |
| `created_at`           | `timestamp without time zone` | Fecha y hora de creación del registro (por defecto `CURRENT_TIMESTAMP`)                          |

### Esquema SQL completo

```sql
CREATE TABLE IF NOT EXISTS consumption_data (
    id SERIAL PRIMARY KEY,
    entity_id VARCHAR(255),
    date_observed DATE,
    carrier_type VARCHAR(100),
    unit VARCHAR(50),
    coverage INTEGER,
    day_plan INTEGER,
    day_real INTEGER,
    day_real_last_year INTEGER,
    month_plan INTEGER,
    month_real INTEGER,
    month_real_last_year INTEGER,
    year_plan INTEGER,
    year_real INTEGER,
    year_real_last_year INTEGER,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_consumption_date ON consumption_data (date_observed);
CREATE INDEX idx_consumption_carrier ON consumption_data (carrier_type);
```

### Ejemplo de registro completo

```json
{
  "id": 1,
  "entity_id": "HN-001",
  "date_observed": "2025-09-15",
  "carrier_type": "liquefiedPetroleumGas",
  "unit": "L",
  "coverage": 45000,
  "day_plan": 1400,
  "day_real": 1350,
  "day_real_last_year": 1380,
  "month_plan": 42000,
  "month_real": 40000,
  "month_real_last_year": 41000,
  "year_plan": 500000,
  "year_real": 480000,
  "year_real_last_year": 490000,
  "created_at": "2025-09-15T10:30:00"
}
```

> [!note]
> Los valores `day_*`, `month_*` y `year_*` corresponden a las métricas de consumo y cobertura para cada portador. Esta estructura permite consultas más eficientes y un modelado relacional claro.
