### STAGE 1: Build ###
FROM registry.access.redhat.com/ubi8/nodejs-12:latest AS build
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

### STAGE 2: Run ###
FROM registry.redhat.io/rhel8/nginx-116
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/aston-villa-app /usr/share/nginx/html
CMD ["/usr/libexec/s2i/run"]
