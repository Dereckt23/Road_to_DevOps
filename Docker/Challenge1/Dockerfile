# Imagen mínima con Node
FROM node:20-alpine

# Creamos un usuario no-root con uid/gid 1001 (para el ejemplo)
RUN addgroup -g 1001 appgroup && adduser -D -u 1001 -G appgroup appuser

WORKDIR /app
COPY server.js .
COPY data_flush.sh .

# Instala tini para manejo elegante de señales (opcional pero recomendado)
RUN apk add --no-cache tini

# Exponemos puerto
EXPOSE 3000

# Por seguridad, la app corre como usuario no-root
USER 1001:1001

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["node", "server.js"]
