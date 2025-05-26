FROM node:20 AS builder
WORKDIR /usr/src/app

COPY package*.json ./

COPY . .

FROM node:20-slim
WORKDIR /usr/src/app

COPY --from=builder /usr/src/app ./

RUN useradd -m appuser
USER appuser

EXPOSE 3000
CMD ["npm", "start"]
