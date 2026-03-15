# 🏥 Sistema Hospital

Sistema de gestión hospitalaria desarrollado en Python con interfaz gráfica Tkinter y base de datos MySQL.

---

## 📋 Requisitos previos

- Python 3.8 o superior
- MySQL Server corriendo en `localhost`
- Git (opcional, para clonar el repositorio)

---

## ⚙️ Instalación

### 1. Clonar el repositorio
```bash
git clone https://github.com/tu-usuario/sistema-hospital.git
cd sistema-hospital
```

### 2. Instalar dependencias
```bash
pip install mysql-connector-python pillow tkcalendar openpyxl fpdf2
```

### 3. Configurar la base de datos
Abre MySQL Workbench o tu cliente favorito y ejecuta el script:
```bash
mysql -u root -p < hospital.sql
```
O abre el archivo `hospital.sql` y ejecútalo manualmente desde MySQL Workbench.

### 4. Configurar la conexión
Si tu MySQL usa una contraseña diferente, edita esta sección en `hospital.py`:
```python
def get_conexion():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="TU_CONTRASEÑA",  # <- cambia aquí
        database="hospital"
    )
```

### 5. (Opcional) Agregar favicon
Descarga un ícono `.ico` desde https://www.favicon-generator.org/, nómbralo `favicon.ico` y colócalo en la misma carpeta que `hospital.py`.

### 6. Ejecutar la aplicación
```bash
python hospital.py
```

---

## 🗂️ Estructura del proyecto

```
sistema-hospital/
│
├── hospital.py       # Código principal de la aplicación
├── hospital.sql      # Script SQL con tablas y stored procedures
├── favicon.ico       # Ícono de la aplicación (debes agregarlo)
└── README.md         # Este archivo
```

---

## 🧩 Módulos del sistema

| Módulo | Descripción |
|---|---|
| 👤 Pacientes | Registro, edición y eliminación de pacientes con foto |
| 🩺 Médicos | Gestión de médicos con especialidad y foto |
| 📅 Citas | Agendamiento de citas con selector de calendario |
| 💊 Medicamentos | Inventario de medicamentos con filtro por categoría |

---

## ✅ Funcionalidades

- **CRUD completo** en los 4 módulos conectado a Stored Procedures de MySQL
- **Exportar a Excel** (.xlsx) usando openpyxl
- **Exportar a PDF** con formato de tabla usando fpdf2
- **Filtro por fechas** en exportación de citas
- **Filtro por categoría** en medicamentos
- **Validación de campos**: numéricos, texto, email con mensajes de error
- **Selector de fecha** con calendario flotante (tkcalendar)
- **Gestión de imágenes** con Pillow: JPG, PNG, GIF (redimensión automática a 150x150)
- **Temas claro/oscuro** intercambiables desde el menú
- **Diálogos de confirmación** antes de eliminar o actualizar

---

## 📦 Dependencias

| Librería | Uso |
|---|---|
| `mysql-connector-python` | Conexión a MySQL |
| `pillow` | Manejo de imágenes |
| `tkcalendar` | Selector de fechas |
| `openpyxl` | Exportar a Excel |
| `fpdf2` | Exportar a PDF |

---

## 👤 Autor

Desarrollado como proyecto académico.
