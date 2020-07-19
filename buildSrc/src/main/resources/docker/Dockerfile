FROM kepocnhh/debianex-jdk12.0.2-gradle6.5:0.0.1

COPY . /build
WORKDIR /build

RUN ./buildSrc/src/main/resources/script/pipeline.sh
