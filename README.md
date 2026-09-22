#Fundamentos de SQL SELECT y Alias — TechStore
Este repositorio contiene las consultas SQL básicas requeridas por el equipo de finanzas de TechStore para el análisis de la tabla sales.

Preguntas Teóricas
1. ¿Por qué es mala práctica usar SELECT * en producción?
Rendimiento y costo: Fuerza a la base de datos a leer y transferir absolutamente todas las columnas por la red. Si la tabla tiene millones de filas o columnas pesadas, esto ralentiza la aplicación y consume ancho de banda innecesario.
Mantenibilidad y estabilidad: Si en el futuro se añade, elimina o cambia el orden de una columna en la base de datos, el código de la aplicación que consume ese SELECT * puede romperse inesperadamente.
2. ¿Por qué son importantes los alias para un stakeholder no técnico?
Los perfiles de negocio (como el equipo de finanzas) no conocen la estructura interna ni los nombres técnicos de la base de datos. Los alias actúan como un traductor automático.

Ejemplo concreto: Una columna llamada total_amount puede generar dudas sobre si incluye impuestos, descuentos o qué moneda es. Al transformarla con un alias a monto_total_pesos o monto_facturado, cualquier persona de finanzas entiende el reporte al instante sin necesidad de pedir ayuda a un programador.



# LEFT, RIGHT y FULL OUTER JOIN: analizando inventario y ventas de una tienda minorista

¿Por qué usaste **`LEFT JOIN`** para la Consulta 1 y no **`INNER JOIN`**? ¿Qué se perdería si usaras **`INNER JOIN`**?
Use LEFT JOIN en la consulta para que muestre todo el catálogo y detecte los productos inactivos (los que nunca se vendieron). Si hubiera usado un **`INNER JOIN`**, esos productos inactivos habrían desaparecido por completo de la pantalla porque no tienen ninguna venta asociada, y no habríamos podido detectar el problema.

¿Por qué usaste **`RIGHT JOIN`** para la Consulta 2? ¿Qué tabla está a la izquierda y cuál a la derecha en tu consulta?
Use **`RIGHT JOIN`** para detectar cuáles eran los registros huérfanos, o sea, las ventas de productos que no figuraban en el catálogo. En mi consulta, la tabla productos está a la izquierda y la tabla ventas está a la derecha.

3. ¿Qué representan los valores **`NULL`** en cada resultado?

En este ejercicio, los valores **`NULL`** significan que un dato **no tiene pareja** en la otra tabla:

* **En la Consulta 1:** Que `venta_id` sea `NULL` en el **Hub USB-C (108)** y el **Parlante (109)** significa que el producto existe en el catálogo, pero **nunca se vendió** (nadie lo compró).
* **En la Consulta 2:** Que los datos del catálogo sean `NULL` en la **venta ID 10** significa que se registró una venta con el producto **999**, el cual **no existe en el sistema** (un error de carga del cajero).

### 4. ¿Cuándo usarías FULL OUTER JOIN en un caso real de negocio?

Un **`FULL OUTER JOIN`** se usa en la vida real para hacer una **auditoría completa o conciliación entre dos listas importantes**, cuando necesitás ver todo el panorama de un solo golpe.

El ejemplo más común en una empresa es la **conciliación bancaria**: cruzar la lista de **gastos que anotaste internamente** contra la lista de **movimientos reales del banco**. 

Esto te permite ver en una sola pantalla:
1. Los gastos que coinciden perfectamente en ambos lados.
2. Los gastos que vos anotaste pero que el banco aún no cobró (el lado del banco sale en `NULL`).
3. Las comisiones que el banco te cobró de sorpresa pero que vos todavía no habías anotado (tu lado interno sale en `NULL`).

Aunque este comando no sirve para cualquier gestor de SQL, ya que en motores como **MySQL** da un error de sintaxis al no estar soportado nativamente, en esos casos se soluciona simulándolo mediante la unión vertical de un `LEFT JOIN` y un `RIGHT JOIN` utilizando la cláusula **`UNION`**.


---

# UNION y UNION ALL: Consolidando inventario de múltiples sucursales — RetailChain

### 1. ¿Cuántas filas devuelve cada consulta y por qué son distintas?
* **Consulta 1 (UNION):** Devuelve menos filas (10 filas) porque elimina los registros duplicados. Los productos que estaban repetidos en ambas sucursales con los mismos datos (como el Monitor 4K o el Teclado) se unieron en una sola fila.
* **Consulta 2 (UNION ALL):** Devuelve más filas (11 filas) porque no filtra nada; simplemente junta y muestra absolutamente todos los registros físicos de stock de ambas sucursales, manteniendo los duplicados.

### 2. ¿Por qué UNION ALL es más eficiente que UNION?
**UNION ALL** es mucho más veloz y eficiente porque agarra las tablas y las pega una abajo de la otra directamente. En cambio, **UNION** obliga al motor de la base de datos a realizar un paso extra: ordenar toda la información y comparar fila por fila para encontrar y borrar los duplicados, lo que consume mucha más memoria y recursos del sistema.

### 3. ¿En qué casos de negocio usarías cada uno?
* **Usaría UNION para:** Crear un catálogo unificado de clientes únicos de la empresa combinando los datos de la sucursal física y la tienda online, evitando que un cliente que compra en ambos lados aparezca repetido.
* **Usaría UNION ALL para:** Un reporte financiero de auditoría para contar el total de facturas emitidas en todo el año juntando los registros de cada mes, donde necesito ver absolutamente todo y no quiero que se borre nada.

### 4. ¿Qué pasa si las columnas de ambas consultas no coinciden en número o tipo?
Si las consultas no coinciden en la cantidad de columnas o en sus tipos de datos en el mismo orden, **SQL arroja un error de sintaxis** y la consulta no se ejecuta. Para que las uniones verticales funcionen, la estructura de los `SELECT` debe ser un espejo exacto de ambos lados.


