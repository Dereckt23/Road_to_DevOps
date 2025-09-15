const express = require('express');
const app = express();
const port = 3000;

// Middleware para logging (porque somos profesionales)
app.use((req, res, next) => {
    console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
    next();
});

// Ruta principal
app.get('/', (req, res) => {
    res.json({
        mensaje: '¡Hola desde Node.js!',
        servidor: 'Express.js',
        timestamp: new Date().toISOString(),
        estado: 'Funcionando como un reloj suizo 🕐'
    });
});

// Ruta para simular trabajo pesado
app.get('/trabajo-pesado', (req, res) => {
    const inicio = Date.now();
    
    // Simulamos trabajo intensivo
    let resultado = 0;
    for(let i = 0; i < 1000000; i++) {
        resultado += Math.random();
    }
    
    const tiempo = Date.now() - inicio;
    
    res.json({
        mensaje: 'Trabajo completado',
        resultado: resultado.toFixed(2),
        tiempo_ms: tiempo,
        comentario: 'Node.js manejando matemáticas como campeón 💪'
    });
});

app.listen(port, () => {
    console.log(`🚀 Servidor Node.js corriendo en http://localhost:${port}`);
});

