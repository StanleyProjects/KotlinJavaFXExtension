FROM kepocnhh/debianex-jdk14.0.1-gradle6.5:0.0.1

COPY . /build
WORKDIR /build

RUN ./buildSrc/src/main/resources/script/pipeline.sh
