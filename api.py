from flask import Flask, jsonify
from flask_cors import CORS
import mysql.connector


app = Flask(__name__)
CORS(app)

@app.route('/api/tickets', methods=['GET'])
def obtener_tickets():
    try:
        conexion = mysql.connector.connect( 
        host="localhost",
        user="root",
        password="ingrese_supassword", #Aqui debe ingresar la password, no pude importarlo con el otro config_db
        database="astrobot_db"
        )
        cursor = conexion.cursor(dictionary=True)
        
        #Lee
        query = "SELECT DISTINCT ID_Sesion, Mensaje_Usuario FROM Logs WHERE Intencion_Detectada = 'escalado_humano'"
        
        cursor.execute(query)
        tickets = cursor.fetchall()
        
        cursor.close()
        conexion.close()
        
        return jsonify(tickets)
        
    except Exception as error:
        # Imprime los errores si los hay 
        print(f" ERROR  EN LA API: {str(error)}")
        return jsonify({"error": str(error)}), 500
    
@app.route('/api/historial/<id_sesion>', methods=['GET'])
def obtener_historial(id_sesion):
    try:
        conexion = mysql.connector.connect(
            host="localhost", user="root", password="1234", database="astrobot_db"
        )
        cursor = conexion.cursor(dictionary=True)
        
        #Trae los mensajes por sesión. 
        query = "SELECT Mensaje_Usuario AS Mensaje, Remitente FROM Logs WHERE ID_Sesion = %s ORDER BY ID_Log ASC"
        
        cursor.execute(query, (id_sesion,))
        mensajes = cursor.fetchall()
        
        cursor.close()
        conexion.close()
        
        return jsonify(mensajes)
        
    except Exception as error:
        return jsonify({"error": str(error)}), 500

if __name__ == '__main__':
    print("API de AstroBot encendida")
    app.run(port=5000, debug=True)