# **OPERACIÓN MAREA ALTA**

> ### Reto de diseño de bases de datos
> **Gestión de ayudas humanitarias ante una emergencia sísmica en Buenaventura**
> Trabajo colaborativo · Diseño conceptual y lógico · Normalización · Validación

---

```text
ALERTA        La operación comenzó.
TERRITORIO    Distrito de Buenaventura: zona urbana y zona rural.
MISIÓN        Convertir una situación de emergencia en un modelo de datos coherente.
FECHA         10 de agosto, dentro del caso académico.
```

> **NOTA DE CONTEXTO**  
> Este reto presenta un escenario académico hipotético. No describe ni atribuye hechos a un terremoto histórico específico.

---

## 01 / ENUNCIADO DEL RETO

Para este ejercicio se asume que el 10 de agosto ocurre un evento sísmico en Buenaventura. La fecha pertenece al caso académico y no hace referencia a un terremoto histórico específico. Después del evento se requiere estructurar una base de datos que soporte la gestión de ayudas humanitarias para los hogares afectados del distrito.

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

Marquen en el enunciado candidatos a entidades, atributos, relaciones y reglas. Depuren sinónimos y términos ambiguos. Entreguen un glosario de entre **8 y 15 conceptos**, cada uno con una definición de una sola oración vinculada al escenario.

**Evidencia:** glosario y lista de reglas interpretadas.

### **ETAPA 2 — Modelo conceptual**

Construyan un diagrama entidad-relación independiente del motor de base de datos. Debe mostrar:

- entidades y atributos relevantes;
- identificadores propuestos;
- cardinalidad mínima y máxima;
- participación opcional u obligatoria;
- entidades asociativas cuando la relación tenga datos propios.

**Evidencia:** diagrama legible y explicación de las decisiones que puedan generar discusión.

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

**Evidencia:** diccionario de datos y esquema relacional.

### **ETAPA 4 — Normalización**

Examinen cada relación hasta tercera forma normal. La explicación debe mostrar el razonamiento, no limitarse a afirmar que el modelo “está en 3FN”.

Para cada cambio realizado, documenten:

```text
SITUACIÓN DETECTADA  -> dato repetido, grupo multivaluado o dependencia inadecuada
RIESGO               -> anomalía de inserción, actualización o eliminación
DECISIÓN             -> separación, nueva clave o restricción
RESULTADO            -> relación obtenida y dependencia que conserva
```

Si una tabla ya cumple las formas normales, expliquen por qué a partir de sus dependencias funcionales.

**Evidencia:** matriz de dependencias funcionales y justificación de 1FN, 2FN y 3FN.

### **ETAPA 5 — Integridad y reglas operativas**

Definan las restricciones que protegerán los datos. Incluyan al menos:

- integridad de entidad y referencial;
- dominios o validaciones para cantidades, estados y niveles de urgencia;
- reglas de unicidad necesarias para evitar duplicados;
- política de actualización y eliminación para cada clave foránea;
- tratamiento de registros históricos;
- mecanismo para impedir saldos negativos.

**Evidencia:** catálogo de restricciones con su mecanismo de aplicación.

### **ETAPA 6 — Prueba del modelo**

Construyan datos mínimos para ejecutar los casos de validación de la siguiente sección. Si el modelo no puede responder una consulta o permite un dato imposible, corríjanlo y documenten el cambio.

**Evidencia:** datos de prueba, consultas planteadas en lenguaje natural y resultado esperado.

---

## 06 / CASOS DE VALIDACIÓN

El modelo se considera defendible si resuelve estos casos sin columnas multivaluadas, duplicación deliberada ni correcciones manuales del saldo.

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

## 07 / CONSULTAS QUE DEBEN PODER RESPONDER

Redacten la lógica necesaria para responder estas preguntas. En esta fase pueden usar álgebra relacional, pseudoconsultas o SQL, según lo indicado por el docente.

1. ¿Qué hogares tienen necesidades de urgencia alta que continúan pendientes?
2. ¿Qué cantidad disponible existe por tipo de ayuda y unidad de medida?
3. ¿Qué ayudas recibió un hogar, en qué fechas y en cuáles puntos?
4. ¿Qué donante aportó los artículos incluidos en una entrega, si el diseño conserva esa trazabilidad?
5. ¿Cuáles puntos registraron entregas entre dos fechas dadas?
6. ¿Qué usuarios tienen actualmente una función determinada?
7. ¿Qué necesidades aparecen con mayor frecuencia en una zona?
8. ¿Qué intentos de entrega deberían rechazarse por falta de existencias?

> **DECISIÓN DE ALCANCE**  
> La pregunta 4 obliga a tomar una decisión de alcance. Si su modelo no vincula una unidad entregada con una donación concreta, explíquenlo y definan hasta dónde llega la trazabilidad. No oculten esa limitación.

---

## 08 / DINÁMICA DE TRABAJO

### Tiempo sugerido: **110 minutos**

