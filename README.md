# Astrobot
SUM 3 Support Chatbot

Acceso a la Base de datos: 
Para que AstroBot pueda conectarse a la base de datos en su computadora, es necesario configurar sus credenciales locales de MySQL:

1. Importe el archivo `database_backup.sql` en su gestor de MySQL.
2. Abra el archivo llamado `config_db.py` ubicado en la carpeta principal.
3. Modifique la variable `DB_PASSWORD` colocando la contraseña de su usuario `root` de MySQL local.

Para ejecutar AstroBot en un entorno local , es necesario contar con Python 3.10.0 instalado en el sistema.

TODO ESTO Desde PowerShell
Para que el bot funcione se debe crear un entorno virtual: python -m venv venv
Luego se debe activar el entorno virtual: .\venv\Scripts\Activate.ps1 
Dentro del entorno virtual debe instalar las siguientes dependencias: 
```bash
pip install rasa==3.6.2
pip install Flask
pip install mysql-connector-python

Ejecución del sistema:  

Astrobot debe tener 3 terninales abiertas para funcionar. 
Con el entorno virtual abierto ejecute estos comando por separado en cada terminal y deje las terminales abiertas
1era terminal:  rasa run actions
2da terminal:  rasa run -m models --enable-api --cors "*"
3era terminal: python api.py 

Una vez que las tres terminales estén corriendo sin errores, el sistema estará completamente operativo:

Para simular al Usuario: Abra el archivo index.html en cualquier navegador web.

Para simular al Agente de Soporte: Abra el archivo admin.html en su navegador para monitorear el triaje y el historial de casos escalados.