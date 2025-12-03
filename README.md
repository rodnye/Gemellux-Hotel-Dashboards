# Dashboards de Monitoreo - Hotel Nacional de Cuba

![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Cuba](https://img.shields.io/badge/Hotel-Nacional%20de%20Cuba-red?style=for-the-badge)

Sistema de visualización de consumos energéticos para el Hotel Nacional de Cuba. Monitorea en tiempo real el consumo de electricidad, agua, gas y diesel, con alertas de cobertura.

## Dashboards

### 1. Dashboard de Cobertura
- Estado de combustibles (Diesel, Gas, Agua)
- Indicadores visuales por colores
- Medidor de porcentaje y valores reales

![](./screenshots/coverage.png)

### 2. Dashboard de Consumo
- Monitoreo por tipo de energía
- Períodos: Diario, Mensual, Anual
- Comparativa: Real vs Planificado vs Año Anterior

![](./screenshots/consumption.png)

### 3. Consumo por HDO
- Consumo eléctrico por habitación ocupada
- Análisis de eficiencia energética

![](./screenshots/consumption_hdo.png)

## Tecnologías
- **Grafana** - Visualización
- **PostgreSQL** - Base de datos
- **JSON** - Configuración dashboards

## Instalación
1. Importar JSONs en Grafana o definir la carpeta `grafana/` como Provisioning
2. Configurar datasource PostgreSQL

---

*Sistema desarrollado para la gestión eficiente de recursos del Hotel Nacional de Cuba*