| Tramo | Minutos | Acción del equipo | Resultado visible |
|:--|--:|:--|:--|
| Lectura de operación | 10 | Subrayar hechos y dudas | Lista inicial de conceptos |
| Decantación | 15 | Separar entidades, eventos y catálogos | Glosario acordado |
| Diseño conceptual | 25 | Proponer cardinalidades y resolver relaciones | Primer diagrama |
| Prueba cruzada | 15 | Intercambiar el modelo con otro equipo | Dos objeciones documentadas |
| Modelo relacional | 20 | Definir claves, columnas y restricciones | Esquema relacional |
| Normalización | 15 | Revisar dependencias y anomalías | Justificación hasta 3FN |
| Defensa relámpago | 10 | Exponer una decisión difícil | Argumento de dos minutos |

### Roles dentro del equipo

Asignen estas responsabilidades. Una persona puede asumir más de una si el grupo es pequeño.

| Responsabilidad | Tarea durante la sesión |
|:--|:--|
| Lectura de reglas | Detecta condiciones que el diagrama podría omitir. |
| Custodia del modelo | Mantiene consistencia de nombres y cardinalidades. |
| Prueba adversarial | Busca duplicados, pérdidas de historial y datos imposibles. |
| Relatoría | Registra decisiones, desacuerdos y cambios. |
| Vocería | Presenta el diseño sin sustituir la argumentación del grupo. |

### Protocolo de prueba cruzada

Cada equipo entrega su diagrama provisional a otro grupo. El grupo revisor dispone de cinco minutos para formular dos objeciones concretas. Una objeción válida debe mencionar la regla afectada y mostrar un dato que el modelo no pueda guardar o que permita guardar de forma incorrecta.

Ejemplo de estructura:

```text
REGLA AFECTADA:
DATO O SITUACIÓN DE PRUEBA:
COMPORTAMIENTO DEL MODELO:
CORRECCIÓN SOLICITADA:
```

El equipo autor puede aceptar la objeción, rechazarla con una justificación técnica o modificar el alcance declarado.

---

## 09 / ENTREGABLES

Entreguen un solo paquete con los siguientes componentes numerados:

| Nº | Pieza | Contenido mínimo |
|--:|:--|:--|
| 01 | Lectura del problema | Glosario y reglas interpretadas |
| 02 | Modelo conceptual | Diagrama ER con cardinalidades y participación |
| 03 | Modelo relacional | Tablas, PK, FK, nulabilidad y restricciones |
| 04 | Diccionario de datos | Definición, tipo y dominio de cada atributo |
| 05 | Normalización | Dependencias y justificación hasta 3FN |
| 06 | Validación | Resolución de los siete casos y ajustes realizados |
| 07 | Decisiones | Tres decisiones discutidas y criterio adoptado |

### Convención de entrega

```text
grupo_XX/
01_lectura_problema.md
02_modelo_conceptual.pdf
03_modelo_relacional.md
04_diccionario_datos.csv
05_normalizacion.md
06_validacion.md
07_decisiones.md
```

El diagrama puede elaborarse con la herramienta acordada en clase. Debe ser legible sin ampliaciones excesivas y usar los mismos nombres del diccionario de datos.

---

## 10 / CRITERIOS DE REVISIÓN

| Criterio | Pregunta de control |
|:--|:--|
| Correspondencia | ¿El modelo representa los hechos descritos y respeta el alcance? |
| Cardinalidades | ¿Cada relación expresa correctamente mínimos y máximos? |
| Datos de relación | ¿Las relaciones con atributos propios fueron modeladas sin listas dentro de campos? |
| Normalización | ¿Las dependencias justifican la estructura y evitan anomalías? |
| Integridad | ¿Las restricciones impiden cantidades inválidas, huérfanos y duplicados previsibles? |
| Trazabilidad | ¿Puede reconstruirse el origen y destino de la ayuda dentro del alcance declarado? |
| Control de acceso | ¿La asignación de funciones admite varias por usuario y varios usuarios por función? |
| Argumentación | ¿Las decisiones se explican con reglas, casos y consecuencias? |

---

## 11 / CONTROL ANTES DE ENTREGAR

```text
[ ] Cada tabla tiene una clave primaria definida.
[ ] Todas las claves foráneas indican obligatoriedad y política de borrado.
[ ] Ningún atributo almacena listas separadas por comas.
[ ] Las relaciones de muchos a muchos fueron examinadas por sus datos propios.
[ ] Las cantidades incluyen dominio, unidad y validación.
[ ] El modelo distingue la fecha de entrega de la fecha de registro.
[ ] Cada tipo de ayuda usa la misma unidad en entradas, existencias y entregas.
[ ] Los casos A–G pueden representarse sin modificar la estructura.
[ ] Las consultas propuestas pueden responderse con los datos almacenados.
[ ] La normalización está razonada mediante dependencias funcionales.
[ ] El diagrama y el diccionario usan los mismos nombres.
```

---

## 12 / CIERRE DE OPERACIÓN

La defensa del diseño comienza con una decisión que haya dividido al equipo. Expliquen las alternativas consideradas, la regla del problema que usaron para decidir y la consecuencia de su elección sobre la integridad o la trazabilidad.

**Tiempo de exposición: 2 minutos.**  
**Tiempo de preguntas: 2 minutos.**

```text
UNA BASE DE DATOS NO SE DEFIENDE POR LA CANTIDAD DE TABLAS.
SE DEFIENDE POR LOS HECHOS QUE PUEDE CONSERVAR
Y POR LOS DATOS INCORRECTOS QUE SABE RECHAZAR.
```
