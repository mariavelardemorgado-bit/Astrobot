from typing import Any, Text, Dict, List
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from config_db import DB_HOST, DB_USER, DB_PASSWORD, DB_NAME
from rasa_sdk.events import ConversationPaused #Este evento sirve para silenciar a Rasa al momento de escalar a soporte.
import mysql.connector #Para conectar con la base de datos.

# Conecta a la base de datos y se usa en cada funcion.
def conectar_db():
    return mysql.connector.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_NAME
    )


# Esta funcion busca los datos en la tabla MYSQL de Conocimiento_Faq
class ActionBuscarFAQ(Action):
    def name(self) -> Text:
        return "action_buscar_faq"

    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: dict) -> list:

        id_sesion = tracker.sender_id #Con estas variables se coloca un tracker al sender_id establecido en el html con el script
        mensaje_usuario = tracker.latest_message.get('text') #Esta extrae el mensaje del usuario
        intent_detectado = tracker.latest_message['intent'].get('name') #Detecta la intención y el nombre establecido en el nlu

        # Esto captura los slots con get (Si los hay) si no los hay coloca un guion
        slot_navegador = tracker.get_slot("navegador") or "-"
        slot_sistema_operativo = tracker.get_slot("sistema_operativo") or "-"

        try:
            conexion = conectar_db() #Accede usando la función auxiliar
            cursor = conexion.cursor()

            #Lector en mysql, se usa la consulta SELECT, resultado se fija con fetchone para que pueda leer todas las consultas
            query_select = "SELECT Respuesta FROM Conocimiento_FAQ WHERE Intencion = %s"
            cursor.execute(query_select, (intent_detectado,))
            resultado = cursor.fetchone()

            respuesta_bot = ""
            if resultado: #Si se encuentra el resultado, entonces se responde con la faq directamente
                respuesta_bot = resultado[0]
                dispatcher.utter_message(text=respuesta_bot)
            else:
                respuesta_bot = "Lo siento, no tengo la respuesta exacta para eso en mi base de conocimiento."
                dispatcher.utter_message(text=respuesta_bot)

            # Se guarda el log
            try:
                # Se inserta el log en la sesión del usuario donde coincida la búsqueda
                cursor.execute("INSERT IGNORE INTO sesion_usuario (ID_Sesion) VALUES (%s)", (id_sesion,))

                query_insert = """
                    INSERT INTO Logs (ID_Sesion, Mensaje_Usuario, Intencion_Detectada, Respuesta_Bot, Navegador, Sistema_Operativo)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """
                valores_log = (id_sesion, mensaje_usuario, intent_detectado, respuesta_bot, slot_navegador, slot_sistema_operativo) #Todos los datos insertados.
                cursor.execute(query_insert, valores_log)
                conexion.commit()
                print(f"--- Log técnico guardado con éxito para intención: {intent_detectado} ---") #Esto es visible en el panel de rasa run actions

            except mysql.connector.Error as e_log:
                print(f"Error guardando el log de la FAQ: {e_log}") #Si no se logra guardar también se observa esto en el panel de rasa run actions.

            cursor.close()
            conexion.close()

        except Exception as e:
            print(f"Error General en ActionBuscarFAQ: {str(e)}")
            dispatcher.utter_message(text="Tuve un pequeño problema consultando mi base de datos de conocimiento.") #Si por alguna razón no puede acceder a la base de datos, entonces tiene este control de errores.

        return []


# Esta función recopila los slots del usuario al reportar una falla y guarda el log inmediatamente
class ActionTriaje(Action):
    def name(self) -> Text:
        return "action_triaje"

    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        id_sesion = tracker.sender_id #Tracker del sender_id establecido en el html
        mensaje_usuario = tracker.latest_message.get('text') #Extrae el mensaje del usuario
        intent_detectado = tracker.latest_message['intent'].get('name') #Detecta la intención del nlu

        # Captura los slots disponibles al momento del triaje (Si los hay) si no los hay coloca un guion
        slot_navegador = tracker.get_slot("navegador") or "-"
        slot_sistema_operativo = tracker.get_slot("sistema_operativo") or "-"

        respuesta_bot = "Entendido, hemos registrado los datos de tu falla. Un agente revisará tu caso."

        try:
            conexion = conectar_db() #Accede usando la función auxiliar
            cursor = conexion.cursor()

            # Se inserta la sesión del usuario si no existe aún
            cursor.execute("INSERT IGNORE INTO sesion_usuario (ID_Sesion) VALUES (%s)", (id_sesion,))

            query_insert = """
                INSERT INTO Logs (ID_Sesion, Mensaje_Usuario, Intencion_Detectada, Respuesta_Bot, Navegador, Sistema_Operativo)
                VALUES (%s, %s, %s, %s, %s, %s)
            """
            valores_log = (id_sesion, mensaje_usuario, intent_detectado, respuesta_bot, slot_navegador, slot_sistema_operativo) #Todos los datos del triaje insertados.
            cursor.execute(query_insert, valores_log)
            conexion.commit()
            print(f"--- Triaje registrado con éxito para sesión: {id_sesion} | Navegador: {slot_navegador} | SO: {slot_sistema_operativo} ---") #Visible en el panel de rasa run actions

            cursor.close()
            conexion.close()

        except mysql.connector.Error as error:
            print(f"Error guardando el triaje en MySQL: {error}")

        dispatcher.utter_message(text=respuesta_bot)
        return []


# Esta función escala a soporte para el triaje
class ActionEscalarHumano(Action):
    def name(self) -> Text:
        return "action_escalar_humano"

    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        id_sesion = tracker.sender_id
        mensaje_usuario = tracker.latest_message.get('text') #Si el mensaje que obtuvo coincide con la intención de transferir entonces lo escala
        respuesta_bot = "Transfiriendo tu caso a un agente de soporte técnico. Por favor, espera..."

        # Captura los slots igual que en ActionBuscarFAQ (Si los hay) si no los hay coloca un guion
        slot_navegador = tracker.get_slot("navegador") or "-"
        slot_sistema_operativo = tracker.get_slot("sistema_operativo") or "-"

        # Nuevamente lo registra en mysql
        try:
            conexion = conectar_db() #Accede usando la función auxiliar
            cursor = conexion.cursor()

            query_padre = "INSERT IGNORE INTO sesion_usuario (ID_Sesion) VALUES (%s)"
            cursor.execute(query_padre, (id_sesion,))

            query_insert = """
                INSERT INTO Logs (ID_Sesion, Mensaje_Usuario, Intencion_Detectada, Respuesta_Bot, Navegador, Sistema_Operativo)
                VALUES (%s, %s, %s, %s, %s, %s)
            """
            
            valores = (id_sesion, mensaje_usuario, "escalado_humano", respuesta_bot, slot_navegador, slot_sistema_operativo)

            cursor.execute(query_insert, valores)
            conexion.commit()
            print(f"--- ALERTA: Sesión {id_sesion} marcada en MySQL como ESCALADA ---")

            cursor.close()
            conexion.close()

        except mysql.connector.Error as error:
            print(f"Error al guardar el escalado en MySQL: {error}")

        #Con este mensaje se le avisa al usuario, la respuesta está establecida en este código python y también en el domain como buena práctica de rasa.
        dispatcher.utter_message(text=respuesta_bot)
        return [ConversationPaused()] #Retorna el paused para poder callar el bot al momento de hablar con soporte