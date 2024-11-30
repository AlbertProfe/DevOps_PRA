FROM nginx:alpine

# parameters
ARG MAINTAINER
ARG REACT_DIR
ARG REACT_PORT
ENV ENV_MAINTAINER=$MAINTAINER
ENV ENV_REACT_DIR=$REACT_DIR
ENV ENV_REACT_PORT=$REACT_PORT

LABEL maintainer=$ENV_MAINTAINER

COPY $ENV_REACT_DIR/ /usr/share/nginx/html
# RUN echo $(ls  /usr/share/nginx/html)
# RUN echo $(ls  /usr/share/nginx/html/assets)
EXPOSE $ENV_REACT_PORT
CMD ["nginx", "-g", "daemon off;"]
