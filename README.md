# **OPERACIÓN MAREA ALTA**

> ### Reto de diseño de bases de datos
> **Gestión de ayudas humanitarias ante una emergencia sísmica en Buenaventura**
> Trabajo colaborativo · Modelo conceptual · Modelo relacional

---

```text
ALERTA        La operación comenzó.
TERRITORIO    Distrito de Buenaventura: zona urbana y zona rural.
MISIÓN        Convertir una situación de emergencia en un modelo de datos coherente.
FECHA         10 de agosto de 2026.
```

> **PUNTO DE PARTIDA**
> Un hecho ocurrido en Buenaventura da origen al problema que se modelará.

---

## 01 / EL HECHO QUE DA ORIGEN AL RETO

El 10 de agosto de 2026, a las 7:34 a. m., un sismo de magnitud 7,4 con epicentro en San José del Palmar, Chocó, afectó el occidente colombiano. Buenaventura estuvo entre los territorios afectados y recibió ayudas humanitarias para atender a las familias damnificadas. El evento dejó una necesidad concreta: organizar información confiable sobre los hogares, sus necesidades, las donaciones recibidas, las existencias y la distribución de las ayudas. Este reto parte de ese hecho para plantear cómo debería estructurarse la base de datos que soportaría dicha gestión.

Fuentes de contexto: [Servicio Geológico Colombiano](https://www2.sgc.gov.co/Noticias/Paginas/Sismo-de-San-Jose-del-Palmar-un-mes-de-monitoreo-investigacion-y-trabajo-en-territorio-del-SGC.aspx) y [Gobernación de Cundinamarca](https://www.cundinamarca.gov.co/noticias/cundinamarca-envia-ayudas-humanitarias-a-buenaventura-tras-el-sismo-del-10-de-agosto/).

Buenaventura comprende una zona urbana, organizada en barrios, y una zona rural conformada por corregimientos, veredas y comunidades. La ubicación de un hogar debe permitir identificar la zona y la división territorial que corresponda. En algunos sectores rurales no existe una dirección convencional, por lo que puede ser necesario registrar una referencia de ubicación.

La información se recibe y consolida de manera centralizada. La base de datos debe permitir registrar hogares afectados, identificar sus necesidades, recibir donaciones, controlar la disponibilidad de las ayudas y dejar constancia de las entregas. Su alcance se limita al recorrido de la ayuda desde que es recibida hasta que llega a un hogar en un punto de atención.

Cada hogar afectado tiene una persona de contacto. El registro debe indicar cuántas personas componen el hogar y si hay condiciones que alteren la prioridad de atención, por ejemplo presencia de niños pequeños, personas mayores, mujeres gestantes o personas con movilidad reducida.

Los hogares pueden reportar varias necesidades. Una necesidad corresponde a una categoría, como agua potable, alimentos, elementos de aseo, refugio temporal o medicamentos. El mismo tipo de necesidad puede ser reportado por muchos hogares. Para cada reporte interesa conocer la urgencia, una cantidad estimada cuando sea posible, observaciones de campo y su estado de atención. Una necesidad puede cambiar con el tiempo; el diseño deberá definir qué información conservar y qué reglas evitan registros contradictorios.

Las ayudas provienen de donantes. Un donante puede ser una persona, una organización comunitaria, una empresa o una entidad pública. Cada donación puede incluir diferentes tipos de ayuda y cantidades distintas. El equipo responsable debe conocer qué se recibió, en qué fecha, quién lo entregó y qué cantidad continúa disponible.

Cada tipo de ayuda debe manejar una unidad de medida estándar para todos sus movimientos. Si el arroz se controla en libras, las entradas y las entregas se registran en libras. Si un donante informa que entrega dos arrobas, la cantidad debe convertirse a la unidad acordada antes de ingresarla en la base de datos. El sistema no administrará procesos de reempaque, fraccionamiento de presentaciones ni equivalencias durante la distribución. La cantidad recibida, la disponible y la entregada deben poder compararse directamente.

La distribución se realiza desde puntos de atención habilitados para la emergencia. Un hogar puede recibir ayuda más de una vez y una jornada de entrega puede atender a muchos hogares. Cada entrega debe indicar el punto de atención, el hogar atendido, la fecha de entrega, la fecha de registro, la persona que dejó la constancia y los tipos de ayuda entregados con sus cantidades. El sistema debe impedir cantidades negativas o superiores a las existencias disponibles.

La coordinación necesita consultar, como mínimo, qué hogares siguen pendientes, cuáles necesidades tienen mayor urgencia, cuánto inventario queda por tipo de ayuda, qué se entregó a cada hogar y qué movimientos ocurrieron en un punto de atención durante un periodo determinado.

Distintas personas usarán el sistema. Una misma persona puede apoyar más de una función durante la emergencia: por ejemplo, registrar hogares y después coordinar inventario. Algunas funciones permiten consultar; otras permiten registrar o autorizar movimientos. Las funciones no pertenecen de manera exclusiva a una persona y pueden reasignarse. El modelo debe representar esta situación sin guardar listas de permisos dentro de un solo campo.

---

## 02 / LA MISIÓN

Diseñen una base de datos relacional que sostenga la operación descrita. El resultado debe permitir reconstruir el recorrido de una ayuda: su procedencia, disponibilidad, asignación y entrega.

No se asignan nombres ni cantidades obligatorias de tablas. Cada equipo deberá justificar cómo separa los conceptos del problema y por qué cada relación conserva un hecho distinto.

> **PUNTO DE CONTROL**  
> No comiencen dibujando tablas. Primero identifiquen hechos, reglas, actores, objetos y eventos. Una tabla prematura suele convertir una interpretación inicial en un error difícil de corregir.

### Pregunta de diseño

¿Cómo representarían la operación para saber **qué se necesita, qué hay disponible, de dónde provino y qué recibió cada hogar**, sin duplicar información ni perder trazabilidad?

---

## 03 / REGLAS QUE EL MODELO DEBE PODER EXPRESAR

Las siguientes condiciones forman parte del problema. No indican directamente qué tablas crear.

| Código | Condición verificable |
|:--|:--|
| R-01 | Cada hogar tiene un identificador estable, aunque cambie su lugar temporal de permanencia. |
| R-02 | Un hogar puede reportar distintos tipos de necesidad. |
| R-03 | Un tipo de necesidad puede aparecer en los reportes de muchos hogares. |
| R-04 | El reporte debe conservar datos propios de la relación, como urgencia, cantidad estimada, estado y observación. |
| R-05 | Un donante puede realizar varias donaciones. |
| R-06 | Una donación puede incluir distintos tipos de ayuda, cada uno con cantidad y unidad de medida. |
| R-07 | El mismo tipo de ayuda puede aparecer en distintas donaciones. |
| R-08 | Un hogar puede recibir varias entregas en momentos diferentes. |
| R-09 | Cada entrega ocurre en un solo punto de atención, pero un punto registra muchas entregas. |
| R-10 | Una entrega puede incluir varios tipos de ayuda y un tipo de ayuda puede aparecer en muchas entregas. |
| R-11 | La cantidad entregada pertenece al detalle de la entrega, no al hogar ni al tipo de ayuda. |
| R-12 | Debe diferenciarse la fecha de entrega de la fecha de registro en el sistema. |
| R-13 | Cada tipo de ayuda debe tener una unidad de medida estándar, usada tanto en las entradas como en las entregas. |
| R-14 | Una entrega confirmada no puede dejar el inventario con saldo negativo. |
| R-15 | Una persona usuaria puede tener varias funciones y una función puede corresponder a varias personas. |
| R-16 | La asignación de una función debe poder activarse o finalizar sin eliminar a la persona ni la función. |
| R-17 | Toda cantidad debe ser mayor que cero y expresarse en la unidad definida para ese tipo de ayuda. |

> **PRECISIÓN TÉCNICA**  
> Algunas reglas se resuelven con claves y restricciones. Otras requieren una transacción, una consulta de control o lógica de aplicación. Indiquen cuál mecanismo usarían en cada caso.

---

## 04 / LO QUE DEBEN DESCUBRIR

Antes de construir el diagrama, produzcan un inventario breve de decisiones:

- conceptos que tienen identidad propia;
- eventos que deben conservar fecha, responsable y estado;
- relaciones cuya existencia contiene información adicional;
- atributos atómicos y dominios posibles;
- datos derivados que no conviene almacenar;
- reglas que no pueden representarse únicamente con cardinalidades.

No basta con detectar una relación de muchos a muchos. Deben decidir si esa relación representa un hecho del negocio y qué atributos nacen en ella. Una cantidad solicitada, recibida o entregada puede parecer el mismo dato, pero corresponde a momentos distintos de la operación.

---

## 05 / RUTA TÉCNICA

### **ETAPA 1 — Lectura y decantación**

Marquen en el enunciado candidatos a entidades, atributos, relaciones y reglas. Depuren sinónimos y términos ambiguos. Elaboren un glosario de entre **8 y 15 conceptos**, cada uno con una definición de una sola oración vinculada al escenario.

### **ETAPA 2 — Modelo conceptual**

Construyan un diagrama entidad-relación independiente del motor de base de datos. Debe mostrar:

- entidades y atributos relevantes;
- identificadores propuestos;
- cardinalidad mínima y máxima;
- participación opcional u obligatoria;
- entidades asociativas cuando la relación tenga datos propios.

**Evidencia:** diagrama legible y explicación de las decisiones que puedan generar discusión.

> **VALIDACIÓN OBLIGATORIA EN CLASE**
> El equipo debe presentar al profesor el modelo conceptual elaborado a mano antes de finalizar la sesión. Esta revisión es un requisito para continuar con el modelo relacional. Si el modelo conceptual no ha sido presentado y validado durante la clase, el equipo no queda habilitado para proseguir y la entrega posterior no será recibida.

### **ETAPA 3 — Modelo relacional**

Transformen el modelo conceptual en relaciones. Para cada tabla indiquen nombre, columnas, tipo de dato aproximado, clave primaria, claves foráneas, obligatoriedad, unicidad y valores por defecto cuando correspondan.

Usen una notación consistente. Ejemplo de formato, sin relación con una solución del reto:

```text
TABLA_EJEMPLO (
    id_ejemplo        INTEGER       PK,
    codigo            VARCHAR(20)   NOT NULL UNIQUE,
    fecha_registro    TIMESTAMP     NOT NULL,
    id_referencia     INTEGER       FK -> OTRA_TABLA.id_referencia
)
```

**Evidencia:** esquema relacional con tablas, atributos, claves primarias y claves foráneas.

---

## 06 / CASOS PARA PROBAR EL DISEÑO

Usen estos casos para revisar el modelo conceptual y el modelo relacional. No deben entregar un informe de validación. Si un caso no puede representarse, revisen las entidades, las relaciones, las cardinalidades o las claves propuestas.

<details>
<summary><strong>CASO A — Un hogar, varias necesidades</strong></summary>

Un hogar de seis integrantes reporta agua potable con urgencia alta y elementos de aseo con urgencia media. Tres días después, la necesidad de agua queda atendida, mientras la otra continúa pendiente.

El sistema debe conservar por separado el tipo, la urgencia, el estado y la evolución de cada reporte.
</details>

<details>
<summary><strong>CASO B — Una donación heterogénea</strong></summary>

Una organización entrega 120 kits de alimentos, 300 litros de agua y 40 mantas. Otro donante aporta dos arrobas de arroz, pero el arroz se controla en libras. La conversión se realiza antes del registro y la base de datos almacena la entrada en la unidad estándar definida para ese producto.

Debe ser posible conocer la procedencia y cantidad de cada componente sin repetir los datos del donante en cada artículo. El inventario no debe mezclar arrobas y libras para el mismo producto.
</details>

<details>
<summary><strong>CASO C — Una entrega con varios artículos</strong></summary>

En un punto de atención, un hogar recibe dos kits de alimentos y diez litros de agua en una misma atención. La entrega ocurrió el 12 de agosto y fue registrada en la base de datos el 13 de agosto.

El modelo debe conservar ambas fechas y las cantidades de cada artículo.
</details>

<details>
<summary><strong>CASO D — Entregas sucesivas</strong></summary>

El mismo hogar recibe una ayuda inicial y vuelve cuatro días después por una necesidad distinta. La segunda entrega ocurre en otro punto de atención.

La consulta del historial debe mostrar ambos eventos sin sobrescribir el primero.
</details>

<details>
<summary><strong>CASO E — Inventario insuficiente</strong></summary>

Quedan ocho unidades de un artículo. Una persona intenta confirmar una entrega de diez.

El sistema debe rechazar la operación completa o dejarla pendiente, según la política definida por el equipo. No puede registrar una entrega confirmada con saldo negativo.
</details>

<details>
<summary><strong>CASO F — Funciones simultáneas</strong></summary>

Una persona registra hogares y también consulta inventario. Otra coordina inventario. Meses después, la primera deja la función de registro, pero conserva acceso de consulta.

El cambio no debe eliminar su cuenta ni alterar las funciones asignadas a otras personas.
</details>

<details>
<summary><strong>CASO G — Dato duplicado</strong></summary>

Dos brigadistas intentan registrar el mismo hogar con variaciones menores en el nombre de la persona de contacto.

El equipo debe proponer una regla realista para detectar o gestionar el posible duplicado. No se exige que los nombres sean globalmente únicos.
</details>

---

## 07 / ENTREGA EN GITHUB

Cada equipo entregará el trabajo mediante un repositorio de GitHub. El enlace del repositorio debe compartirse por el medio indicado por el docente. Si el repositorio es privado, el equipo deberá conceder acceso antes del cierre de la entrega.

La primera versión del modelo se construirá a mano durante la clase, sin computador. Antes de salir del aula, el equipo debe presentarla al profesor y obtener su validación. Después deberá conservar las hojas, fotografiarlas o escanearlas y subirlas al repositorio como evidencia del proceso inicial. Las imágenes deben permitir leer entidades, atributos, relaciones y cardinalidades.

El repositorio contendrá solamente estos productos:

| Archivo | Contenido |
|:--|:--|
| `README.md` | Nombre del equipo, integrantes y una explicación breve de las decisiones principales. |
| `01_boceto_manual.pdf` | Fotografías o escaneo del modelo elaborado a mano durante la clase. |
| `02_modelo_conceptual.pdf` | Versión final del diagrama entidad-relación, con entidades, atributos, identificadores y cardinalidades. |
| `03_modelo_relacional.md` o `03_modelo_relacional.pdf` | Tablas resultantes, atributos, claves primarias y claves foráneas. |

No se solicita diccionario de datos, proceso de normalización, consultas SQL ni informe de validación.

### Estructura esperada

```text
repositorio-del-equipo/
README.md
01_boceto_manual.pdf
02_modelo_conceptual.pdf
03_modelo_relacional.md
```

El modelo conceptual y el modelo relacional deben usar los mismos nombres. Si una relación de muchos a muchos se transforma en una tabla, el cambio debe poder seguirse entre ambos productos.

---

## 08 / CRITERIOS DE REVISIÓN

| Criterio | Pregunta de control |
|:--|:--|
| Correspondencia | ¿El modelo representa los hechos descritos en el enunciado? |
| Entidades y atributos | ¿Cada entidad tiene identidad propia y contiene atributos que le corresponden? |
| Cardinalidades | ¿Cada relación expresa correctamente cuántos registros pueden participar? |
| Relaciones de muchos a muchos | ¿Se reconocen sus atributos y se transforman de forma coherente en el modelo relacional? |
| Claves | ¿Las tablas tienen claves primarias y las relaciones se conservan mediante claves foráneas? |
| Coherencia | ¿Puede seguirse cada entidad y relación desde el modelo conceptual hasta el relacional? |
| Control de acceso | ¿El diseño admite varios usuarios por función y varias funciones por usuario? |

---

## 09 / CONTROL ANTES DE PUBLICAR

```text
[ ] El repositorio identifica al equipo y a sus integrantes.
[ ] El profesor validó el modelo conceptual durante la sesión de clase.
[ ] Se adjuntó una copia legible del boceto elaborado a mano.
[ ] El modelo conceptual incluye entidades, atributos y cardinalidades.
[ ] El modelo relacional identifica tablas, claves primarias y claves foráneas.
[ ] Las relaciones de muchos a muchos fueron resueltas en el modelo relacional.
[ ] El modelo conceptual y el relacional usan nombres consistentes.
[ ] Los casos A–G pueden representarse con el diseño propuesto.
[ ] Todos los archivos abren correctamente desde GitHub.
```
