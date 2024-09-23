import mysql.connector

def ask_DB(query):
    # Establecer la conexión
    connection = mysql.connector.connect(
    host='localhost',
    user='Checkter',
    password='Ajedrez404$',
    database='Pruebas'
    )

    # Verificar si la conexión se estableció correctamente
    if connection.is_connected():

        # Crear un objeto cursor
        cursor = connection.cursor()

        # Ejecutar la consulta
        cursor.execute(query)

        # Obtener todos los resultados de la consulta ejecutada
        resultados = cursor.fetchall()

        # Cerrar el cursor
        cursor.close()
        connection.close()
        return resultados

    else:

        # Cerramos conexion y devolvemos error
        cursor.close()
        connection.close()
        return 'ERROR: Ocurrió un fallo en la conexión.'
    
def insert_DB(query, values):
    # Establecer la conexión
    connection = mysql.connector.connect(
    host='localhost',
    user='Checkter',
    password='Ajedrez404$',
    database='Pruebas'
    )

    # Verificar si la conexión se estableció correctamente
    if connection.is_connected():

        # Crear un objeto cursor
        cursor = connection.cursor()

        # Ejecutar la consulta
        cursor.execute(query, values)

        connection.commit()

        # Cerrar el cursor
        cursor.close()
        connection.close()
        return 'Partida insertada con exito.'

    else:

        # Cerramos conexion y devolvemos error
        cursor.close()
        connection.close()
        return 'ERROR: Ocurrió un fallo en la conexión.'


