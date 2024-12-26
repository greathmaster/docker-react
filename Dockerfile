FROM node:16-alpine AS builder
WORKDIR './app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Prod assests like the built JS will be found in app/build
# This is what we want to copy over to the NGINX server

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html