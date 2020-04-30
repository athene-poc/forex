#FROM node:13.3.0 AS compile-image

# RUN npm install -g yarn
#RUN npm install -g @angular/cli
#RUN npm install --save-dev @angular-devkit/build-angular


#WORKDIR /opt/ng
#COPY .npmrc package.json yarn.lock ./
# RUN yarn install
#RUN npm install
#ENV PATH="./node_modules/.bin:$PATH" 

#COPY . ./
#RUN ng build --prod

#FROM nginx
#COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf
#COPY --from=compile-image /opt/ng/dist/app-name /usr/share/nginx/html


FROM node:12.16.1-alpine As builder

WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build --prod
FROM nginx:1.15.8-alpine
COPY --from=builder /usr/src/app/dist/SampleApp/ /usr/share/nginx/html
