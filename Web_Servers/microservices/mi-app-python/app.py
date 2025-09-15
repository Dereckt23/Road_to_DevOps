from flask import Flask, jsonify, request
import time
import random
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({
        'mensaje': '¡Saludos desde Python!',
        'servidor': 'Flask + Gunicorn',
        'timestamp': datetime.now().isoformat(),
        'estado': 'Calculando el sentido de la vida... 42 🐍'
    })

@app.route('/ciencia')
def ciencia():
    inicio = time.time()
    
    # Simulamos experimento científico complejo
    resultado = sum(random.random() for _ in range(1000000))
    
    tiempo = (time.time() - inicio) * 1000
    
    return jsonify({
        'experimento': 'Generación de números aleatorios a gran escala',
        'resultado': round(resultado, 2),
        'tiempo_ms': round(tiempo, 2),
        'conclusion': 'Python sigue siendo genial para ciencia 🔬'
    })

@app.route('/machine-learning')
def ml():
    # Simulamos un modelo ML súper avanzado
    time.sleep(0.1)  # Tiempo de "entrenamiento"
    
    prediccion = random.choice([
        "Mañana va a llover códigos",
        "El bug se solucionará solo",
        "Necesitas más café",
        "El deployment será exitoso",
        "Stack Overflow tendrá la respuesta"
    ])
    
    return jsonify({
        'modelo': 'PrediccionesRandomas v1.0',
        'prediccion': prediccion,
        'confianza': f"{random.randint(85, 99)}%",
        'disclaimer': 'Esta predicción es tan buena como cualquier otra 🤖'
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3000)
