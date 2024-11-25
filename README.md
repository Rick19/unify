# UNIFY

Proyecto que unifica tres herramientas para pruebas técnicas.

## Acerca de

Este proyecto fue generado con Flutter. Algunas librerias implementadas solo funcionan para moviles Android & iOS

## Estructura del proyecto
Un desglose de la estructura de directorios del proyecto, explicando el propósito de cada directorio y sus componentes clave:


    .
    ├── bloc
    │   ├── photo_bloc.dart
    │   └── task_bloc.dart
    ├── data
    │   ├── database_helper.dart
    │   ├── model
    │   │   └── photo.dart
    │   ├── photo_repository.dart
    │   └── task_repository.dart
    ├── main.dart
    └── presentation
    ├── screens
    │   ├── 00_welcome
    │   │   └── welcome_screen.dart
    │   ├── 01_home
    │   │   └── home_screen.dart
    │   ├── 02_calculator
    │   │   └── calculator_screen.dart
    │   ├── 03_tasks
    │   │   ├── task_detail_screen.dart
    │   │   ├── task_item_widget.dart
    │   │   └── tasks_screen.dart
    │   └── 04_search_api
    │       └── search_screen.dart
    ├── tab_item.dart
    └── utils.dart


## 🧮 Calculadora de propinas
Muestra un input para introducir el total de la cuenta, un slider semicircular y un botón que realizará el cálculo mostrado en un Dialog.


## 📋 Lista de tareas
Muestra una pantalla con un tab, cada tab funciona con BLoC, mostrando el total de tareas contadas almacenadas en SQLite.

#### Funciones: 
- Agregar: Se muestra un bottom sheet dialog con título y descripción. 
- Detalle: Al seleccionar una tarea, se mostrará el detalle y botones de acción en una pantalla.
- Listado según su estado.

## 📋 Búsqueda por API [unsplash]
Muestra una pantalla con un input para realizar una búsqueda y conectarse por medio de http a la api.

#### Funciones: 
- Listado (mansory): Se muestra una lista con las imagenes relacionadas.
- Detalle: Al seleccionar una imagen, se mostrará el título y la imagen en tamaño real.

Nota: Falta mejorar interface.

## 📦 Dependencias Usadas

Principales dependencias externas utilizadas:

| Librería                      | Descripción                                                                                   | Versión  |
|-------------------------------|-----------------------------------------------------------------------------------------------|----------|
| **[bloc](https://pub.dev/packages/bloc)**                  | Implementación de patrones BLoC (Business Logic Component) para manejar estados de forma predecible. | `^8.1.0` |
| **[bloc_concurrency](https://pub.dev/packages/bloc_concurrency)** | Herramientas avanzadas para manejar concurrencia con BLoC.                                      | `^0.2.0` |
| **[curved_navigation_bar](https://pub.dev/packages/curved_navigation_bar)** | Barra de navegación inferior curva para una experiencia visual mejorada.                       | `^1.0.6` |
| **[drop_shadow](https://pub.dev/packages/drop_shadow)**     | Facilita agregar sombras personalizables a los widgets.                                        | `^0.1.0` |
| **[english_words](https://pub.dev/packages/english_words)** | Generador de palabras en inglés, útil para ejemplos o nombres aleatorios.                      | `^4.0.0` |
| **[equatable](https://pub.dev/packages/equatable)**         | Simplifica la comparación de objetos inmutables, ideal para trabajar con estados en Flutter.    | `^2.0.7` |
| **[flutter_animate](https://pub.dev/packages/flutter_animate)** | Biblioteca de animaciones fácil de usar para widgets en Flutter.                                | `^4.5.1` |
| **[flutter_bloc](https://pub.dev/packages/flutter_bloc)**   | Integración de la biblioteca `bloc` con Flutter, incluyendo widgets para manejar estados.       | `^8.1.6` |
| **[flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view)** | Diseños de cuadrícula avanzada para Flutter, como cuadrículas escalonadas.                     | `^0.7.0` |
| **[http](https://pub.dev/packages/http)**                   | Cliente HTTP simple para realizar peticiones RESTful y consumir APIs.                          | `^0.13.0` |
| **[path](https://pub.dev/packages/path)**                   | Manipulación de rutas de archivos y directorios de forma eficiente.                            | `^1.9.0` |
| **[provider](https://pub.dev/packages/provider)**           | Herramienta para la gestión de estados y dependencias en Flutter.                              | `^6.0.0` |
| **[sleek_circular_slider](https://pub.dev/packages/sleek_circular_slider)** | Un deslizador circular personalizable con animaciones y diseño moderno.                        | `^2.0.1` |
| **[sqflite](https://pub.dev/packages/sqflite)**             | Proveedor de base de datos SQLite para Flutter, ideal para almacenamiento local persistente.    | `^2.3.3+1` |

---

### Cómo Instalar Dependencias

Para instalar las dependencias del proyecto, utiliza el siguiente comando en tu terminal:

```bash
flutter pub get
```

---

### Nota sobre Licencias

Todas las librerías mencionadas están disponibles en **[pub.dev](https://pub.dev)** y se distribuyen bajo licencias de código abierto. 
