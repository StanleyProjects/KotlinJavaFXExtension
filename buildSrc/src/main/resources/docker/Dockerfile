FROM kepocnhh/debianex-jdk14.0.1-gradle6.5:0.0.1

COPY . /build
WORKDIR /build

ENV RESOURCES_PATH=buildSrc/src/main/resources
RUN chmod +x $RESOURCES_PATH/script/pipeline.sh && ./$RESOURCES_PATH/script/pipeline.sh
