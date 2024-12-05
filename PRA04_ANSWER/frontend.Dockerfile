FROM nginx:alpine

# parameters
ARG MAINTAINER
ARG REACT_DIR
ARG REACT_INTERNAL_PORT

LABEL maintainer=$MAINTAINER

COPY $REACT_DIR /usr/share/nginx/html
RUN echo $(ls  /usr/share/nginx/html)
RUN echo $(ls  /usr/share/nginx/html/assets)
EXPOSE $REACT_INTERNAL_PORT
CMD ["nginx", "-g", "daemon off;"]
